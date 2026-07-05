import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_state.dart';
import '../../domain/entities/product_entity.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import '../widgets/product_detail_widgets.dart';

/// [ProductDetailPage] hiển thị chi tiết sản phẩm và các thao tác liên quan.
class ProductDetailPage extends StatelessWidget {
  final ProductEntity product;
  final Function(ProductEntity) onEdit;
  final Function(int) onDelete;

  const ProductDetailPage({
    super.key,
    required this.product,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    return BlocBuilder<ProductBloc, ProductState>(
      builder: (context, state) {
        ProductEntity currentProduct = product;
        if (state is ProductLoaded) {
          final found = state.products.cast<ProductEntity>().firstWhere(
            (p) => p.id == product.id,
            orElse: () => product,
          );
          currentProduct = found;
        }

        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text('Chi tiết sản phẩm'),
            backgroundColor: Colors.white,
            foregroundColor: AppColors.primaryColor,
            elevation: 0,
            actions: [
              IconButton(
                icon: const Icon(Icons.edit_outlined),
                onPressed: () => onEdit(currentProduct),
              ),
              IconButton(
                icon: const Icon(Icons.delete_outline, color: Colors.red),
                onPressed: () => _showDeleteDialog(context),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Thành phần Header ảnh sản phẩm
                ProductDetailHeader(imageUrl: currentProduct.imageUrl),

                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: AppColors.primaryColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              currentProduct.sku,
                              style: const TextStyle(
                                color: AppColors.primaryColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 14,
                              ),
                            ),
                          ),
                          // Badge trạng thái
                          ProductStatusBadge(isActive: currentProduct.isActive),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        currentProduct.name,
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currencyFormat.format(currentProduct.price),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      const Divider(height: 40),
                      const Text(
                        'Mô tả sản phẩm',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        currentProduct.description ?? 'Không có mô tả cho sản phẩm này.',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.grey[700],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Các dòng thông tin chi tiết
                      ProductInfoRow(
                        icon: Icons.inventory_2_outlined,
                        label: 'Số lượng trong kho',
                        value: '${currentProduct.stock} đơn vị',
                      ),
                      const SizedBox(height: 12),
                      ProductInfoRow(
                        icon: Icons.category_outlined,
                        label: 'Danh mục ID',
                        value: '#${currentProduct.categoryId}',
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  /// Hiển thị hộp thoại xác nhận xóa sản phẩm.
  void _showDeleteDialog(BuildContext pageContext) {
    showDialog(
      context: pageContext,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: const Text('Bạn có chắc chắn muốn xóa sản phẩm này không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Hủy'),
          ),
          TextButton(
            onPressed: () {
              Navigator.pop(dialogContext); // Đóng dialog
              onDelete(product.id!);
              Navigator.pop(pageContext); // Quay về danh sách
            },
            child: const Text('Xóa', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );
  }
}
