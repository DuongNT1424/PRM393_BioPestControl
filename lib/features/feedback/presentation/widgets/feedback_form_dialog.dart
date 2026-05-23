import 'package:flutter/material.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/features/feedback/domain/entities/feedback.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';

class FeedbackFormDialog extends StatefulWidget {
  final AuthEntity user;
  final FeedbackEntity? feedback; // Null when creating new feedback
  final int? productId;
  final String? productName;

  const FeedbackFormDialog({
    super.key,
    required this.user,
    this.feedback,
    this.productId,
    this.productName,
  });

  @override
  State<FeedbackFormDialog> createState() => _FeedbackFormDialogState();
}

class _FeedbackFormDialogState extends State<FeedbackFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _titleController;
  late final TextEditingController _contentController;
  late int _rating;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(
      text: widget.feedback?.title ??
          (widget.productName != null ? 'Đánh giá sản phẩm: ${widget.productName}' : ''),
    );
    _contentController = TextEditingController(text: widget.feedback?.content ?? '');
    _rating = widget.feedback?.rating ?? 5;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final title = _titleController.text.trim();
      final content = _contentController.text.trim();

      if (widget.feedback == null) {
        // Creating new feedback
        final newFeedback = FeedbackEntity(
          id: '',
          customerId: widget.user.id ?? '',
          customerName: widget.user.name ?? 'Khách hàng',
          customerEmail: widget.user.email ?? '',
          title: title,
          content: content,
          rating: _rating,
          status: 'pending',
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
          productId: widget.productId,
          productName: widget.productName,
        );
        Navigator.pop(context, newFeedback);
      } else {
        // Editing existing feedback
        final updatedFeedback = widget.feedback!.copyWith(
          title: title,
          content: content,
          rating: _rating,
          updatedAt: DateTime.now(),
        );
        Navigator.pop(context, updatedFeedback);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.feedback != null;

    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 0,
      backgroundColor: Colors.transparent,
      child: Container(
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.rectangle,
          borderRadius: BorderRadius.circular(16),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10.0,
              offset: Offset(0.0, 10.0),
            ),
          ],
        ),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      isEditing ? 'Sửa Ý Kiến' : 'Gửi Ý Kiến Mới',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close, color: Colors.grey),
                      onPressed: () => Navigator.pop(context),
                      padding: EdgeInsets.zero,
                      constraints: const BoxConstraints(),
                    ),
                  ],
                ),
                if (widget.productName != null) ...[
                  const SizedBox(height: 8),
                  Text(
                    'Sản phẩm: ${widget.productName}',
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: AppColors.primaryColor,
                    ),
                  ),
                ],
                const SizedBox(height: 16),
                const Text(
                  'Đánh giá chất lượng dịch vụ:',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 8),
                Row(
                  children: List.generate(5, (index) {
                    final starIndex = index + 1;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _rating = starIndex;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: Icon(
                          starIndex <= _rating ? Icons.star : Icons.star_border,
                          color: Colors.amber,
                          size: 32,
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: 20),
                TextFormField(
                  controller: _titleController,
                  decoration: const InputDecoration(
                    labelText: 'Tiêu đề ý kiến',
                    labelStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập tiêu đề';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _contentController,
                  maxLines: 4,
                  decoration: const InputDecoration(
                    labelText: 'Nội dung chi tiết...',
                    labelStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập nội dung chi tiết';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.grey[700],
                      ),
                      child: const Text('Hủy', style: TextStyle(fontWeight: FontWeight.w600)),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: _submit,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 0,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                      ),
                      child: Text(
                        isEditing ? 'Cập Nhật' : 'Gửi Ý Kiến',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
