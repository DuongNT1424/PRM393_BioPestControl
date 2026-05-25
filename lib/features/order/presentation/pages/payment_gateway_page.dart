import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../data/datasources/payos_service.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import 'customer_order_detail_page.dart';

class PaymentGatewayPage extends StatefulWidget {
  final String orderId;
  final double totalAmount;

  const PaymentGatewayPage({
    super.key,
    required this.orderId,
    required this.totalAmount,
  });

  @override
  State<PaymentGatewayPage> createState() => _PaymentGatewayPageState();
}

class _PaymentGatewayPageState extends State<PaymentGatewayPage> with SingleTickerProviderStateMixin {
  bool _isCreatingLink = true;
  String? _checkoutUrl;
  String? _errorMessage;
  Timer? _pollingTimer;
  int _orderCode = 0;
  
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _orderCode = widget.orderId.hashCode.abs();
    
    // Khởi tạo animation mượt mà cho hiệu ứng phát sáng quét QR
    _animationController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    
    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    // Bắt đầu tạo liên kết thanh toán PayOS thật
    _initiatePayOSPayment();
  }

  @override
  void dispose() {
    _pollingTimer?.cancel();
    _animationController.dispose();
    super.dispose();
  }

  /// Gọi API PayOS để tạo link thanh toán thật
  Future<void> _initiatePayOSPayment() async {
    setState(() {
      _isCreatingLink = true;
      _errorMessage = null;
    });

    try {
      final desc = 'Thanh toan DH $_orderCode';
      final paymentData = await PayOSService.createPaymentLink(
        amount: widget.totalAmount.toInt(),
        description: desc.length > 25 ? desc.substring(0, 25) : desc, // Đảm bảo an toàn dưới 25 kí tự theo quy định PayOS
        orderCode: _orderCode,
        cancelUrl: 'https://google.com', // Link chuyển hướng khi hủy
        returnUrl: 'https://google.com', // Link chuyển hướng khi thành công
      );

      final checkoutUrl = paymentData['checkoutUrl'] as String;

      setState(() {
        _checkoutUrl = checkoutUrl;
        _isCreatingLink = false;
      });

      // Tự động mở liên kết thanh toán trên trình duyệt của khách hàng
      _openCheckoutUrl(checkoutUrl);

      // Bắt đầu quét (polling) trạng thái thanh toán từ PayOS
      _startPollingPaymentStatus();
    } catch (e) {
      setState(() {
        _isCreatingLink = false;
        _errorMessage = e.toString().replaceAll('Exception:', '');
      });
    }
  }

  /// Mở liên kết thanh toán bằng url_launcher
  Future<void> _openCheckoutUrl(String url) async {
    final uri = Uri.parse(url);
    try {
      // Gọi trực tiếp launchUrl để bỏ qua giới hạn package visibility của Android 11+
      final success = await launchUrl(uri, mode: LaunchMode.externalApplication);
      if (!success) {
        // Dự phòng mở bằng phương thức mặc định của nền tảng
        await launchUrl(uri, mode: LaunchMode.platformDefault);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Không thể tự động mở trình duyệt. Vui lòng nhấn nút bên dưới hoặc sao chép link.'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  /// Quét định kỳ trạng thái thanh toán từ cổng PayOS mỗi 3 giây
  void _startPollingPaymentStatus() {
    _pollingTimer?.cancel();
    _pollingTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      try {
        final status = await PayOSService.checkPaymentStatus(_orderCode);
        
        if (status == 'PAID') {
          timer.cancel();
          _onPaymentSuccessful();
        } else if (status == 'CANCELLED') {
          timer.cancel();
          if (!mounted) return;
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Bạn đã hủy thanh toán đơn hàng trên hệ thống PayOS.'), backgroundColor: Colors.redAccent),
          );
        }
      } catch (e) {
        // Bỏ qua lỗi kết nối tạm thời trong lúc polling để tránh gây gián đoạn trải nghiệm người dùng
        debugPrint('Polling error: $e');
      }
    });
  }

  /// Khi hệ thống xác thực thanh toán thành công
  void _onPaymentSuccessful() {
    if (!mounted) return;
    
    // Cập nhật trạng thái thanh toán đơn hàng thành "Paid" trên Firestore
    context.read<OrderBloc>().add(UpdateOrderStatusEvent(
          orderId: widget.orderId,
          deliveryStatus: 'Pending',
          paymentStatus: 'Paid',
        ));
  }

  /// Giả lập thanh toán thành công (dành cho chế độ Sandbox/Test nhanh không cần chuyển khoản thật)
  void _simulatePaymentSuccess() {
    _pollingTimer?.cancel();
    _onPaymentSuccessful();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC), // Tone xám nhạt hiện đại và mát mắt
      appBar: AppBar(
        title: const Text('Cổng thanh toán PayOS', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false, // Ngăn khách hàng bấm back tự ý làm hỏng luồng đặt hàng
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderActionSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Xác nhận giao dịch thanh toán thành công!'), backgroundColor: AppColors.primaryColor),
            );
            // Chuyển hướng sang chi tiết đơn hàng
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (_) => CustomerOrderDetailPage(orderId: widget.orderId),
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
          final isUpdatingFirestore = state is OrderLoading;

          return Stack(
            children: [
              SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Card hiển thị thông tin chính của đơn hàng
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 15, offset: const Offset(0, 6)),
                        ],
                      ),
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        children: [
                          // Biểu tượng trạng thái động
                          if (_isCreatingLink)
                            const SizedBox(
                              height: 60,
                              width: 60,
                              child: CircularProgressIndicator(color: AppColors.primaryColor, strokeWidth: 3),
                            )
                          else if (_errorMessage != null)
                            const Icon(Icons.error_outline, color: Colors.redAccent, size: 60)
                          else
                            ScaleTransition(
                              scale: _pulseAnimation,
                              child: Container(
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                padding: const EdgeInsets.all(16),
                                child: const Icon(Icons.qr_code_scanner, color: AppColors.primaryColor, size: 36),
                              ),
                            ),
                          const SizedBox(height: 20),
                          
                          Text(
                            _isCreatingLink
                                ? 'ĐANG KHỞI TẠO HOÁ ĐƠN...'
                                : (_errorMessage != null ? 'KHÔNG THỂ TẠO HOÁ ĐƠN' : 'ĐANG CHỜ THANH TOÁN...'),
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: _errorMessage != null ? Colors.redAccent : AppColors.primaryColor,
                              letterSpacing: 1.0,
                            ),
                          ),
                          const SizedBox(height: 12),
                          
                          Text(
                            currencyFormat.format(widget.totalAmount),
                            style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.black87),
                          ),
                          const SizedBox(height: 6),
                          
                          Text(
                            'Mã hóa đơn: #$_orderCode',
                            style: TextStyle(fontSize: 13, color: Colors.grey[500], fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 24),
                          const Divider(height: 1),
                          const SizedBox(height: 20),
                          
                          // Chi tiết thông tin chuyển khoản VietQR PayOS
                          _buildDetailRow('Đơn vị tích hợp', 'Cổng thanh toán PayOS'),
                          _buildDetailRow('Nội dung CK', 'Thanh toan DH $_orderCode'),
                          _buildDetailRow('Hệ thống xử lý', 'Tự động kiểm tra (Real-time)'),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),

                    // Panel Hướng dẫn / Trạng thái
                    if (_isCreatingLink)
                      _buildInfoPanel('Vui lòng đợi trong giây lát. Hệ thống đang tạo hóa đơn và mã QR VietQR bảo mật từ PayOS...')
                    else if (_errorMessage != null)
                      _buildErrorPanel()
                    else
                      Column(
                        children: [
                          _buildInfoPanel('Hệ thống đã tự động kết nối và mở cổng PayOS. Nếu trình duyệt không tự động mở, vui lòng nhấn nút bên dưới để thanh toán.'),
                          const SizedBox(height: 24),
                          
                          // Nút mở cổng thanh toán PayOS
                          SizedBox(
                            width: double.infinity,
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.primaryColor.withOpacity(0.25),
                                    blurRadius: 12,
                                    offset: const Offset(0, 4),
                                  ),
                                ],
                              ),
                              child: ElevatedButton.icon(
                                onPressed: () {
                                  if (_checkoutUrl != null) {
                                    _openCheckoutUrl(_checkoutUrl!);
                                  }
                                },
                                icon: const Icon(Icons.open_in_browser, size: 20),
                                label: const Text('MỞ TRÌNH DUYỆT THANH TOÁN', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 18),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  elevation: 0,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),

                    const SizedBox(height: 40),
                    const Text(
                      'HỖ TRỢ KIỂM THỬ ĐỒ ÁN (SANDBOX)',
                      style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold, color: Colors.grey, letterSpacing: 0.5),
                    ),
                    const SizedBox(height: 12),
                    
                    // Nút giả lập thanh toán nhanh cho nhà phát triển/giảng viên test
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: isUpdatingFirestore || _isCreatingLink ? null : _simulatePaymentSuccess,
                        icon: const Icon(Icons.offline_pin_outlined, size: 18),
                        label: const Text('GIẢ LẬP THANH TOÁN THÀNH CÔNG', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.teal,
                          side: const BorderSide(color: Colors.teal),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(height: 12),

                    // Nút hủy giao dịch quay về cửa hàng
                    SizedBox(
                      width: double.infinity,
                      child: OutlinedButton.icon(
                        onPressed: isUpdatingFirestore
                            ? null
                            : () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Đơn hàng đã được lưu. Bạn có thể thanh toán lại sau trong mục Lịch sử đơn hàng.')),
                                );
                                Navigator.popUntil(context, (route) => route.isFirst);
                              },
                        icon: const Icon(Icons.arrow_back, size: 18),
                        label: const Text('QUAY LẠI TRANG CHỦ / THANH TOÁN SAU', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.redAccent,
                          side: const BorderSide(color: Colors.redAccent),
                          padding: const EdgeInsets.symmetric(vertical: 14),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              
              // Lớp phủ báo hiệu đang cập nhật trạng thái đơn hàng trên Firestore
              if (isUpdatingFirestore)
                Container(
                  color: Colors.black26,
                  child: const Center(
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                      child: Padding(
                        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 20),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CircularProgressIndicator(color: AppColors.primaryColor),
                            SizedBox(width: 16),
                            Text('Đang ghi nhận đơn hàng...', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
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
          Text(value, style: const TextStyle(fontSize: 13, color: Colors.black87, fontWeight: FontWeight.bold)),
        ],
      ),
    );
  }

  Widget _buildInfoPanel(String message) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF), // HSL Blue nhạt dịu mắt
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      padding: const EdgeInsets.all(16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.info, color: Colors.blueAccent, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(fontSize: 12, color: Color(0xFF1E40AF), height: 1.5, fontWeight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorPanel() {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFFFEF2F2), // Đỏ nhạt
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFFEE2E2)),
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Icon(Icons.error, color: Colors.redAccent, size: 20),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  _errorMessage ?? 'Lỗi không xác định xảy ra khi kết nối tới cổng thanh toán PayOS.',
                  style: const TextStyle(fontSize: 12, color: Color(0xFF991B1B), height: 1.5, fontWeight: FontWeight.w500),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          ElevatedButton.icon(
            onPressed: _initiatePayOSPayment,
            icon: const Icon(Icons.refresh, size: 16),
            label: const Text('THỬ LẠI', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.redAccent,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              elevation: 0,
            ),
          ),
        ],
      ),
    );
  }
}
