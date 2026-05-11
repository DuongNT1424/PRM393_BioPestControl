import 'package:flutter/material.dart';
import 'package:prm393_biopestcontrol/features/category/domain/entities/category_entity.dart';

/// [ProductFilterDialog] hiển thị hộp thoại lọc sản phẩm.
class ProductFilterDialog extends StatefulWidget {
  final List<CategoryEntity> categories;
  final int? initialCategoryId;
  final bool? initialIsActive;

  const ProductFilterDialog({
    super.key,
    required this.categories,
    this.initialCategoryId,
    this.initialIsActive,
  });

  @override
  State<ProductFilterDialog> createState() => _ProductFilterDialogState();
}

class _ProductFilterDialogState extends State<ProductFilterDialog> {
  int? _tempCategoryId;
  bool? _tempIsActive;

  @override
  void initState() {
    super.initState();
    _tempCategoryId = widget.initialCategoryId;
    _tempIsActive = widget.initialIsActive;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Lọc sản phẩm'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          DropdownButtonFormField<int>(
            value: _tempCategoryId,
            decoration: const InputDecoration(labelText: 'Danh mục'),
            items: [
              const DropdownMenuItem(value: null, child: Text('Tất cả')),
              ...widget.categories.map((cat) => DropdownMenuItem(
                    value: cat.id,
                    child: Text(cat.name),
                  )),
            ],
            onChanged: (val) => setState(() => _tempCategoryId = val),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<bool>(
            value: _tempIsActive,
            decoration: const InputDecoration(labelText: 'Trạng thái'),
            items: const [
              DropdownMenuItem(value: null, child: Text('Tất cả')),
              DropdownMenuItem(value: true, child: Text('Đang kinh doanh')),
              DropdownMenuItem(value: false, child: Text('Ngừng bán')),
            ],
            onChanged: (val) => setState(() => _tempIsActive = val),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        TextButton(
          onPressed: () {
            Navigator.pop(context, {
              'categoryId': _tempCategoryId,
              'isActive': _tempIsActive,
            });
          },
          child: const Text('Áp dụng'),
        ),
      ],
    );
  }
}
