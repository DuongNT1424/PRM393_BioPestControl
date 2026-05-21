import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'package:prm393_biopestcontrol/core/usecases/usecase.dart';
import 'package:prm393_biopestcontrol/features/customer/domain/entities/customer_entity.dart';
import 'package:prm393_biopestcontrol/features/customer/domain/usecases/get_customers_usecase.dart';
import '../../domain/entities/notification.dart';
import '../bloc/notification_bloc.dart';
import '../bloc/notification_event.dart';
import '../bloc/notification_state.dart';

class SendNotificationPage extends StatefulWidget {
  const SendNotificationPage({super.key});

  @override
  State<SendNotificationPage> createState() => _SendNotificationPageState();
}

class _SendNotificationPageState extends State<SendNotificationPage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _bodyController = TextEditingController();
  
  String _selectedType = 'system'; // 'system', 'order', 'discount', 'expert'
  bool _sendToAll = true;
  CustomerEntity? _selectedCustomer;
  List<CustomerEntity> _customers = [];
  bool _loadingCustomers = false;
  bool _isSending = false; // Tránh việc double tap gửi tin nhiều lần gây crash

  // Danh sách các mẫu thông báo thông minh được thiết kế theo yêu cầu của dự án
  final List<Map<String, String>> _templates = [
    {
      'title': 'Đặt hàng thành công',
      'body': 'Đơn hàng [Mã Đơn] của bạn đã được ghi nhận thành công trên hệ thống BioPestControl. Chúng tôi đang nhanh chóng xử lý sản phẩm.',
      'type': 'order',
    },
    {
      'title': 'Thanh toán thành công',
      'body': 'Giao dịch thanh toán cho đơn hàng [Mã Đơn] đã được xác nhận thành công. Cảm ơn quý khách đã mua sắm sản phẩm sinh học bảo vệ cây trồng!',
      'type': 'order',
    },
    {
      'title': 'Đang chuẩn bị hàng',
      'body': 'Đơn hàng của quý khách đang được đóng gói kỹ lưỡng bởi đội ngũ kỹ thuật của BioPestControl để bảo đảm chất lượng chế phẩm sinh học tốt nhất.',
      'type': 'order',
    },
    {
      'title': 'Đơn hàng đang giao sắp đến',
      'body': 'Đơn hàng đang trên đường vận chuyển và dự kiến sắp giao đến địa chỉ của bạn. Quý khách vui lòng chú ý điện thoại để nhận hàng nhé!',
      'type': 'order',
    },
    {
      'title': 'Giao hàng thành công',
      'body': 'Đơn hàng đã được giao thành công! BioPestControl chúc bạn có một mùa vụ bội thu và an toàn. Vui lòng phản hồi nếu cần chuyên gia tư vấn.',
      'type': 'order',
    },
    {
      'title': 'Chương trình ưu đãi sốc',
      'body': 'BioPestControl tặng ngay mã giảm giá 15% cho tất cả chế phẩm trừ sâu sinh học thế hệ mới. Áp dụng duy nhất trong tuần này!',
      'type': 'discount',
    },
    {
      'title': 'Khuyến mãi đặc quyền VIP',
      'body': 'Nhận ngay Voucher mua sắm trị giá 100k áp dụng cho các đơn hàng mua phân bón hữu cơ sinh học. Click để nhận ưu đãi ngay!',
      'type': 'discount',
    },
    {
      'title': 'Giải đáp tư vấn kỹ thuật',
      'body': 'Chuyên gia của BioPestControl đã gửi phản hồi chi tiết về thắc mắc kỹ thuật nuôi trồng và sử dụng nấm đối kháng của bạn. Xem ngay nhé!',
      'type': 'expert',
    },
    {
      'title': 'Lịch tư vấn chăm sóc trực tiếp',
      'body': 'Lịch tư vấn định kỳ của chuyên gia nông nghiệp sinh học của bạn đã được xác nhận vào lúc 09:00 ngày mai. Hãy chuẩn bị câu hỏi nhé!',
      'type': 'expert',
    },
    {
      'title': 'Bảo trì hệ thống định kỳ',
      'body': 'Ứng dụng BioPestControl sẽ tiến hành nâng cấp hệ thống định kỳ từ 00:00 đến 02:00 ngày mai để nâng cao trải nghiệm giao dịch của bạn.',
      'type': 'system',
    },
  ];

  @override
  void initState() {
    super.initState();
    _loadCustomers();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _bodyController.dispose();
    super.dispose();
  }

  Future<void> _loadCustomers() async {
    setState(() {
      _loadingCustomers = true;
    });
    try {
      final getCustomersUseCase = di.sl<GetCustomersUseCase>();
      final result = await getCustomersUseCase(NoParams());
      result.fold(
        (failure) {
          debugPrint('Error fetching customers: ${failure.message}');
        },
        (customersList) {
          setState(() {
            _customers = customersList;
          });
        },
      );
    } catch (e) {
      debugPrint('Exception fetching customers: $e');
    } finally {
      setState(() {
        _loadingCustomers = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => di.sl<NotificationBloc>(),
      child: Scaffold(
        backgroundColor: Colors.grey.shade50,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          scrolledUnderElevation: 0,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87, size: 20),
            onPressed: _isSending
                ? null
                : () {
                    if (mounted && Navigator.canPop(context)) {
                      Navigator.pop(context);
                    }
                  },
          ),
          title: const Text(
            'Gửi Thông Báo Mới',
            style: TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(height: 1, color: Color(0xFFEEEEEE)),
          ),
        ),
        body: PopScope(
          canPop: !_isSending,
          child: BlocConsumer<NotificationBloc, NotificationState>(
            listener: (context, state) {
              if (state is NotificationActionSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message)),
                );
                // Kiểm tra kỹ mounted, canPop và đặc biệt là isCurrent để tránh pop nhầm trang khác
                if (mounted && ModalRoute.of(context)?.isCurrent == true && Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              } else if (state is NotificationError) {
                setState(() {
                  _isSending = false;
                });
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            final isLoading = state is NotificationLoading;

            return Stack(
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.all(24.0),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Hướng dẫn
                        _buildHelperCard(),
                        const SizedBox(height: 24),

                        // Loại thông báo
                        const Text(
                          'PHÂN LOẠI THÔNG BÁO',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildTypeChips(),
                        const SizedBox(height: 24),

                        // Đối tượng nhận thông báo
                        const Text(
                          'ĐỐI TƯỢNG NHẬN',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildTargetSelector(),
                        const SizedBox(height: 24),

                        // Bộ mẫu soạn thảo nhanh
                        _buildTemplateSelector(),

                        // Form nhập liệu
                        const Text(
                          'NỘI DUNG CHI TIẾT',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.black54,
                            letterSpacing: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        _buildFormFields(),
                        const SizedBox(height: 40),

                        // Button gửi
                        SizedBox(
                          width: double.infinity,
                          height: 52,
                          child: ElevatedButton.icon(
                            onPressed: (isLoading || _isSending) ? null : () => _submitForm(context),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.primaryColor,
                              foregroundColor: Colors.white,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                            ),
                            icon: const Icon(Icons.send_rounded, size: 18),
                            label: const Text(
                              'GỬI THÔNG BÁO',
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1.0,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                if (isLoading)
                  Container(
                    color: Colors.black.withOpacity(0.15),
                    child: const Center(
                      child: CircularProgressIndicator(color: AppColors.primaryColor),
                    ),
                  ),
              ],
            );
          },
        ),
      ),
      ),
    );
  }

  /// Bộ lọc và chọn các mẫu tin nhắn soạn sẵn theo phân loại
  Widget _buildTemplateSelector() {
    final filteredTemplates = _templates.where((element) => element['type'] == _selectedType).toList();
    
    if (filteredTemplates.isEmpty) return const SizedBox.shrink();

    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.auto_awesome, color: Colors.amber, size: 18),
              SizedBox(width: 8),
              Text(
                'MẪU THÔNG BÁO NHANH',
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54,
                  letterSpacing: 1.0,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<Map<String, String>>(
            decoration: InputDecoration(
              hintText: 'Chọn mẫu tin soạn sẵn...',
              hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              fillColor: Colors.grey.shade50,
              filled: true,
            ),
            items: filteredTemplates.map((template) {
              return DropdownMenuItem<Map<String, String>>(
                value: template,
                child: Text(
                  template['title'] ?? '',
                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                ),
              );
            }).toList(),
            onChanged: (template) {
              if (template != null) {
                setState(() {
                  _titleController.text = template['title'] ?? '';
                  _bodyController.text = template['body'] ?? '';
                });
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Đã áp dụng mẫu: ${template['title']}'),
                    duration: const Duration(milliseconds: 800),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHelperCard() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withOpacity(0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.15)),
      ),
      child: const Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.lightbulb_outline, color: AppColors.primaryColor, size: 22),
          SizedBox(width: 12),
          Expanded(
            child: Text(
              'Gửi thông báo tới toàn bộ hệ thống hoặc lựa chọn một khách hàng cụ thể. Thông báo sẽ xuất hiện tức thời trên bảng điều khiển của khách hàng.',
              style: TextStyle(
                fontSize: 13,
                color: Colors.black87,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypeChips() {
    final types = [
      {'key': 'system', 'label': 'Hệ thống', 'icon': Icons.info_outline, 'color': const Color(0xFF6A1B9A)},
      {'key': 'order', 'label': 'Đơn hàng', 'icon': Icons.shopping_bag_outlined, 'color': const Color(0xFF2E7D32)},
      {'key': 'discount', 'label': 'Ưu đãi', 'icon': Icons.local_offer_outlined, 'color': const Color(0xFFE65100)},
      {'key': 'expert', 'label': 'Chuyên gia', 'icon': Icons.psychology_alt_outlined, 'color': const Color(0xFF00838F)},
    ];

    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: types.map((type) {
        final isSelected = _selectedType == type['key'];
        final color = type['color'] as Color;

        return ChoiceChip(
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                type['icon'] as IconData,
                size: 16,
                color: isSelected ? Colors.white : color,
              ),
              const SizedBox(width: 6),
              Text(
                type['label'] as String,
                style: TextStyle(
                  color: isSelected ? Colors.white : Colors.black87,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                  fontSize: 12,
                ),
              ),
            ],
          ),
          selected: isSelected,
          onSelected: (selected) {
            if (selected) {
              setState(() {
                _selectedType = type['key'] as String;
              });
            }
          },
          selectedColor: color,
          backgroundColor: Colors.white,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
            side: BorderSide(
              color: isSelected ? color : Colors.grey.shade300,
              width: 1,
            ),
          ),
          showCheckmark: false,
          elevation: isSelected ? 1 : 0,
        );
      }).toList(),
    );
  }

  Widget _buildTargetSelector() {
    return Container(
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16.0),
        border: Border.all(color: Colors.grey.shade200, width: 1),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ChoiceChip(
                  label: const Center(child: Text('Tất cả khách hàng')),
                  selected: _sendToAll,
                  onSelected: (val) {
                    setState(() {
                      _sendToAll = true;
                      _selectedCustomer = null;
                    });
                  },
                  selectedColor: AppColors.primaryColor.withOpacity(0.12),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: _sendToAll ? AppColors.primaryColor : Colors.grey.shade300),
                  ),
                  labelStyle: TextStyle(
                    color: _sendToAll ? AppColors.primaryColor : Colors.black87,
                    fontWeight: _sendToAll ? FontWeight.bold : FontWeight.w500,
                  ),
                  showCheckmark: false,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ChoiceChip(
                  label: const Center(child: Text('Khách hàng cụ thể')),
                  selected: !_sendToAll,
                  onSelected: (val) {
                    setState(() {
                      _sendToAll = false;
                    });
                  },
                  selectedColor: AppColors.primaryColor.withOpacity(0.12),
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: !_sendToAll ? AppColors.primaryColor : Colors.grey.shade300),
                  ),
                  labelStyle: TextStyle(
                    color: !_sendToAll ? AppColors.primaryColor : Colors.black87,
                    fontWeight: !_sendToAll ? FontWeight.bold : FontWeight.w500,
                  ),
                  showCheckmark: false,
                ),
              ),
            ],
          ),
          if (!_sendToAll) ...[
            const SizedBox(height: 16),
            _loadingCustomers
                ? const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: 24,
                        height: 24,
                        child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.primaryColor),
                      ),
                    ),
                  )
                : DropdownButtonFormField<CustomerEntity>(
                    value: _selectedCustomer,
                    decoration: InputDecoration(
                      hintText: 'Chọn khách hàng...',
                      hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 14),
                      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      fillColor: Colors.white,
                      filled: true,
                    ),
                    items: _customers.map((customer) {
                      return DropdownMenuItem<CustomerEntity>(
                        value: customer,
                        child: Text(
                          '${customer.name} (${customer.email})',
                          style: const TextStyle(fontSize: 13),
                        ),
                      );
                    }).toList(),
                    onChanged: (customer) {
                      setState(() {
                        _selectedCustomer = customer;
                      });
                    },
                    validator: (val) {
                      if (!_sendToAll && val == null) {
                        return 'Vui lòng chọn khách hàng nhận tin';
                      }
                      return null;
                    },
                  ),
          ],
        ],
      ),
    );
  }

  Widget _buildFormFields() {
    return Column(
      children: [
        TextFormField(
          controller: _titleController,
          decoration: InputDecoration(
            labelText: 'Tiêu đề thông báo',
            labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500),
            hintText: 'Ví dụ: Cập nhật đơn hàng #12345',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Tiêu đề không được để trống';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),
        TextFormField(
          controller: _bodyController,
          maxLines: 4,
          decoration: InputDecoration(
            labelText: 'Nội dung thông báo',
            labelStyle: TextStyle(color: Colors.grey.shade600, fontSize: 13, fontWeight: FontWeight.w500),
            hintText: 'Ví dụ: Đơn hàng của bạn đã được đóng gói và bàn giao cho đơn vị vận chuyển...',
            hintStyle: TextStyle(color: Colors.grey.shade400, fontSize: 13),
            contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: AppColors.primaryColor, width: 1.5),
            ),
            fillColor: Colors.white,
            filled: true,
          ),
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Nội dung không được để trống';
            }
            return null;
          },
        ),
      ],
    );
  }

  void _submitForm(BuildContext context) {
    if (_isSending) return;
    
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isSending = true;
      });
      
      final title = _titleController.text.trim();
      final body = _bodyController.text.trim();
      final targetUserId = _sendToAll ? 'all' : (_selectedCustomer?.id ?? '');

      final notification = NotificationEntity(
        id: '', // Firestore tự sinh ID
        title: title,
        body: body,
        type: _selectedType,
        userId: targetUserId,
        isRead: false,
        createdAt: DateTime.now(),
      );

      context.read<NotificationBloc>().add(SendNotificationEvent(notification));
    }
  }
}
