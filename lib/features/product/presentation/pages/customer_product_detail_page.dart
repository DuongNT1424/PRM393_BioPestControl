import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/features/product/domain/entities/product_entity.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:prm393_biopestcontrol/features/cart/presentation/bloc/cart_event.dart';
import 'package:prm393_biopestcontrol/features/cart/presentation/bloc/cart_state.dart';
import 'package:prm393_biopestcontrol/features/cart/presentation/pages/cart_page.dart';

class CustomerProductDetailPage extends StatelessWidget {
  final ProductEntity product;

  const CustomerProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    final imageUrl = (product.imageUrl != null && product.imageUrl!.isNotEmpty)
        ? product.imageUrl!
        : 'https://images.unsplash.com/photo-1628157588553-5eeea00af15c?auto=format&fit=crop&q=80&w=300';

    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: AppBar(
        title: const Text('Chi tiết sản phẩm', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(
            icon: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                return Stack(
                  clipBehavior: Clip.none,
                  children: [
                    const Icon(Icons.shopping_cart_outlined),
                    if (state.totalItems > 0)
                      Positioned(
                        right: -4,
                        top: -4,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                          child: Text(
                            '${state.totalItems}',
                            style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
            onPressed: () {
              Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                width: double.infinity,
                color: Colors.grey[100],
                child: Image.network(imageUrl, fit: BoxFit.cover),
              ),
            ),
            
            // Product Info
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          product.name,
                          style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, height: 1.2),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: AppColors.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          'Kho: ${product.stock}',
                          style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold, fontSize: 12),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    currencyFormat.format(product.price),
                    style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                  ),
                  const SizedBox(height: 24),
                  
                  const Text('Mô tả', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text(
                    product.description ?? 'Sản phẩm này chưa có mô tả.',
                    style: TextStyle(fontSize: 14, color: Colors.grey[700], height: 1.6),
                  ),
                  
                  const SizedBox(height: 40),
                  const Divider(),
                  const SizedBox(height: 24),
                  
                  // Feedback / Reviews Section
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Đánh giá & Phản hồi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                      Row(
                        children: [
                          const Icon(Icons.star, color: Colors.amber, size: 20),
                          const SizedBox(width: 4),
                          const Text('4.8', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                          Text(' (12)', style: TextStyle(color: Colors.grey[600])),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  _buildFeedbackItem(
                    'Nguyễn Văn A', 
                    '5', 
                    'Sản phẩm rất tốt, lúa nhà tôi xanh mướt sau khi sử dụng. Giao hàng cực nhanh!', 
                    '2 ngày trước'
                  ),
                  const SizedBox(height: 16),
                  _buildFeedbackItem(
                    'Trần Thị B', 
                    '4', 
                    'Thuốc xịt không bị mùi hắc, dễ sử dụng. Sẽ tiếp tục ủng hộ shop lâu dài.', 
                    '1 tuần trước'
                  ),
                  const SizedBox(height: 16),
                  Center(
                    child: OutlinedButton(
                      onPressed: () {},
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primaryColor,
                        side: const BorderSide(color: AppColors.primaryColor),
                      ),
                      child: const Text('Xem tất cả đánh giá'),
                    ),
                  ),
                  const SizedBox(height: 80), // Padding for bottom button
                ],
              ),
            ),
          ],
        ),
      ),
      bottomSheet: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border(top: BorderSide(color: Colors.grey[200]!)),
        ),
        child: Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: () {},
                icon: const Icon(Icons.chat_bubble_outline),
                label: const Text('Chat'),
                style: OutlinedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  foregroundColor: AppColors.primaryColor,
                  side: const BorderSide(color: AppColors.primaryColor),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              flex: 2,
              child: ElevatedButton(
                onPressed: () {
                  context.read<CartBloc>().add(AddToCartEvent(product));
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Đã thêm ${product.name} vào giỏ hàng'), duration: const Duration(seconds: 1)),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  elevation: 0,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('Thêm vào giỏ', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeedbackItem(String name, String rating, String comment, String time) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
              Text(time, style: TextStyle(fontSize: 12, color: Colors.grey[500])),
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(
              5, 
              (index) => Icon(
                index < int.parse(rating) ? Icons.star : Icons.star_border, 
                color: Colors.amber, 
                size: 14
              )
            ),
          ),
          const SizedBox(height: 8),
          Text(comment, style: TextStyle(color: Colors.grey[800], fontSize: 14)),
        ],
      ),
    );
  }
}
