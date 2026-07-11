import 'package:flutter/material.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import '../../domain/entities/map.dart';

class StoreCard extends StatelessWidget {
  final StoreLocationEntity store;
  final double? distanceMeters;
  final VoidCallback onTap;
  final VoidCallback onDirection;

  const StoreCard({
    super.key,
    required this.store,
    this.distanceMeters,
    required this.onTap,
    required this.onDirection,
  });

  String get _distanceText {
    if (distanceMeters == null) return '';
    if (distanceMeters! < 1000) {
      return '${distanceMeters!.round()} m';
    }
    return '${(distanceMeters! / 1000).toStringAsFixed(1)} km';
  }

  @override
  Widget build(BuildContext context) {
    final bool isWarehouse = store.type == 'warehouse';

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 260,
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.1),
              blurRadius: 10,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.primaryColor.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    isWarehouse
                        ? Icons.warehouse_outlined
                        : Icons.storefront_outlined,
                    color: AppColors.primaryColor,
                    size: 20,
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        store.name,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        isWarehouse ? 'Kho hàng' : 'Cửa hàng',
                        style: const TextStyle(
                          fontSize: 11,
                          color: AppColors.primaryColor,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                if (_distanceText.isNotEmpty)
                  Text(
                    _distanceText,
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
              ],
            ),
            const SizedBox(height: 8),
            Expanded(
              child: Text(
                store.address,
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(
              width: double.infinity,
              height: 32,
              child: ElevatedButton.icon(
                onPressed: onDirection,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.zero,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                ),
                icon: const Icon(Icons.directions, size: 16),
                label: const Text('Chỉ đường',
                    style: TextStyle(fontSize: 12)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
