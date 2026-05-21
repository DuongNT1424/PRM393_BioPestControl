import 'package:flutter/material.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import '../../domain/entities/news_entity.dart';

/// [NewsFormPage] trang tạo mới hoặc chỉnh sửa tin tức/bài viết.
class NewsFormPage extends StatefulWidget {
  final NewsEntity? news;
  final AuthEntity user;
  final Function(NewsEntity) onSave;

  const NewsFormPage({
    super.key,
    this.news,
    required this.user,
    required this.onSave,
  });

  @override
  State<NewsFormPage> createState() => _NewsFormPageState();
}

class _NewsFormPageState extends State<NewsFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _titleController;
  late TextEditingController _summaryController;
  late TextEditingController _contentController;
  late TextEditingController _imageUrlController;
  String? _selectedCategory;
  bool _isPublished = true;

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
    _titleController =
        TextEditingController(text: widget.news?.title ?? '');
    _summaryController =
        TextEditingController(text: widget.news?.summary ?? '');
    _contentController =
        TextEditingController(text: widget.news?.content ?? '');
    _imageUrlController =
        TextEditingController(text: widget.news?.imageUrl ?? '');
    _selectedCategory = widget.news?.category;
    _isPublished = widget.news?.isPublished ?? true;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _summaryController.dispose();
    _contentController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.news != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          isEdit ? 'Chỉnh sửa tin tức' : 'Thêm tin tức mới',
          style: const TextStyle(
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // ----- Tiêu đề -----
            _buildSectionLabel('Tiêu đề *'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _titleController,
              maxLength: 200,
              decoration: _inputDecoration('Nhập tiêu đề tin tức...'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Vui lòng nhập tiêu đề' : null,
            ),
            const SizedBox(height: 16),

            // ----- Tóm tắt -----
            _buildSectionLabel('Tóm tắt'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _summaryController,
              maxLines: 3,
              maxLength: 500,
              decoration:
                  _inputDecoration('Mô tả ngắn về bài viết (tùy chọn)...'),
            ),
            const SizedBox(height: 16),

            // ----- Nội dung -----
            _buildSectionLabel('Nội dung *'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _contentController,
              maxLines: 10,
              decoration: _inputDecoration('Nhập nội dung chi tiết bài viết...'),
              validator: (v) =>
                  (v == null || v.trim().isEmpty) ? 'Vui lòng nhập nội dung' : null,
            ),
            const SizedBox(height: 16),

            // ----- URL Hình ảnh -----
            _buildSectionLabel('URL Hình ảnh bìa'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _imageUrlController,
              decoration: _inputDecoration('https://...'),
              keyboardType: TextInputType.url,
            ),
            // Xem trước ảnh
            if (_imageUrlController.text.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    _imageUrlController.text,
                    height: 160,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
                  ),
                ),
              ),
            const SizedBox(height: 16),

            // ----- Danh mục -----
            _buildSectionLabel('Danh mục'),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              initialValue: _selectedCategory,
              hint: const Text('Chọn danh mục'),
              decoration: InputDecoration(
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.primaryColor),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(
                      color: AppColors.primaryColor.withValues(alpha: 0.3)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide:
                      const BorderSide(color: AppColors.primaryColor),
                ),
                contentPadding: const EdgeInsets.symmetric(
                    horizontal: 16, vertical: 14),
              ),
              items: [
                const DropdownMenuItem<String>(
                    value: null, child: Text('-- Không có danh mục --')),
                ..._categories.map(
                  (cat) =>
                      DropdownMenuItem<String>(value: cat, child: Text(cat)),
                ),
              ],
              onChanged: (val) => setState(() => _selectedCategory = val),
            ),
            const SizedBox(height: 20),

            // ----- Trạng thái xuất bản -----
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: AppColors.primaryColor.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                title: const Text(
                  'Xuất bản ngay',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  _isPublished ? 'Tin tức sẽ hiển thị công khai' : 'Lưu dưới dạng nháp',
                  style: TextStyle(
                    fontSize: 12,
                    color: _isPublished ? Colors.green : Colors.orange,
                  ),
                ),
                value: _isPublished,
                activeThumbColor: AppColors.primaryColor,
                onChanged: (val) => setState(() => _isPublished = val),
              ),
            ),

            const SizedBox(height: 32),

            // ----- Nút lưu -----
            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                isEdit ? 'CẬP NHẬT TIN TỨC' : 'ĐĂNG TIN TỨC',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Build section label widget.
  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Colors.black87,
      ),
    );
  }

  /// Common InputDecoration.
  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  /// Xử lý lưu tin tức.
  void _submit() {
    if (_formKey.currentState!.validate()) {
      final news = NewsEntity(
        id: widget.news?.id,
        title: _titleController.text.trim(),
        content: _contentController.text.trim(),
        summary: _summaryController.text.trim().isEmpty
            ? null
            : _summaryController.text.trim(),
        imageUrl: _imageUrlController.text.trim().isEmpty
            ? null
            : _imageUrlController.text.trim(),
        category: _selectedCategory,
        authorId: widget.user.id,
        authorName: widget.user.name ?? widget.user.email,
        createdAt: widget.news?.createdAt ?? DateTime.now(),
        isPublished: _isPublished,
      );
      widget.onSave(news);
      Navigator.pop(context);
    }
  }
}
