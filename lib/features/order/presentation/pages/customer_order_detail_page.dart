import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import '../../domain/entities/order.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_state.dart';
import 'package:prm393_biopestcontrol/features/feedback/domain/entities/feedback.dart';
import 'package:prm393_biopestcontrol/features/feedback/presentation/pages/feedback_page.dart';
import 'package:prm393_biopestcontrol/features/feedback/presentation/bloc/feedback_bloc.dart';
import 'package:prm393_biopestcontrol/features/feedback/presentation/bloc/feedback_event.dart';
import 'package:prm393_biopestcontrol/features/feedback/presentation/bloc/feedback_state.dart';
import 'package:prm393_biopestcontrol/features/feedback/presentation/widgets/feedback_form_dialog.dart';

class CustomerOrderDetailPage extends StatefulWidget {
  final String orderId;

  const CustomerOrderDetailPage({super.key, required this.orderId});

  @override
  State<CustomerOrderDetailPage> createState() => _CustomerOrderDetailPageState();
}

class _CustomerOrderDetailPageState extends State<CustomerOrderDetailPage> {
  bool _needsRefresh = false;

  @override
  void initState() {
    super.initState();
  }

  void _cancelOrder(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Hủy đơn hàng', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Bạn có chắc chắn muốn hủy đơn hàng này không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Quay lại', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // Dispatch sự kiện cập nhật trạng thái sang Cancelled
              context.read<OrderBloc>().add(UpdateOrderStatusEvent(
                    orderId: widget.orderId,
                    deliveryStatus: 'Cancelled',
                  ));
            },
            child: const Text('Xác nhận hủy', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return BlocProvider<OrderBloc>(
      create: (context) => di.sl<OrderBloc>()..add(LoadOrderDetailEvent(widget.orderId)),
      child: Builder(
        builder: (context) {
          return PopScope(
            canPop: false,
            onPopInvokedWithResult: (didPop, result) {
              if (didPop) return;
              Navigator.of(context).pop(_needsRefresh);
            },
            child: Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            appBar: AppBar(
              title: const Text('Chi tiết đơn hàng', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              backgroundColor: Colors.white,
              foregroundColor: Colors.black87,
              elevation: 0,
              centerTitle: true,
            ),
            body: BlocConsumer<OrderBloc, OrderState>(
              listener: (context, state) {
                if (state is OrderActionSuccess) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message), backgroundColor: AppColors.primaryColor),
                  );
                  // Tải lại chi tiết đơn hàng sau khi cập nhật thành công
                  context.read<OrderBloc>().add(LoadOrderDetailEvent(widget.orderId));
                  // Đặt cờ needsRefresh = true để notify parent khi pop
                  _needsRefresh = true;
                }
                if (state is OrderError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(state.message), backgroundColor: Colors.redAccent),
                  );
                }
              },
              builder: (context, state) {
                if (state is OrderLoading) {
                  return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                }

                if (state is OrderDetailLoaded) {
                  final order = state.order;
                  final isPending = order.deliveryStatus == 'Pending';
                  final isCancelled = order.deliveryStatus == 'Cancelled';

                  return Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(24),
                          children: [
                            // Header Card
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[100]!),
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Mã ĐH: #${order.id.toUpperCase()}',
                                        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        dateFormat.format(order.createdAt),
                                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 16),
                                  const Divider(height: 1),
                                  const SizedBox(height: 16),
                                  // Hiển thị trạng thái giao hàng / Timeline hành trình
                                  if (isCancelled)
                                    _buildCancelledHeader()
                                  else if (order.deliveryStatus == 'Returned')
                                    _buildReturnedHeader()
                                  else
                                    _buildTimelineProgress(order.deliveryStatus),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Địa chỉ giao hàng
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[100]!),
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Địa chỉ giao hàng', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Icon(Icons.person_outline, size: 18, color: Colors.grey[600]),
                                      const SizedBox(width: 8),
                                      Text(order.customerName, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.phone_outlined, size: 18, color: Colors.grey[600]),
                                      const SizedBox(width: 8),
                                      Text(order.customerPhone, style: const TextStyle(fontSize: 14)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.location_on_outlined, size: 18, color: Colors.grey[600]),
                                      const SizedBox(width: 8),
                                      Expanded(child: Text(order.shippingAddress, style: const TextStyle(fontSize: 14, height: 1.4))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Chính sách hoàn trả & Hành động
                            if (order.deliveryStatus == 'Delivered' || order.deliveryStatus == 'Returned')
                              _buildReturnPolicySection(context, order),
                             if (order.deliveryStatus == 'Delivered') ...[
                               const SizedBox(height: 16),
                               _buildFeedbackSection(context, order),
                             ],
                             const SizedBox(height: 16),
                            // Danh sách sản phẩm
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[100]!),
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Sản phẩm đã mua', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                                  const SizedBox(height: 16),
                                  ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemCount: order.items.length,
                                    separatorBuilder: (context, index) => const Padding(
                                      padding: EdgeInsets.symmetric(vertical: 12),
                                      child: Divider(height: 1),
                                    ),
                                    itemBuilder: (context, idx) {
                                      final item = order.items[idx];
                                      return Row(
                                        children: [
                                          ClipRRect(
                                            borderRadius: BorderRadius.circular(8),
                                            child: Container(
                                              width: 50,
                                              height: 50,
                                              color: Colors.grey[100],
                                              child: item.imageUrl != null
                                                  ? Image.network(item.imageUrl!, fit: BoxFit.cover)
                                                  : const Icon(Icons.image_outlined, color: Colors.grey),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.productName,
                                                  style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                                  maxLines: 2,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'SKU: ${item.sku}',
                                                  style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                                                ),
                                                const SizedBox(height: 4),
                                                 Text(
                                                   'SL: ${item.quantity}',
                                                   style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                 ),
                                                 if (order.deliveryStatus == 'Delivered') ...[
                                                   const SizedBox(height: 6),
                                                   InkWell(
                                                     onTap: () {
                                                       _showProductFeedbackDialog(context, item);
                                                     },
                                                     child: const Row(
                                                       children: [
                                                         Icon(Icons.rate_review_outlined, size: 14, color: AppColors.primaryColor),
                                                         SizedBox(width: 4),
                                                         Text(
                                                           'Viết đánh giá',
                                                           style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                                                         ),
                                                       ],
                                                     ),
                                                   ),
                                                 ],
                                              ],
                                            ),
                                          ),
                                          const SizedBox(width: 8),
                                          Text(
                                            currencyFormat.format(item.price),
                                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Chi tiết thanh toán
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[100]!),
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text('Chi tiết thanh toán', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                                  const SizedBox(height: 16),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Phương thức', style: TextStyle(fontSize: 13, color: Colors.grey)),
                                      Text(
                                        order.paymentMethod == 'COD' ? 'Thanh toán COD' : 'Ví điện tử PayOS',
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Trạng thái', style: TextStyle(fontSize: 13, color: Colors.grey)),
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                        decoration: BoxDecoration(
                                          color: (order.paymentStatus == 'Paid' ? AppColors.primaryColor : Colors.orange).withValues(alpha: 0.08),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          order.paymentStatus == 'Paid' ? 'Đã thanh toán' : 'Chờ thanh toán',
                                          style: TextStyle(
                                            color: order.paymentStatus == 'Paid' ? AppColors.primaryColor : Colors.orange,
                                            fontSize: 11,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: 12),
                                  const Divider(height: 1),
                                  const SizedBox(height: 12),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('Thành tiền', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                      Text(
                                        currencyFormat.format(order.totalAmount),
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 24),
                            if (isPending)
                              SafeArea(
                                child: Padding(
                                  padding: const EdgeInsets.all(24),
                                  child: SizedBox(
                                    width: double.infinity,
                                    child: OutlinedButton(
                                      onPressed: () => _cancelOrder(context),
                                      style: OutlinedButton.styleFrom(
                                        foregroundColor: Colors.redAccent,
                                        side: const BorderSide(color: Colors.redAccent),
                                        padding: const EdgeInsets.symmetric(vertical: 16),
                                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                      ),
                                      child: const Text('HỦY ĐƠN HÀNG', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                return const Center(child: Text('Không tìm thấy dữ liệu đơn hàng.'));
              },
            ),
          ), // đóng Scaffold
          ); // đóng PopScope
        }
      ),
    );
  }

  Widget _buildCancelledHeader() {
    return Row(
      children: [
        Icon(Icons.cancel, color: Colors.redAccent[100], size: 24),
        const SizedBox(width: 12),
        const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Đơn hàng đã hủy', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.redAccent)),
            SizedBox(height: 2),
            Text('Yêu cầu hủy đơn hàng đã được ghi nhận', style: TextStyle(fontSize: 11, color: Colors.grey)),
          ],
        ),
      ],
    );
  }

  Widget _buildTimelineProgress(String deliveryStatus) {
    final List<String> steps = ['Pending', 'Preparing', 'Delivering', 'Delivered'];
    final currentIdx = steps.indexOf(deliveryStatus);

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(steps.length, (idx) {
            final step = steps[idx];
            final isActive = idx <= currentIdx;

            Color iconColor = Colors.grey[300]!;
            IconData iconData = Icons.circle;

            if (isActive) {
              iconColor = AppColors.primaryColor;
              if (step == 'Pending') iconData = Icons.receipt_long;
              if (step == 'Preparing') iconData = Icons.handyman;
              if (step == 'Delivering') iconData = Icons.local_shipping;
              if (step == 'Delivered') iconData = Icons.task_alt;
            }

            return Expanded(
              child: Row(
                children: [
                  Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: isActive ? AppColors.primaryColor.withValues(alpha: 0.08) : Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(color: isActive ? AppColors.primaryColor : Colors.grey[300]!, width: 2),
                    ),
                    child: Center(
                      child: Icon(iconData, size: 16, color: iconColor),
                    ),
                  ),
                  if (idx < steps.length - 1)
                    Expanded(
                      child: Container(
                        height: 2,
                        color: idx < currentIdx ? AppColors.primaryColor : Colors.grey[200]!,
                      ),
                    ),
                ],
              ),
            );
          }),
        ),
        const SizedBox(height: 12),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text('Chờ xác nhận', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black87)),
            Text('Chuẩn bị', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black87)),
            Text('Đang giao', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black87)),
            Text('Đã giao', style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, color: Colors.black87)),
          ],
        ),
      ],
    );
  }



  Widget _buildReturnedHeader() {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: Colors.purple.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(Icons.keyboard_return_rounded, color: Colors.purple, size: 24),
          ),
        ),
        const SizedBox(width: 16),
        const Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Đã hoàn trả đơn hàng', style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: Colors.purple)),
              SizedBox(height: 4),
              Text('Đơn hàng đã được trả hàng và hoàn tiền thành công', style: TextStyle(fontSize: 12, color: Colors.grey)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildReturnPolicySection(BuildContext context, OrderEntity order) {
    if (order.deliveryStatus != 'Delivered' && order.deliveryStatus != 'Returned') {
      return const SizedBox();
    }

    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    if (order.deliveryStatus == 'Returned') {
      return Container(
        decoration: BoxDecoration(
          color: Colors.purple[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.purple[100]!),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.keyboard_return_rounded, color: Colors.purple[800], size: 20),
                const SizedBox(width: 8),
                Text(
                  'Thông tin hoàn trả hàng',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple[800]),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Đơn hàng của quý khách đã hoàn tất quy trình trả hàng & hoàn tiền. Số tiền ${currencyFormat.format(order.totalAmount)} đã được hoàn trả lại theo phương thức thanh toán ban đầu.',
              style: TextStyle(fontSize: 13, height: 1.5, color: Colors.purple[900]),
            ),
          ],
        ),
      );
    }

    // Nếu deliveryStatus == 'Delivered'
    final difference = DateTime.now().difference(order.deliveredAt ?? order.createdAt).inDays;
    final isPaid = order.paymentStatus == 'Paid';
    final canReturn = isPaid && difference <= 7;

    if (canReturn) {
      return Container(
        decoration: BoxDecoration(
          color: Colors.purple.withValues(alpha: 0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.purple.withValues(alpha: 0.15)),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.assignment_return_outlined, color: Colors.purple[800], size: 20),
                const SizedBox(width: 8),
                Text(
                  'Chính sách trả hàng (Hạn còn lại: ${7 - difference} ngày)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.purple[800]),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Đơn hàng này hiện đủ điều kiện hoàn trả. Quý khách có thể gửi yêu cầu trả hàng và hoàn tiền trong vòng 7 ngày kể từ khi đặt hàng thành công.',
              style: TextStyle(fontSize: 12, height: 1.4, color: Colors.purple[900]),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showReturnConfirmationDialog(context),
                icon: const Icon(Icons.keyboard_return_rounded, size: 16),
                label: const Text('YÊU CẦU TRẢ HÀNG / HOÀN TIỀN', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.purple[800],
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  elevation: 0,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Giải thích lý do cụ thể tại sao không thể trả hàng
      String reason = '';
      if (!isPaid) {
        reason = 'Đơn hàng chưa hoàn tất thanh toán nên không thể yêu cầu trả hàng.';
      } else if (difference > 7) {
        final expiryDate = order.createdAt.add(const Duration(days: 7));
        reason = 'Đơn hàng đã vượt quá thời hạn đổi trả 7 ngày quy định (Thời hạn đổi trả đến hết ngày: ${dateFormat.format(expiryDate)}).';
      }

      return Container(
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.info_outline, color: Colors.grey[600], size: 20),
                const SizedBox(width: 8),
                const Text(
                  'Chính sách trả hàng (Đã khóa)',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(
              reason,
              style: TextStyle(fontSize: 12, height: 1.4, color: Colors.grey[600]),
            ),
          ],
        ),
      );
    }
  }

  void _showReturnConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Yêu cầu trả hàng & hoàn tiền', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text(
          'Quý khách có chắc chắn muốn yêu cầu trả hàng cho đơn hàng này không? \n\nSau khi gửi yêu cầu, hệ thống sẽ chuyển trạng thái đơn hàng sang "Đã trả hàng" và nhân viên sẽ liên hệ quý khách để thực hiện thủ tục hoàn tiền.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Quay lại', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              // Dispatch sự kiện cập nhật trạng thái đơn hàng sang Returned
              context.read<OrderBloc>().add(UpdateOrderStatusEvent(
                    orderId: widget.orderId,
                    deliveryStatus: 'Returned',
                  ));
            },
            child: const Text('Gửi yêu cầu', style: TextStyle(color: Colors.purple, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }

  Widget _buildFeedbackSection(BuildContext context, OrderEntity order) {
    if (order.deliveryStatus != 'Delivered') {
      return const SizedBox();
    }

    return Container(
      decoration: BoxDecoration(
        color: AppColors.primaryColor.withValues(alpha: 0.04),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.primaryColor.withValues(alpha: 0.15)),
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: const [
              Icon(Icons.rate_review_outlined, color: AppColors.primaryColor, size: 20),
              SizedBox(width: 8),
              Text(
                'Đóng góp ý kiến & phản hồi',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            'Đơn hàng đã được giao thành công! Quý khách có thể gửi ý kiến, đánh giá chất lượng sản phẩm & dịch vụ để giúp chúng tôi cải thiện tốt hơn.',
            style: TextStyle(fontSize: 12, height: 1.4, color: Colors.grey[700]),
          ),
          const SizedBox(height: 16),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: () {
                final authState = context.read<AuthBloc>().state;
                if (authState is Authenticated) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => FeedbackPage(user: authState.user),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Vui lòng đăng nhập để gửi ý kiến phản hồi')),
                  );
                }
              },
              icon: const Icon(Icons.feedback_outlined, size: 16),
              label: const Text('GỬI Ý KIẾN PHẢN HỒI', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showProductFeedbackDialog(BuildContext context, OrderItemEntity item) async {
    final authState = context.read<AuthBloc>().state;
    if (authState is! Authenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng đăng nhập để gửi ý kiến phản hồi')),
      );
      return;
    }

    final messenger = ScaffoldMessenger.of(context);

    final result = await showDialog<FeedbackEntity>(
      context: context,
      barrierDismissible: false,
      builder: (_) => FeedbackFormDialog(
        user: authState.user,
        productId: item.productId,
        productName: item.productName,
      ),
    );

    if (result != null && mounted) {
      final feedbackBloc = di.sl<FeedbackBloc>();
      late final StreamSubscription subscription;
      subscription = feedbackBloc.stream.listen((state) {
        if (state is FeedbackActionSuccess) {
          if (mounted) {
            messenger.showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          }
          subscription.cancel();
          feedbackBloc.close();
        } else if (state is FeedbackError) {
          if (mounted) {
            messenger.showSnackBar(
              SnackBar(
                content: Text('Lỗi: ${state.message}'),
                backgroundColor: Colors.redAccent,
              ),
            );
          }
          subscription.cancel();
          feedbackBloc.close();
        }
      });

      feedbackBloc.add(CreateFeedbackEvent(result));
    }
  }
}
