import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_state.dart';
import 'package:prm393_biopestcontrol/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:prm393_biopestcontrol/features/cart/presentation/bloc/cart_event.dart';
import 'package:prm393_biopestcontrol/features/cart/presentation/bloc/cart_state.dart';
import '../../domain/entities/order.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import 'payment_gateway_page.dart';
import 'customer_order_detail_page.dart';

class CheckoutPage extends StatefulWidget {
  const CheckoutPage({super.key});

  @override
  State<CheckoutPage> createState() => _CheckoutPageState();
}

class _CheckoutPageState extends State<CheckoutPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  String _paymentMethod = 'COD'; // COD hoặc PayOS

  @override
  void initState() {
    super.initState();
    // Tự động điền tên người dùng từ AuthBloc nếu đã đăng nhập
    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      _nameController.text = authState.user.name ?? '';
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  void _submitOrder(BuildContext context, CartState cartState, String customerId) {
    if (!_formKey.currentState!.validate()) return;

    final orderItems = cartState.items.map((cartItem) {
      return OrderItemEntity(
        productId: cartItem.product.id ?? 0,
        productName: cartItem.product.name,
        sku: cartItem.product.sku,
        imageUrl: cartItem.product.imageUrl,
        price: cartItem.product.price,
        quantity: cartItem.quantity,
      );
    }).toList();

    final order = OrderEntity(
      id: '', // Sẽ được sinh tự động bởi Firestore
      customerId: customerId,
      customerName: _nameController.text.trim(),
      customerPhone: _phoneController.text.trim(),
      shippingAddress: _addressController.text.trim(),
      items: orderItems,
      totalAmount: cartState.totalPrice,
      paymentMethod: _paymentMethod,
      paymentStatus: _paymentMethod == 'PayOS' ? 'Pending' : 'Pending', // COD hoặc PayOS đều chờ xác nhận/thanh toán
      deliveryStatus: 'Pending', // Chờ xác nhận đơn hàng
      createdAt: DateTime.now(),
    );

    // Gửi sự kiện tạo đơn hàng tới OrderBloc
    context.read<OrderBloc>().add(CreateOrderEvent(order));
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    final authState = context.read<AuthBloc>().state;
    final customerId = authState is Authenticated ? (authState.user.id ?? '') : '';

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Xác nhận đặt hàng', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: BlocConsumer<OrderBloc, OrderState>(
        listener: (context, state) {
          if (state is OrderError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message), backgroundColor: Colors.redAccent),
            );
          }
          if (state is OrderActionSuccess) {
            // Lưu lại tổng số tiền trước khi xóa sạch giỏ hàng
            final orderAmount = context.read<CartBloc>().state.totalPrice;

            // Xóa sạch giỏ hàng khi đặt hàng thành công
            context.read<CartBloc>().add(ClearCartEvent());

            if (_paymentMethod == 'PayOS') {
              // Điều hướng sang cổng quét mã QR PayOS
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => PaymentGatewayPage(
                    orderId: state.orderId ?? '',
                    totalAmount: orderAmount,
                  ),
                ),
              );
            } else {
              // Thanh toán COD thành công: Chuyển trực tiếp sang chi tiết đơn hàng
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Đặt hàng thành công! Đang xử lý đơn hàng...'), backgroundColor: AppColors.primaryColor),
              );
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (_) => CustomerOrderDetailPage(orderId: state.orderId ?? ''),
                ),
              );
            }
          }
        },
        builder: (context, state) {
          final cartState = context.watch<CartBloc>().state;
          final isProcessing = state is OrderLoading;

          return Stack(
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView(
                        padding: const EdgeInsets.all(24),
                        children: [
                          const Text(
                            'Thông tin giao hàng',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _nameController,
                            decoration: const InputDecoration(
                              labelText: 'Họ và tên người nhận',
                              prefixIcon: Icon(Icons.person_outline),
                              fillColor: Color(0xFFF7F7F7),
                            ),
                            validator: (val) => val == null || val.trim().isEmpty ? 'Vui lòng nhập họ tên' : null,
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _phoneController,
                            keyboardType: TextInputType.phone,
                            decoration: const InputDecoration(
                              labelText: 'Số điện thoại',
                              prefixIcon: Icon(Icons.phone_outlined),
                              fillColor: Color(0xFFF7F7F7),
                            ),
                            validator: (val) {
                              if (val == null || val.trim().isEmpty) return 'Vui lòng nhập SĐT';
                              if (val.trim().length < 9 || val.trim().length > 11) return 'SĐT không hợp lệ';
                              return null;
                            },
                          ),
                          const SizedBox(height: 16),
                          TextFormField(
                            controller: _addressController,
                            maxLines: 2,
                            decoration: const InputDecoration(
                              labelText: 'Địa chỉ nhận hàng chi tiết',
                              prefixIcon: Icon(Icons.location_on_outlined),
                              fillColor: Color(0xFFF7F7F7),
                            ),
                            validator: (val) => val == null || val.trim().isEmpty ? 'Vui lòng nhập địa chỉ nhận hàng' : null,
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            'Phương thức thanh toán',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                          ),
                          const SizedBox(height: 16),
                          Container(
                            decoration: BoxDecoration(
                              color: const Color(0xFFF7F7F7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Column(
                              children: [
                                RadioListTile<String>(
                                  title: const Text('Thanh toán khi nhận hàng (COD)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                  value: 'COD',
                                  groupValue: _paymentMethod,
                                  activeColor: AppColors.primaryColor,
                                  onChanged: (val) {
                                    setState(() {
                                      _paymentMethod = val!;
                                    });
                                  },
                                ),
                                const Divider(height: 1),
                                RadioListTile<String>(
                                  title: const Text('Chuyển khoản QR code nhanh (PayOS)', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500)),
                                  value: 'PayOS',
                                  groupValue: _paymentMethod,
                                  activeColor: AppColors.primaryColor,
                                  onChanged: (val) {
                                    setState(() {
                                      _paymentMethod = val!;
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 32),
                          const Text(
                            'Tóm tắt đơn hàng',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                          ),
                          const SizedBox(height: 16),
                          ...cartState.items.map((item) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        '${item.product.name} x${item.quantity}',
                                        style: const TextStyle(fontSize: 14, color: Colors.black87),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                    Text(
                                      currencyFormat.format(item.product.price * item.quantity),
                                      style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.grey[800]),
                                    ),
                                  ],
                                ),
                              )),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border(top: BorderSide(color: Colors.grey[100]!)),
                        boxShadow: [
                          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, -5)),
                        ],
                      ),
                      child: SafeArea(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Tổng số tiền cần trả:', style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold)),
                                Text(
                                  currencyFormat.format(cartState.totalPrice),
                                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                onPressed: isProcessing ? null : () => _submitOrder(context, cartState, customerId),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.primaryColor,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 16),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                                  elevation: 0,
                                ),
                                child: const Text(
                                  'ĐẶT HÀNG NGAY',
                                  style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold, letterSpacing: 0.5),
                                ),
                              ),
                            ),
                          ],
                        ),
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
}
