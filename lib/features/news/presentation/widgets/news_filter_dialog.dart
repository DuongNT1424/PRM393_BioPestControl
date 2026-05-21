import 'package:flutter/material.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';

/// [NewsFilterDialog] cho phép lọc tin tức theo danh mục và trạng thái.
class NewsFilterDialog extends StatefulWidget {
  final String? initialCategory;
  final bool? initialIsPublished;

  const NewsFilterDialog({
    super.key,
    this.initialCategory,
    this.initialIsPublished,
  });

  @override
  State<NewsFilterDialog> createState() => _NewsFilterDialogState();
}

class _NewsFilterDialogState extends State<NewsFilterDialog> {
  String? _selectedCategory;
  bool? _selectedIsPublished;

  static const List<String> _categories = [
    'Tin tức',
    'Khuyến mãi',
    'Hướng dẫn',
    'Thông báo',
    'Sản phẩm mới',
  ];

  @override
  void initState() {
    super.initState();
    _selectedCategory = widget.initialCategory;
    _selectedIsPublished = widget.initialIsPublished;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Bộ lọc tin tức',
        style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Danh mục',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _selectedCategory,
            hint: const Text('Tất cả danh mục'),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            items: [
              const DropdownMenuItem<String>(
                  value: null, child: Text('Tất cả')),
              ..._categories.map((cat) =>
                  DropdownMenuItem(value: cat, child: Text(cat))),
            ],
            onChanged: (value) => setState(() => _selectedCategory = value),
          ),
          const SizedBox(height: 16),
          const Text(
            'Trạng thái',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<bool?>(
            initialValue: _selectedIsPublished,
            hint: const Text('Tất cả'),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            items: const [
              DropdownMenuItem<bool?>(value: null, child: Text('Tất cả')),
              DropdownMenuItem<bool?>(value: true, child: Text('Đã đăng')),
              DropdownMenuItem<bool?>(value: false, child: Text('Nháp')),
            ],
            onChanged: (value) =>
                setState(() => _selectedIsPublished = value),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, <String, dynamic>{
            'category': null,
            'isPublished': null,
          }),
          child:
              const Text('Đặt lại', style: TextStyle(color: Colors.orange)),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, <String, dynamic>{
            'category': _selectedCategory,
            'isPublished': _selectedIsPublished,
          }),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: const Text('Áp dụng',
              style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
