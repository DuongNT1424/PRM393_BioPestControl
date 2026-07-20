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
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'package:prm393_biopestcontrol/features/discount/presentation/bloc/discount_bloc.dart';
import 'package:prm393_biopestcontrol/features/discount/presentation/bloc/discount_event.dart';
import 'package:prm393_biopestcontrol/features/discount/presentation/bloc/discount_state.dart';
import 'package:prm393_biopestcontrol/features/discount/domain/entities/discount_entity.dart';

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
  DiscountEntity? _selectedDiscount;

  double _calculateDiscountDeduction(CartState cartState, DiscountEntity? discount) {
    if (discount == null || !discount.isActive) return 0.0;
    
    final now = DateTime.now();
    if (now.isBefore(discount.startDate) || now.isAfter(discount.endDate)) {
      return 0.0;
    }

    if (discount.isAllProducts) {
      return cartState.totalPrice * (discount.discountPercent / 100);
    } else {
      double deduction = 0.0;
      for (final item in cartState.items) {
        final productId = item.product.id;
        if (productId != null && discount.productIds.contains(productId)) {
          deduction += (item.product.price * item.quantity) * (discount.discountPercent / 100);
        }
      }
      return deduction;
    }
  }

  void _showDiscountBottomSheet(BuildContext context, CartState cartState) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (bottomSheetContext) {
        return BlocProvider.value(
          value: BlocProvider.of<DiscountBloc>(context),
          child: Container(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Khuyến mãi của bạn',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(bottomSheetContext),
                    )
                  ],
                ),
                const SizedBox(height: 16),
                Flexible(
                  child: BlocBuilder<DiscountBloc, DiscountState>(
                    builder: (context, state) {
                      if (state is DiscountLoading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(24.0),
                            child: CircularProgressIndicator(color: AppColors.primaryColor),
                          ),
                        );
                      }
                      if (state is DiscountError) {
                        return Center(child: Text('Lỗi: ${state.message}'));
                      }
                      if (state is DiscountsLoaded) {
                        final now = DateTime.now();
                        final activeDiscounts = state.discounts.where((d) {
                          return d.isActive && 
                                 !now.isBefore(d.startDate) && 
                                 !now.isAfter(d.endDate);
                        }).toList();

                        if (activeDiscounts.isEmpty) {
                          return const Center(
                            child: Padding(
                              padding: EdgeInsets.all(24.0),
                              child: Text('Hiện không có mã khuyến mãi nào khả dụng'),
                            ),
                          );
                        }

                        return ListView.separated(
                          shrinkWrap: true,
                          itemCount: activeDiscounts.length,
                          separatorBuilder: (_, __) => const SizedBox(height: 12),
                          itemBuilder: (context, index) {
                            final discount = activeDiscounts[index];
                            final deduction = _calculateDiscountDeduction(cartState, discount);
                            final isApplicable = deduction > 0;
                            final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');

                            return Card(
                              elevation: 0,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                  color: isApplicable 
                                      ? AppColors.primaryColor.withOpacity(0.15) 
                                      : Colors.grey[200]!,
                                  width: 1.5,
                                ),
                              ),
                              color: isApplicable 
                                  ? AppColors.primaryColor.withOpacity(0.02) 
                                  : Colors.grey[50]!,
                              child: InkWell(
                                onTap: isApplicable 
                                    ? () {
                                        setState(() {
                                          _selectedDiscount = discount;
                                        });
                                        Navigator.pop(bottomSheetContext);
                                      }
                                    : () {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          const SnackBar(
                                            content: Text('Khuyến mãi này không áp dụng cho sản phẩm trong giỏ hàng'),
                                            backgroundColor: Colors.redAccent,
                                            duration: Duration(seconds: 2),
                                          ),
                                        );
                                      },
                                borderRadius: BorderRadius.circular(12),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Row(
                                    children: [
                                      CircleAvatar(
                                        backgroundColor: isApplicable 
                                            ? AppColors.primaryColor.withOpacity(0.1) 
                                            : Colors.grey[200],
                                        child: Icon(
                                          Icons.local_offer_outlined,
                                          color: isApplicable ? AppColors.primaryColor : Colors.grey[400],
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              discount.name,
                                              style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15,
                                                color: isApplicable ? Colors.black87 : Colors.grey[500],
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              discount.description ?? (discount.isAllProducts 
                                                  ? 'Áp dụng cho toàn bộ sản phẩm' 
                                                  : 'Áp dụng cho một số sản phẩm đặc thù'),
                                              style: TextStyle(
                                                fontSize: 12,
                                                color: isApplicable ? Colors.grey[600] : Colors.grey[400],
                                              ),
                                            ),
                                            const SizedBox(height: 4),
                                            Text(
                                              'HSD: ${DateFormat('dd/MM/yyyy').format(discount.endDate)}',
                                              style: TextStyle(fontSize: 11, color: Colors.grey[400]),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const SizedBox(width: 12),
                                      Column(
                                        crossAxisAlignment: CrossAxisAlignment.end,
                                        children: [
                                          Container(
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                            decoration: BoxDecoration(
                                              color: isApplicable 
                                                  ? AppColors.primaryColor 
                                                  : Colors.grey[300],
                                              borderRadius: BorderRadius.circular(20),
                                            ),
                                            child: Text(
                                              '-${discount.discountPercent.toInt()}%',
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          if (isApplicable) ...[
                                            const SizedBox(height: 8),
                                            Text(
                                              '-${currencyFormat.format(deduction)}',
                                              style: const TextStyle(
                                                color: AppColors.primaryColor,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      }
                      return const Center(child: Text('Không có dữ liệu'));
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildDiscountSelector(BuildContext context, CartState cartState) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    
    if (_selectedDiscount == null) {
      return Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF7F7F7),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.grey[200]!),
        ),
        child: ListTile(
          onTap: () => _showDiscountBottomSheet(context, cartState),
          leading: const Icon(Icons.local_offer_outlined, color: AppColors.primaryColor),
          title: const Text(
            'Chọn mã khuyến mãi',
            style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: Colors.black87),
          ),
          trailing: const Icon(Icons.keyboard_arrow_right, color: Colors.grey),
        ),
      );
    } else {
      final deduction = _calculateDiscountDeduction(cartState, _selectedDiscount);
      return Container(
        decoration: BoxDecoration(
          color: AppColors.primaryColor.withOpacity(0.04),
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: AppColors.primaryColor.withOpacity(0.15), width: 1.5),
        ),
        child: ListTile(
          onTap: () => _showDiscountBottomSheet(context, cartState),
          leading: const Icon(Icons.check_circle, color: AppColors.primaryColor),
          title: Text(
            _selectedDiscount!.name,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.black87),
          ),
          subtitle: Text(
            'Được giảm -${currencyFormat.format(deduction)} (-${_selectedDiscount!.discountPercent.toInt()}%)',
            style: const TextStyle(fontSize: 12, color: AppColors.primaryColor, fontWeight: FontWeight.w600),
          ),
          trailing: IconButton(
            icon: const Icon(Icons.cancel, color: Colors.redAccent, size: 20),
            onPressed: () {
              setState(() {
                _selectedDiscount = null;
              });
            },
          ),
        ),
      );
    }
  }

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

    final discountDeduction = _calculateDiscountDeduction(cartState, _selectedDiscount);
    final finalAmount = cartState.totalPrice - discountDeduction;

    final order = OrderEntity(
      id: '', // Sẽ được sinh tự động bởi Firestore
      customerId: customerId,
      customerName: _nameController.text.trim(),
      customerPhone: _phoneController.text.trim(),
      shippingAddress: _addressController.text.trim(),
      items: orderItems,
      totalAmount: finalAmount, // Số tiền sau khi áp dụng mã giảm giá
      paymentMethod: _paymentMethod,
      paymentStatus: 'Pending',
      deliveryStatus: 'Pending',
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

    return BlocProvider<DiscountBloc>(
      create: (_) => di.sl<DiscountBloc>()..add(LoadDiscounts()),
      child: Scaffold(
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
              final cartState = context.read<CartBloc>().state;
              final discountDeduction = _calculateDiscountDeduction(cartState, _selectedDiscount);
              final orderAmount = cartState.totalPrice - discountDeduction;

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
          final discountDeduction = _calculateDiscountDeduction(cartState, _selectedDiscount);
          final finalTotal = cartState.totalPrice - discountDeduction;

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
                            'Khuyến mãi & Ưu đãi',
                            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                          ),
                          const SizedBox(height: 16),
                          _buildDiscountSelector(context, cartState),
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
                            if (discountDeduction > 0) ...[
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Tạm tính:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                  Text(
                                    currencyFormat.format(cartState.totalPrice),
                                    style: const TextStyle(fontSize: 14, color: Colors.black87),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text('Khuyến mãi:', style: TextStyle(fontSize: 14, color: Colors.grey)),
                                  Text(
                                    '-${currencyFormat.format(discountDeduction)}',
                                    style: const TextStyle(fontSize: 14, color: AppColors.primaryColor, fontWeight: FontWeight.w600),
                                  ),
                                ],
                              ),
                              const Divider(height: 24),
                            ],
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text('Tổng số tiền cần trả:', style: TextStyle(fontSize: 14, color: Colors.grey, fontWeight: FontWeight.bold)),
                                Text(
                                  currencyFormat.format(finalTotal),
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
      ),  // Close BlocProvider<DiscountBloc>
    );
  }
}
