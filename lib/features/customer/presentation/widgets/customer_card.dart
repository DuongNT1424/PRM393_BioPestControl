import 'package:flutter/material.dart';
import '../../domain/entities/customer_entity.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';

class CustomerCard extends StatelessWidget {
  final CustomerEntity customer;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final Function(bool) onToggleLock;

  const CustomerCard({
    super.key,
    required this.customer,
    required this.onTap,
    required this.onEdit,
    required this.onToggleLock,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 2,
      child: ListTile(
        onTap: onTap,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor: AppColors.primaryColor.withOpacity(0.1),
          child: Text(
            customer.name.substring(0, 1).toUpperCase(),
            style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
          ),
        ),
        title: Text(
          customer.name,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            Text(customer.email, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
            if (customer.phone != null)
              Text(customer.phone!, style: TextStyle(color: Colors.grey[600], fontSize: 14)),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                customer.isLocked ? Icons.lock : Icons.lock_open,
                color: customer.isLocked ? Colors.red : Colors.green,
              ),
              onPressed: () => onToggleLock(!customer.isLocked),
              tooltip: customer.isLocked ? 'Unlock Customer' : 'Lock Customer',
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Colors.blue),
              onPressed: onEdit,
              tooltip: 'Edit Customer',
            ),
          ],
        ),
      ),
    );
  }
}
