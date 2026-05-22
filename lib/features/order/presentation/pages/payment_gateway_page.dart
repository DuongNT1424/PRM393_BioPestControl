import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import 'customer_order_detail_page.dart';

class PaymentGatewayPage extends StatelessWidget {
  final String orderId;
  final double totalAmount;

  const PaymentGatewayPage({
    super.key,
    required this.orderId,
    required this.totalAmount,
  });

  void _simulatePaymentSuccess(BuildContext context) {
    // Cập nhật trạng thái thanh toán thành "Paid" và giao hàng vẫn là "Pending" (chờ duyệt)
    context.read<OrderBloc>().add(UpdateOrderStatusEvent(
          orderId: orderId,
          deliveryStatus: 'Pending',
          paymentStatus: 'Paid',
        ));
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

    return Scaffold(
      backgroundColor: const Color(0xFFF1F5F9), // Màu xám nhạt cao cấp
      appBar: AppBar(
        title: const Text('Cổng thanh toán PayOS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false, // Ngăn khách hàng bấm back tự ý hủy luồng
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Xác nhận giao dịch chuyển khoản thành công!'), backgroundColor: AppColors.primaryColor),
            );
            // Chuyển hướng sang chi tiết đơn hàng để xem cập nhật thời gian thực
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => CustomerOrderDetailPage(orderId: orderId),
              ),
            );
          }
          if (state is OrderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.redAccent),
            );
          }
        },
        builder: (context, state) {
          final isProcessing = state is OrderLoading;

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.all(24),
                child: Column(
                  children: [
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.04), blurRadius: 10, offset: const Offset(0, 4)),
                        ],
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          const Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(Icons.qr_code_scanner, color: AppColors.primaryColor, size: 24),
                              SizedBox(width: 8),
                              Text(
                                'QUÉT MÃ QR ĐỂ THANH TOÁN',
                                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, color: AppColors.primaryColor, letterSpacing: 0.5),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          // Giả lập mã QR chuyển khoản ngân hàng đẹp mắt
                          Container(
                            width: 200,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[200]!, width: 2),
                            ),
                            padding: const EdgeInsets.all(12),
                            child: Stack(
                              alignment: Alignment.center,
                              children: [
                                // Các chấm giả lập QR Code
                                Image.network(
                                  'https://images.unsplash.com/photo-1543269865-cbf427effbad?q=80&w=200&auto=format&fit=crop', // Ảnh minh họa QR
                                  fit: BoxFit.cover,
                                  width: 180,
                                  height: 180,
                                  errorBuilder: (_, __, ___) => const Icon(Icons.qr_code, size: 150, color: Colors.black87),
                                ),
                                // Icon VietQR ở giữa mã QR
                                Container(
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(4),
                                    boxShadow: [
                                      BoxShadow(color: Colors.black12, blurRadius: 4),
                                    ],
                                  ),
                                  padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                  child: const Text(
                                    'VietQR',
                                    style: TextStyle(fontSize: 8, fontWeight: FontWeight.bold, color: Colors.blue),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            currencyFormat.format(totalAmount),
                            style: const TextStyle(fontSize: 26, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Nội dung CK: BIOPEST${orderId.length > 6 ? orderId.substring(0, 6).toUpperCase() : orderId.toUpperCase()}',
                            style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: Colors.grey[600]),
                          ),
                          const SizedBox(height: 24),
                          const Divider(height: 1),
                          const SizedBox(height: 16),
                          _buildDetailRow('Tên Ngân Hàng', 'VietinBank (ICB)'),
                          _buildDetailRow('Tên Tài Khoản', 'CONG TY TNHH BIOPEST CONTROL VN'),
                          _buildDetailRow('Số Tài Khoản', '1098 7654 3210'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.yellow[50],
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.yellow[300]!),
                      ),
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        children: [
                          const Icon(Icons.info_outline, color: Colors.orange),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              'Hệ thống tự động đồng bộ giao dịch. Sau khi chuyển khoản thành công, bạn sẽ nhận được thông báo trạng thái.',
                              style: TextStyle(fontSize: 12, color: Colors.orange[900], height: 1.4),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 32),
                    // Nút giả lập thanh toán
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: isProcessing ? null : () => _simulatePaymentSuccess(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          foregroundColor: Colors.white,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                          elevation: 0,
                        ),
                        child: const Text('GIẢ LẬP CHUYỂN KHOẢN THÀNH CÔNG', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                    ),
                    const SizedBox(height: 16),
                    // Nút quay lại/hủy đơn hàng
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: isProcessing
                            ? null
                            : () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Đã quay lại danh sách đơn hàng. Vui lòng thanh toán sau.')),
                                );
                                Navigator.popUntil(context, (route) => route.isFirst);
                              },
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                          side: const BorderSide(color: Colors.redAccent),
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                        ),
                        child: const Text('HUỶ GIAO DỊCH / THANH TOÁN SAU', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 13)),
                      ),
                    ),
                  ],
                ),
              ),
              if (isProcessing)
                Container(
                  color: Colors.black12,
                  child: const Center(
                    child: CircularProgressIndicator(color: AppColors.primaryColor),
                  ),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDetailRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: const TextStyle(fontSize: 13, color: Colors.grey, fontWeight: FontWeight.bold)),
          Text(value, style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }
}
