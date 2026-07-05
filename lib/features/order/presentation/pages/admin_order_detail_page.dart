import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import '../../domain/entities/order.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';

class AdminOrderDetailPage extends StatefulWidget {
  final String orderId;

  const AdminOrderDetailPage({super.key, required this.orderId});

  @override
  State<AdminOrderDetailPage> createState() => _AdminOrderDetailPageState();
}

class _AdminOrderDetailPageState extends State<AdminOrderDetailPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return BlocProvider<OrderBloc>(
      create: (context) => di.sl<OrderBloc>()..add(LoadOrderDetailEvent(widget.orderId)),
      child: Builder(
        builder: (context) {
          return Scaffold(
            backgroundColor: const Color(0xFFF8FAFC),
            appBar: AppBar(
              title: const Text('Quản lý chi tiết đơn hàng', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
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
                  // Tải lại chi tiết đơn hàng để đồng bộ giao diện
                  context.read<OrderBloc>().add(LoadOrderDetailEvent(widget.orderId));
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

                  return Column(
                    children: [
                      Expanded(
                        child: ListView(
                          padding: const EdgeInsets.all(24),
                          children: [
                            // Thông tin mã đơn và ngày tạo
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
                                        style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        dateFormat.format(order.createdAt),
                                        style: TextStyle(fontSize: 11, color: Colors.grey[500]),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            // TIẾN TRÌNH XỬ LÝ ĐƠN HÀNG (QUẢN TRỊ VIÊN)
                            _buildAdminActionSection(context, order),
                            const SizedBox(height: 16),
                            // Địa chỉ khách hàng
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
                                  const Text('Thông tin giao nhận khách hàng', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
                                  const SizedBox(height: 12),
                                  Row(
                                    children: [
                                      Icon(Icons.person_outline, size: 18, color: Colors.grey[600]),
                                      const SizedBox(width: 8),
                                      Text(order.customerName, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(Icons.phone_outlined, size: 18, color: Colors.grey[600]),
                                      const SizedBox(width: 8),
                                      Text(order.customerPhone, style: const TextStyle(fontSize: 13)),
                                    ],
                                  ),
                                  const SizedBox(height: 8),
                                  Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(Icons.location_on_outlined, size: 18, color: Colors.grey[600]),
                                      const SizedBox(width: 8),
                                      Expanded(child: Text(order.shippingAddress, style: const TextStyle(fontSize: 13, height: 1.4))),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Danh sách sản phẩm mua
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
                                  const Text('Sản phẩm đã chọn', style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryColor)),
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
                                            child: Image.network(
                                              item.imageUrl != null && item.imageUrl!.isNotEmpty
                                                  ? item.imageUrl!
                                                  : 'https://images.unsplash.com/photo-1628157588553-5eeea00af15c?auto=format&fit=crop&q=80&w=150',
                                              width: 45,
                                              height: 45,
                                              fit: BoxFit.cover,
                                              errorBuilder: (context, error, stackTrace) => const Icon(Icons.image, size: 45, color: Colors.grey),
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  item.productName,
                                                  style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                                                  maxLines: 1,
                                                  overflow: TextOverflow.ellipsis,
                                                ),
                                                const SizedBox(height: 4),
                                                Text(
                                                  'SKU: ${item.sku}  |  SL: ${item.quantity}',
                                                  style: TextStyle(fontSize: 10, color: Colors.grey[500]),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Text(
                                            currencyFormat.format(item.price * item.quantity),
                                            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
                                          ),
                                        ],
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            // Tóm tắt tiền tệ
                            Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.grey[100]!),
                              ),
                              padding: const EdgeInsets.all(20),
                              child: Column(
                                children: [
                                  _buildSummaryRow('Hình thức thanh toán', order.paymentMethod),
                                  _buildSummaryRow('Tổng số lượng sản phẩm', '${order.items.fold<int>(0, (sum, i) => sum + i.quantity)} cái'),
                                  const Divider(height: 24),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      const Text('TỔNG SỐ TIỀN THU HỘ', style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
                                      Text(
                                        currencyFormat.format(order.totalAmount),
                                        style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                }

                return const Center(child: Text('Không tải được thông tin đơn hàng.'));
              },
            ),
          );
        }
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey)),
          Text(value, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.black87)),
        ],
      ),
    );
  }

  Widget _buildAdminActionSection(BuildContext context, OrderEntity order) {
    Color statusColor;
    String statusText;
    IconData statusIcon;

    switch (order.deliveryStatus) {
      case 'Pending':
        statusColor = Colors.orange;
        statusText = 'Chờ xác nhận';
        statusIcon = Icons.receipt_long;
        break;
      case 'Preparing':
        statusColor = Colors.blue;
        statusText = 'Đang chuẩn bị sản phẩm';
        statusIcon = Icons.handyman;
        break;
      case 'Delivering':
        statusColor = Colors.teal;
        statusText = 'Đang giao hàng';
        statusIcon = Icons.local_shipping_outlined;
        break;
      case 'Delivered':
        statusColor = AppColors.primaryColor;
        statusText = 'Đã giao hàng thành công';
        statusIcon = Icons.task_alt;
        break;
      case 'Cancelled':
        statusColor = Colors.redAccent;
        statusText = 'Đơn hàng đã hủy';
        statusIcon = Icons.cancel_outlined;
        break;
      case 'Returned':
        statusColor = Colors.purple;
        statusText = 'Đơn hàng đã hoàn trả';
        statusIcon = Icons.keyboard_return_rounded;
        break;
      default:
        statusColor = Colors.grey;
        statusText = order.deliveryStatus;
        statusIcon = Icons.info_outline;
    }

    final isPaid = order.paymentStatus == 'Paid';

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[100]!),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.01),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Tiến trình xử lý đơn hàng',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
          ),
          const SizedBox(height: 16),
          // Thẻ trạng thái hiện tại
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: statusColor.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: statusColor.withValues(alpha: 0.15)),
            ),
            child: Row(
              children: [
                Icon(statusIcon, color: statusColor, size: 20),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'Trạng thái hiện tại:',
                        style: TextStyle(fontSize: 11, color: Colors.grey, fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        statusText,
                        style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold, color: statusColor),
                      ),
                    ],
                  ),
                ),
                // Hiển thị trạng thái thanh toán bên cạnh
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isPaid ? Colors.green[50] : Colors.orange[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isPaid ? 'ĐÃ THANH TOÁN' : 'CHƯA THANH TOÁN',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: isPaid ? AppColors.primaryColor : Colors.orange[800],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          // Các nút hành động thông minh dựa trên trạng thái hiện tại
          _buildActionButtons(context, order),
        ],
      ),
    );
  }

  Widget _buildActionButtons(BuildContext context, OrderEntity order) {
    if (order.deliveryStatus == 'Delivered') {
      return Row(
        children: [
          const Icon(Icons.check_circle, color: AppColors.primaryColor, size: 18),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Đơn hàng đã hoàn thành xuất sắc!',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
          ),
        ],
      );
    }

    if (order.deliveryStatus == 'Cancelled') {
      return Row(
        children: [
          const Icon(Icons.cancel, color: Colors.redAccent, size: 18),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Đơn hàng này đã bị hủy.',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey),
            ),
          ),
        ],
      );
    }

    if (order.deliveryStatus == 'Returned') {
      return Row(
        children: [
          const Icon(Icons.keyboard_return_rounded, color: Colors.purple, size: 18),
          const SizedBox(width: 8),
          const Expanded(
            child: Text(
              'Đơn hàng này đã được hoàn trả thành công.',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.purple),
            ),
          ),
        ],
      );
    }

    // Các trạng thái còn lại: Pending, Preparing, Delivering
    String buttonText = '';
    String nextStatus = '';
    IconData buttonIcon = Icons.arrow_forward;
    Color buttonColor = AppColors.primaryColor;

    if (order.deliveryStatus == 'Pending') {
      buttonText = 'XÁC NHẬN & CHUẨN BỊ SẢN PHẨM';
      nextStatus = 'Preparing';
      buttonIcon = Icons.thumb_up_alt_outlined;
      buttonColor = Colors.blue;
    } else if (order.deliveryStatus == 'Preparing') {
      buttonText = 'BẮT ĐẦU GIAO HÀNG';
      nextStatus = 'Delivering';
      buttonIcon = Icons.local_shipping_outlined;
      buttonColor = Colors.teal;
    } else if (order.deliveryStatus == 'Delivering') {
      buttonText = 'XÁC NHẬN ĐÃ GIAO THÀNH CÔNG';
      nextStatus = 'Delivered';
      buttonIcon = Icons.task_alt;
      buttonColor = AppColors.primaryColor;
    }

    final showCancelButton = order.deliveryStatus == 'Pending' || order.deliveryStatus == 'Preparing';

    return Column(
      children: [
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: () {
              // Khi chuyển sang Delivered (thành công), tự động đánh dấu thanh toán là Paid
              final paymentStatus = (nextStatus == 'Delivered') ? 'Paid' : order.paymentStatus;
              _updateOrderState(context, deliveryStatus: nextStatus, paymentStatus: paymentStatus);
            },
            icon: Icon(buttonIcon, size: 18),
            label: Text(buttonText, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold)),
            style: ElevatedButton.styleFrom(
              backgroundColor: buttonColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
          ),
        ),
        // Nút Hủy đơn phụ (nếu là Pending hoặc Preparing)
        if (showCancelButton) ...[
          const SizedBox(height: 12),
          SizedBox(
            width: double.infinity,
            child: OutlinedButton.icon(
              onPressed: () => _showCancelConfirmationDialog(context),
              icon: const Icon(Icons.cancel_outlined, size: 16),
              label: const Text('HỦY ĐƠN HÀNG NÀY', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
              style: OutlinedButton.styleFrom(
                foregroundColor: Colors.redAccent,
                side: const BorderSide(color: Colors.redAccent),
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              ),
            ),
          ),
        ],
        // Dòng cập nhật trạng thái thanh toán riêng biệt (nếu chưa thanh toán và chưa giao thành công)
        if (order.deliveryStatus != 'Delivered' && order.paymentStatus == 'Pending') ...[
          const Divider(height: 32),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                'Thanh toán chưa hoàn tất:',
                style: TextStyle(fontSize: 12, color: Colors.grey, fontWeight: FontWeight.w500),
              ),
              ElevatedButton.icon(
                onPressed: () {
                  _updateOrderState(context, deliveryStatus: order.deliveryStatus, paymentStatus: 'Paid');
                },
                icon: const Icon(Icons.check, size: 14),
                label: const Text('XÁC NHẬN ĐÃ THANH TOÁN', style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold)),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor.withValues(alpha: 0.1),
                  foregroundColor: AppColors.primaryColor,
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
                  elevation: 0,
                ),
              ),
            ],
          ),
        ],
      ],
    );
  }

  void _updateOrderState(BuildContext context, {required String deliveryStatus, String? paymentStatus}) {
    context.read<OrderBloc>().add(UpdateOrderStatusEvent(
          orderId: widget.orderId,
          deliveryStatus: deliveryStatus,
          paymentStatus: paymentStatus,
        ));
  }

  void _showCancelConfirmationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Xác nhận hủy đơn hàng', style: TextStyle(fontWeight: FontWeight.bold)),
        content: const Text('Bạn có chắc chắn muốn hủy đơn hàng này không? Hành động này không thể hoàn tác.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Quay lại', style: TextStyle(color: Colors.grey)),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(ctx);
              _updateOrderState(context, deliveryStatus: 'Cancelled');
            },
            child: const Text('Xác nhận hủy', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}
