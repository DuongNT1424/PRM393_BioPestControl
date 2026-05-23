import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_event.dart';
import 'package:prm393_biopestcontrol/shared/widgets/management_drawer.dart';
import '../bloc/feedback_bloc.dart';
import '../bloc/feedback_event.dart';
import '../bloc/feedback_state.dart';
import '../widgets/feedback_card.dart';
import '../widgets/feedback_form_dialog.dart';
import '../widgets/reply_form_dialog.dart';
import '../../domain/entities/feedback.dart';

class FeedbackPage extends StatefulWidget {
  final AuthEntity user;
  const FeedbackPage({super.key, required this.user});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> with SingleTickerProviderStateMixin {
  final TextEditingController _searchController = TextEditingController();
  late final TabController _tabController;

  String _searchQuery = '';
  int _selectedRating = 0; // 0 represents "All"
  bool _onlyMyFeedbacks = false;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    _tabController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      setState(() {
        _searchQuery = value.trim().toLowerCase();
      });
    });
  }

  List<FeedbackEntity> _filterFeedbacks(List<FeedbackEntity> feedbacks) {
    return feedbacks.where((fb) {
      // 1. Filter by search query
      if (_searchQuery.isNotEmpty) {
        final titleMatch = fb.title.toLowerCase().contains(_searchQuery);
        final contentMatch = fb.content.toLowerCase().contains(_searchQuery);
        final authorMatch = fb.customerName.toLowerCase().contains(_searchQuery);
        final emailMatch = fb.customerEmail.toLowerCase().contains(_searchQuery);
        if (!titleMatch && !contentMatch && !authorMatch && !emailMatch) {
          return false;
        }
      }

      // 2. Filter by status (tab selection)
      // tab 0: All, tab 1: Pending, tab 2: Replied
      if (_tabController.index == 1 && fb.status != 'pending') {
        return false;
      }
      if (_tabController.index == 2 && fb.status != 'replied') {
        return false;
      }

      // 3. Filter by rating
      if (_selectedRating > 0 && fb.rating != _selectedRating) {
        return false;
      }

      // 4. Filter by customer's own feedbacks
      if (_onlyMyFeedbacks && fb.customerId != widget.user.id) {
        return false;
      }

      return true;
    }).toList();
  }

  void _showFeedbackForm(BuildContext context, [FeedbackEntity? feedback]) async {
    final result = await showDialog<FeedbackEntity>(
      context: context,
      barrierDismissible: false,
      builder: (_) => FeedbackFormDialog(
        user: widget.user,
        feedback: feedback,
      ),
    );

    if (result != null && mounted) {
      if (feedback == null) {
        context.read<FeedbackBloc>().add(CreateFeedbackEvent(result));
      } else {
        context.read<FeedbackBloc>().add(UpdateFeedbackEvent(result));
      }
    }
  }

  void _showReplyForm(BuildContext context, FeedbackEntity feedback) async {
    final result = await showDialog<String>(
      context: context,
      barrierDismissible: false,
      builder: (_) => ReplyFormDialog(
        existingReply: feedback.replyContent,
      ),
    );

    if (result != null && mounted) {
      context.read<FeedbackBloc>().add(
            ReplyFeedbackEvent(
              feedbackId: feedback.id,
              replyContent: result,
              authorId: widget.user.id ?? '',
              authorName: widget.user.name ?? 'Nhân viên hỗ trợ',
            ),
          );
    }
  }

  void _deleteFeedback(BuildContext context, FeedbackEntity feedback) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc chắn muốn xóa ý kiến phản hồi này không? Hành động này không thể hoàn tác.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              context.read<FeedbackBloc>().add(DeleteFeedbackEvent(feedback.id));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),
            child: const Text('Xóa', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isCustomer = widget.user.role == 'Customer';
    final isStaffOrAdmin = widget.user.role == 'Staff' || widget.user.role == 'Admin';
    final bool isAdmin = widget.user.role?.toLowerCase() == 'admin';

    return BlocProvider(
      create: (context) => di.sl<FeedbackBloc>()..add(const LoadFeedbacksEvent()),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: const Color(0xFFF9FBF9),
          appBar: AppBar(
            title: const Text(
              'Ý Kiến & Hỗ Trợ',
              style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 0.5,
            iconTheme: const IconThemeData(color: AppColors.primaryColor),
            leading: isStaffOrAdmin
                ? Builder(
                    builder: (context) => IconButton(
                      icon: const Icon(Icons.menu),
                      onPressed: () => Scaffold.of(context).openDrawer(),
                      tooltip: 'Mở Menu điều hướng',
                    ),
                  )
                : null,
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(isCustomer ? 165 : 120),
              child: Container(
                color: Colors.white,
                child: Column(
                  children: [
                    // Search Bar and Star Filter
                    Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _searchController,
                              onChanged: _onSearchChanged,
                              decoration: InputDecoration(
                                hintText: 'Tìm kiếm ý kiến...',
                                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
                                prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor, size: 20),
                                suffixIcon: _searchController.text.isNotEmpty
                                    ? IconButton(
                                        icon: const Icon(Icons.clear, size: 18),
                                        onPressed: () {
                                          _searchController.clear();
                                          setState(() {
                                            _searchQuery = '';
                                          });
                                        },
                                      )
                                    : null,
                                filled: true,
                                fillColor: const Color(0xFFF5F5F5),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                                isDense: true,
                                contentPadding: const EdgeInsets.symmetric(vertical: 8),
                              ),
                            ),
                          ),
                          const SizedBox(width: 8),
                          // Rating star filter dropdown
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF5F5F5),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<int>(
                                value: _selectedRating,
                                icon: const Icon(Icons.arrow_drop_down, color: AppColors.primaryColor),
                                style: const TextStyle(fontSize: 13, color: Colors.black87),
                                items: [
                                  const DropdownMenuItem(value: 0, child: Text('Tất cả sao')),
                                  ...List.generate(5, (index) {
                                    final stars = 5 - index;
                                    return DropdownMenuItem(
                                      value: stars,
                                      child: Row(
                                        children: [
                                          Text('$stars'),
                                          const SizedBox(width: 2),
                                          const Icon(Icons.star, color: Colors.amber, size: 14),
                                        ],
                                      ),
                                    );
                                  }),
                                ],
                                onChanged: (value) {
                                  if (value != null) {
                                    setState(() {
                                      _selectedRating = value;
                                    });
                                  }
                                },
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Customer Specific: "My Feedbacks Only" Switch
                    if (isCustomer)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Chỉ hiển thị ý kiến của tôi',
                              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black54),
                            ),
                            Switch.adaptive(
                              value: _onlyMyFeedbacks,
                              activeColor: AppColors.primaryColor,
                              onChanged: (value) {
                                setState(() {
                                  _onlyMyFeedbacks = value;
                                });
                              },
                            ),
                          ],
                        ),
                      ),

                    // Tabs
                    TabBar(
                      controller: _tabController,
                      labelColor: AppColors.primaryColor,
                      unselectedLabelColor: Colors.grey,
                      indicatorColor: AppColors.primaryColor,
                      indicatorWeight: 3,
                      tabs: const [
                        Tab(text: 'Tất cả'),
                        Tab(text: 'Chờ xử lý'),
                        Tab(text: 'Đã phản hồi'),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
          drawer: isStaffOrAdmin
              ? ManagementDrawer(
                  user: widget.user,
                  isAdmin: isAdmin,
                  onLogout: () {
                    context.read<AuthBloc>().add(LogoutRequested());
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                )
              : null,
          body: BlocConsumer<FeedbackBloc, FeedbackState>(
            listener: (context, state) {
              if (state is FeedbackActionSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.primaryColor,
                  ),
                );
                // Reload feedbacks list on action success
                context.read<FeedbackBloc>().add(const LoadFeedbacksEvent());
              } else if (state is FeedbackError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: Colors.redAccent,
                  ),
                );
              }
            },
            builder: (context, state) {
              if (state is FeedbackLoading) {
                return const Center(
                  child: CircularProgressIndicator(color: AppColors.primaryColor),
                );
              }

              if (state is FeedbackLoaded) {
                final filtered = _filterFeedbacks(state.feedbacks);

                if (filtered.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.feedback_outlined, size: 70, color: Colors.grey[300]),
                        const SizedBox(height: 12),
                        Text(
                          'Không tìm thấy ý kiến nào',
                          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final fb = filtered[index];
                    return FeedbackCard(
                      feedback: fb,
                      currentUser: widget.user,
                      onEdit: () => _showFeedbackForm(context, fb),
                      onDelete: () => _deleteFeedback(context, fb),
                      onReply: (existingReply) => _showReplyForm(context, fb),
                    );
                  },
                );
              }

              return const SizedBox();
            },
          ),
          floatingActionButton: isCustomer
              ? FloatingActionButton(
                  onPressed: () => _showFeedbackForm(context),
                  backgroundColor: AppColors.primaryColor,
                  child: const Icon(Icons.add, color: Colors.white),
                )
              : null,
        ),
      ),
    );
  }
}
