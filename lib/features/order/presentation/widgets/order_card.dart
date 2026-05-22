import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import '../../domain/entities/order.dart';

/// Một chip trạng thái giao hàng có thể tái sử dụng cho toàn bộ mô-đun đơn hàng.
class OrderStatusChip extends StatelessWidget {
  final String status;

  const OrderStatusChip({super.key, required this.status});

  @override
  Widget build(BuildContext context) {
    Color color;
    String text;

    switch (status) {
      case 'Pending':
        color = Colors.orange;
        text = 'Chờ xác nhận';
        break;
      case 'Preparing':
        color = Colors.blue;
        text = 'Đang chuẩn bị';
        break;
      case 'Delivering':
        color = Colors.teal;
        text = 'Đang giao';
        break;
      case 'Delivered':
        color = AppColors.primaryColor;
        text = 'Đã giao';
        break;
      case 'Cancelled':
        color = Colors.redAccent;
        text = 'Đã hủy';
        break;
      case 'Returned':
        color = Colors.purple;
        text = 'Đã trả hàng';
        break;
      default:
        color = Colors.grey;
        text = status;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.15)),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.bold),
      ),
    );
  }
}

/// Thẻ thông tin đơn hàng dành riêng cho Khách hàng.
class CustomerOrderCard extends StatelessWidget {
  final OrderEntity order;
  final VoidCallback onTap;

  const CustomerOrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Đơn: #${order.id.length > 8 ? order.id.substring(0, 8).toUpperCase() : order.id.toUpperCase()}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                OrderStatusChip(status: order.deliveryStatus),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Ngày đặt: ${dateFormat.format(order.createdAt)}',
              style: TextStyle(fontSize: 12, color: Colors.grey[500]),
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.shopping_cart_outlined, size: 16, color: Colors.grey[500]),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    order.items.map((e) => e.productName).join(', '),
                    style: TextStyle(fontSize: 13, color: Colors.grey[800]),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${order.items.fold<int>(0, (sum, i) => sum + i.quantity)} sản phẩm',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
                Text(
                  currencyFormat.format(order.totalAmount),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

/// Thẻ thông tin đơn hàng dành riêng cho Admin/Staff trong hệ thống quản trị.
class AdminOrderCard extends StatelessWidget {
  final OrderEntity order;
  final VoidCallback onTap;

  const AdminOrderCard({
    super.key,
    required this.order,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final isPaid = order.paymentStatus == 'Paid';

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
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
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Khách: ${order.customerName}',
                  style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                OrderStatusChip(status: order.deliveryStatus),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'SĐT: ${order.customerPhone}',
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
            ),
            const SizedBox(height: 4),
            Text(
              'Mã đơn: #${order.id.length > 8 ? order.id.substring(0, 8).toUpperCase() : order.id.toUpperCase()}',
              style: TextStyle(fontSize: 12, color: Colors.grey[400]),
            ),
            const SizedBox(height: 12),
            const Divider(height: 1),
            const SizedBox(height: 12),
            Row(
              children: [
                Icon(Icons.schedule, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 6),
                Text(
                  dateFormat.format(order.createdAt),
                  style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                ),
                const Spacer(),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    color: isPaid ? Colors.green[50] : Colors.orange[50],
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    isPaid ? 'Đã Thanh Toán' : 'Chưa Thanh Toán',
                    style: TextStyle(
                      fontSize: 9,
                      fontWeight: FontWeight.bold,
                      color: isPaid ? AppColors.primaryColor : Colors.orange[800],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Hình thức: ${order.paymentMethod}',
                  style: TextStyle(fontSize: 12, color: Colors.grey[500], fontWeight: FontWeight.bold),
                ),
                Text(
                  currencyFormat.format(order.totalAmount),
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
