import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/features/cart/domain/entities/cart_item_entity.dart';
import 'package:prm393_biopestcontrol/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:prm393_biopestcontrol/features/cart/presentation/bloc/cart_event.dart';

class CartItemCard extends StatelessWidget {
  final CartItemEntity item;

  const CartItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    final product = item.product;
    final imageUrl = (product.imageUrl != null && product.imageUrl!.isNotEmpty)
        ? product.imageUrl!
        : 'https://images.unsplash.com/photo-1628157588553-5eeea00af15c?auto=format&fit=crop&q=80&w=300';

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[200]!),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.network(
              imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  product.name,
                  style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 8),
                Text(
                  currencyFormat.format(product.price),
                  style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    _buildQuantityBtn(Icons.remove, () {
                      context.read<CartBloc>().add(UpdateCartItemQuantityEvent(product.id!, item.quantity - 1));
                    }),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: Text('${item.quantity}', style: const TextStyle(fontWeight: FontWeight.bold)),
                    ),
                    _buildQuantityBtn(Icons.add, () {
                      context.read<CartBloc>().add(UpdateCartItemQuantityEvent(product.id!, item.quantity + 1));
                    }),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(Icons.delete_outline, color: Colors.red),
                      onPressed: () {
                        context.read<CartBloc>().add(RemoveFromCartEvent(product.id!));
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityBtn(IconData icon, VoidCallback onTap) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Icon(icon, size: 16),
      ),
    );
  }
}
