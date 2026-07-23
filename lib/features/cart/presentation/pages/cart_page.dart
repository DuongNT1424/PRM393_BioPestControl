import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import '../bloc/cart_bloc.dart';
import '../bloc/cart_event.dart';
import '../bloc/cart_state.dart';
import '../widgets/cart_item_card.dart';
import '../../../order/presentation/pages/checkout_page.dart';

/// CartPage: Màn hình hiển thị giỏ hàng của người dùng.
/// ------------------------------------------------------
/// Chức năng chính:
/// - Hiển thị danh sách sản phẩm đã thêm vào giỏ hàng.
/// - Cho phép xóa toàn bộ giỏ hàng.
/// - Hiển thị tổng số lượng và tổng tiền.
/// - Điều hướng sang trang Checkout để thanh toán.
///
/// Kiến trúc:
/// - Sử dụng BLoC pattern.
/// - CartBloc quản lý dữ liệu giỏ hàng.
/// - CartState chứa danh sách sản phẩm và các giá trị tính toán.
/// - BlocBuilder lắng nghe CartState và tự động cập nhật UI khi state thay đổi.
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {

    // NumberFormat dùng để định dạng tiền tệ Việt Nam.
    // Ví dụ: 150000 -> 150.000đ
    final currencyFormat = NumberFormat.currency(
      locale: 'vi_VN',
      symbol: 'đ',
    );

    return Scaffold(

      // Màu nền chung của màn hình
      backgroundColor: AppColors.backgroundColor,

      // ================= APP BAR =================
      appBar: AppBar(

        // Tiêu đề trang
        title: const Text(
          'Giỏ hàng',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),

        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,

        actions: [

          // Nút xóa toàn bộ sản phẩm trong giỏ hàng
          TextButton(
            onPressed: () {

              // context.read<CartBloc>()
              // -> Lấy instance CartBloc hiện tại từ widget tree.
              //
              // add(ClearCartEvent())
              // -> Gửi event đến CartBloc.
              // CartBloc sẽ xử lý event này và cập nhật state thành giỏ hàng rỗng.
              context.read<CartBloc>().add(ClearCartEvent());
            },
            child: const Text(
              'Xóa tất cả',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),

      // ================= BODY =================
      //
      // BlocBuilder lắng nghe CartState.
      // Mỗi khi CartBloc emit state mới, hàm builder sẽ được gọi lại
      // để cập nhật giao diện mà không cần setState().
      body: BlocBuilder<CartBloc, CartState>(

        builder: (context, state) {

          // =========================================================
          // TRƯỜNG HỢP 1: GIỎ HÀNG TRỐNG
          // =========================================================
          //
          // state.items là danh sách sản phẩm trong giỏ hàng.
          // Nếu danh sách rỗng -> hiển thị Empty State.
          if (state.items.isEmpty) {

            return Center(
              child: Column(

                // Căn giữa theo chiều dọc
                mainAxisAlignment: MainAxisAlignment.center,

                children: [

                  // Icon minh họa giỏ hàng trống
                  Icon(
                    Icons.shopping_cart_outlined,
                    size: 80,
                    color: Colors.grey[300],
                  ),

                  const SizedBox(height: 16),

                  // Thông báo cho người dùng
                  Text(
                    'Giỏ hàng của bạn đang trống',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 16,
                    ),
                  ),

                  const SizedBox(height: 24),

                  // Nút quay lại màn hình trước để tiếp tục mua sắm
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),

                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primaryColor,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 12,
                      ),
                    ),

                    child: const Text('Mua sắm ngay'),
                  ),
                ],
              ),
            );
          }

          // =========================================================
          // TRƯỜNG HỢP 2: CÓ SẢN PHẨM TRONG GIỎ HÀNG
          // =========================================================
          return Column(
            children: [

              // Expanded giúp danh sách chiếm toàn bộ không gian còn lại
              Expanded(

                // ListView.separated hiển thị danh sách có khoảng cách giữa các item.
                child: ListView.separated(

                  // Padding xung quanh danh sách
                  padding: const EdgeInsets.all(24),

                  // Số lượng item trong danh sách
                  itemCount: state.items.length,

                  // Widget phân cách giữa các item
                  separatorBuilder: (_, __) =>
                      const SizedBox(height: 16),

                  // Tạo từng item
                  itemBuilder: (context, index) {

                    // CartItemCard là widget con hiển thị thông tin sản phẩm.
                    // Bên trong widget này có thể:
                    // - Tăng số lượng
                    // - Giảm số lượng
                    // - Xóa sản phẩm
                    // bằng cách gửi event tới CartBloc.
                    return CartItemCard(
                      item: state.items[index],
                    );
                  },
                ),
              ),

              // ================= FOOTER =================
              //
              // Footer cố định ở cuối màn hình:
              // - Hiển thị tổng tiền
              // - Hiển thị nút thanh toán
              Container(

                padding: const EdgeInsets.all(24),

                decoration: BoxDecoration(
                  color: Colors.white,

                  // Viền trên để tách footer khỏi danh sách
                  border: Border(
                    top: BorderSide(color: Colors.grey[200]!),
                  ),

                  // Đổ bóng phía trên
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),

                // SafeArea tránh bị che bởi thanh điều hướng của điện thoại
                child: SafeArea(
                  child: Column(
                    children: [

                      // ===== Dòng hiển thị tổng tiền =====
                      Row(
                        mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,

                        children: [

                          // state.totalItems là getter trong CartState
                          // dùng để tính tổng số lượng sản phẩm.
                          Text(
                            'Tổng cộng (${state.totalItems} sản phẩm):',
                            style: const TextStyle(color: Colors.grey),
                          ),

                          // state.totalPrice là getter tính tổng tiền:
                          // sum(item.price * item.quantity)
                          Text(
                            currencyFormat.format(state.totalPrice),

                            style: const TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 16),

                      // ===== Nút Thanh toán =====
                      SizedBox(
                        width: double.infinity,

                        child: ElevatedButton(

                          onPressed: () {

                            // Điều hướng sang CheckoutPage.
                            // Dữ liệu giỏ hàng vẫn được giữ trong CartBloc
                            // vì CartBloc được cung cấp ở cấp ứng dụng (global).
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) =>
                                    const CheckoutPage(),
                              ),
                            );
                          },

                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryColor,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),

                          child: const Text(
                            'Thanh toán',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}