import 'package:flutter/material.dart';
import '../../domain/entities/discount_entity.dart';
import 'package:intl/intl.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';

class DiscountCard extends StatelessWidget {
  final DiscountEntity discount;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const DiscountCard({
    super.key,
    required this.discount,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final bool isExpired = discount.endDate.isBefore(DateTime.now());
    final DateFormat formatter = DateFormat('dd/MM/yyyy');

    String displayProducts = discount.isAllProducts 
        ? 'All Products' 
        : (discount.productNames ?? 'No products selected');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: Colors.grey.shade200),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    discount.name,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: isExpired 
                        ? Colors.grey.shade100 
                        : (discount.isActive ? Colors.green.shade50 : Colors.red.shade50),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    isExpired ? 'Expired' : (discount.isActive ? 'Active' : 'Disabled'),
                    style: TextStyle(
                      fontSize: 12,
                      color: isExpired 
                          ? Colors.grey 
                          : (discount.isActive ? Colors.green : Colors.red),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Products: $displayProducts',
              style: TextStyle(color: Colors.grey.shade700),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.percent, size: 16, color: AppColors.primaryColor),
                const SizedBox(width: 4),
                Text(
                  'Discount: ${discount.discountPercent}%',
                  style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primaryColor),
                ),
              ],
            ),
            const SizedBox(height: 4),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${formatter.format(discount.startDate)} - ${formatter.format(discount.endDate)}',
                  style: const TextStyle(fontSize: 13, color: Colors.grey),
                ),
              ],
            ),
            if (onEdit != null || onDelete != null) ...[
              const Divider(height: 24),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  if (onEdit != null)
                    TextButton.icon(
                      onPressed: onEdit,
                      icon: const Icon(Icons.edit_outlined, size: 18),
                      label: const Text('Edit'),
                      style: TextButton.styleFrom(foregroundColor: AppColors.primaryColor),
                    ),
                  if (onEdit != null && onDelete != null) const SizedBox(width: 8),
                  if (onDelete != null)
                    TextButton.icon(
                      onPressed: onDelete,
                      icon: const Icon(Icons.delete_outline, size: 18),
                      label: const Text('Delete'),
                      style: TextButton.styleFrom(foregroundColor: Colors.redAccent),
                    ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
