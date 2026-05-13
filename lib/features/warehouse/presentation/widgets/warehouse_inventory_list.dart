import 'package:flutter/material.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/entities/warehouse_inventory_entity.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';

/// [WarehouseInventoryList] hiển thị danh sách các mặt hàng đang có trong kho.
class WarehouseInventoryList extends StatelessWidget {
  final List<WarehouseInventoryEntity> inventory;
  final bool isAdmin;

  const WarehouseInventoryList({
    super.key,
    required this.inventory,
    required this.isAdmin,
  });

  @override
  Widget build(BuildContext context) {
    if (inventory.isEmpty) {
      return const Center(child: Text('Không tìm thấy sản phẩm trong kho'));
    }

    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: inventory.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final item = inventory[index];
        return ListTile(
          contentPadding: const EdgeInsets.symmetric(vertical: 8),
          leading: _buildProductImage(item),
          title: Text(
            item.product?.name ?? 'Sản phẩm không xác định',
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('SKU: ${item.product?.sku ?? 'N/A'}'),
            ],
          ),
          trailing: _buildQuantityBadge(item.quantity),
        );
      },
    );
  }

  /// Hiển thị ảnh sản phẩm hoặc Icon mặc định.
  Widget _buildProductImage(WarehouseInventoryEntity item) {
    return Container(
      width: 50,
      height: 50,
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(8),
      ),
      child: item.product?.imageUrl != null
          ? ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                item.product!.imageUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.eco),
              ),
            )
          : const Icon(Icons.eco, color: AppColors.primaryColor),
    );
  }

  /// Hiển thị nhãn số lượng với màu sắc cảnh báo nếu hết hàng.
  Widget _buildQuantityBadge(int quantity) {
    final isLow = quantity < 10;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: isLow ? Colors.red[50] : Colors.green[50],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        'SL: $quantity',
        style: TextStyle(
          color: isLow ? Colors.red[700] : Colors.green[700],
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
