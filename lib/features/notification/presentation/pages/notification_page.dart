import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';
import '../widgets/notification_card.dart';


class NotificationPage extends StatefulWidget {
  final AuthEntity user;

  const NotificationPage({super.key, required this.user});

  @override
  State<NotificationPage> createState() => _NotificationPageState();
}

class _NotificationPageState extends State<NotificationPage> {
  String _selectedFilter = 'all'; // 'all', 'order', 'discount', 'system', 'expert'

  @override
  Widget build(BuildContext context) {
    final userId = widget.user.id ?? '';

    return BlocProvider(
      create: (context) => di.sl<NotificationBloc>()..add(LoadNotificationsEvent(userId)),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
            onPressed: () {
              if (mounted && Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
          ),
          title: const Text(
            'Thông Báo',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 20,
            ),
          ),
          actions: [
            BlocBuilder<NotificationBloc, NotificationState>(
              builder: (context, state) {
                if (state is NotificationLoaded) {
                  final hasUnread = state.notifications.any((element) => !element.isRead);
                  if (hasUnread) {
                    return TextButton.icon(
                      onPressed: () {
                        context.read<NotificationBloc>().add(MarkAllAsReadEvent(userId));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text('Đã đánh dấu tất cả thông báo là đã đọc'),
                            duration: Duration(seconds: 1),
                          ),
                        );
                      },
                      icon: const Icon(Icons.done_all, size: 16, color: AppColors.primaryColor),
                      label: const Text(
                        'Đọc tất cả',
                        style: TextStyle(
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                        ),
                      ),
                    );
                  }
                }
                return const SizedBox.shrink();
              },
            ),
          ],
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1, color: Color(0xFFEEEEEE)),
          ),
        ),
        body: Column(
          children: [
            // Filter list
            _buildFilterTabs(),
            
            // Notification List View
            Expanded(
              child: BlocConsumer<NotificationBloc, NotificationState>(
                buildWhen: (previous, current) {
                  return current is NotificationLoading || current is NotificationLoaded || current is NotificationError;
                },
                listener: (context, state) {
                  if (state is NotificationError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text(state.message)),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is NotificationLoading) {
                    return _buildShimmerLoading();
                  }

                  if (state is NotificationLoaded) {
                    // Lọc danh sách theo filter được chọn
                    final filteredNotifications = state.notifications.where((element) {
                      if (_selectedFilter == 'all') return true;
                      return element.type.toLowerCase() == _selectedFilter;
                    }).toList();

                    if (filteredNotifications.isEmpty) {
                      return _buildEmptyState();
                    }

                    return RefreshIndicator(
                      color: AppColors.primaryColor,
                      onRefresh: () async {
                        context.read<NotificationBloc>().add(LoadNotificationsEvent(userId));
                      },
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16.0),
                        itemCount: filteredNotifications.length,
                        itemBuilder: (context, index) {
                          final notification = filteredNotifications[index];
                          return NotificationCard(
                            notification: notification,
                            onTap: () {
                              if (!notification.isRead) {
                                context.read<NotificationBloc>().add(MarkAsReadEvent(notification.id));
                              }
                            },
                            onDelete: () {
                              context.read<NotificationBloc>().add(DeleteNotificationEvent(notification.id));
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Đã xóa thông báo'),
                                  duration: Duration(seconds: 1),
                                ),
                              );
                            },
                          );
                        },
                      ),
                    );
                  }

                  return _buildEmptyState();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Bộ lọc thông báo dạng Tab trượt ngang sang trọng
  Widget _buildFilterTabs() {
    final filters = [
      {'key': 'all', 'label': 'Tất cả'},
      {'key': 'order', 'label': 'Đơn hàng'},
      {'key': 'discount', 'label': 'Ưu đãi'},
      {'key': 'system', 'label': 'Hệ thống'},
      {'key': 'expert', 'label': 'Chuyên gia'},
    ];

    return Container(
      height: 60,
      color: Colors.white,
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: filters.length,
        itemBuilder: (context, index) {
          final filter = filters[index];
          final isSelected = _selectedFilter == filter['key'];
          
          return Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ChoiceChip(
              label: Text(
                filter['label']!,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.grey.shade700,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 12,
                ),
              ),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedFilter = filter['key']!;
                  });
                }
              },
              selectedColor: AppColors.primaryColor,
              backgroundColor: Colors.grey.shade100,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected ? AppColors.primaryColor : Colors.transparent,
                ),
              ),
              showCheckmark: false,
              elevation: isSelected ? 2 : 0,
            ),
          );
        },
      ),
    );
  }

  /// Giao diện trống (Empty State) với phong cách cao cấp
  Widget _buildEmptyState() {
    final String titleText;
    final String subText;
    final IconData iconData;
    final Color iconColor;

    switch (_selectedFilter) {
      case 'order':
        titleText = 'Chưa có đơn hàng nào';
        subText = 'Thông tin cập nhật trạng thái đơn hàng của bạn sẽ xuất hiện ở đây.';
        iconData = Icons.shopping_bag_outlined;
        iconColor = const Color(0xFF2E7D32);
        break;
      case 'discount':
        titleText = 'Săn ngay khuyến mãi hot';
        subText = 'Đừng bỏ lỡ các phiếu mua hàng và chương trình giảm giá sắp tới.';
        iconData = Icons.local_offer_outlined;
        iconColor = const Color(0xFFE65100);
        break;
      case 'expert':
        titleText = 'Chưa có lời khuyên chuyên gia';
        subText = 'Tư vấn kỹ thuật nuôi trồng và phản hồi của chuyên gia sẽ hiển thị tại đây.';
        iconData = Icons.psychology_alt_outlined;
        iconColor = const Color(0xFF00838F);
        break;
      case 'system':
      default:
        titleText = 'Hộp thư trống trải';
        subText = 'Bạn chưa nhận được thông báo nào thuộc danh mục này.';
        iconData = Icons.mail_outline_outlined;
        iconColor = const Color(0xFF6A1B9A);
        break;
    }

    return Center(
      child: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 40.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                color: iconColor.withOpacity(0.08),
                shape: BoxShape.circle,
              ),
              child: Icon(
                iconData,
                size: 48,
                color: iconColor,
              ),
            ),
            const SizedBox(height: 24),
            Text(
              titleText,
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              subText,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 13,
                color: Colors.grey.shade500,
                height: 1.5,
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Shimmer loading đẹp mắt mô tả danh sách đang tải
  Widget _buildShimmerLoading() {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      itemCount: 4,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 12.0),
          padding: const EdgeInsets.all(16.0),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16.0),
            border: Border.all(color: Colors.grey.shade100, width: 1),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                decoration: BoxDecoration(
                  color: Colors.grey.shade100,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      width: 150,
                      height: 16,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      width: double.infinity,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    const SizedBox(height: 6),
                    Container(
                      width: 200,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.grey.shade100,
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
