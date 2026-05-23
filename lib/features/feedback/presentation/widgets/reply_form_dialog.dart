import 'package:flutter/material.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';

class ReplyFormDialog extends StatefulWidget {
  final String? existingReply; // Null when sending a new reply

  const ReplyFormDialog({
    super.key,
    this.existingReply,
  });

  @override
  State<ReplyFormDialog> createState() => _ReplyFormDialogState();
}

class _ReplyFormDialogState extends State<ReplyFormDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _replyController;

  @override
  void initState() {
    super.initState();
    _replyController = TextEditingController(text: widget.existingReply ?? '');
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context, _replyController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    final isEditing = widget.existingReply != null;

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
                      isEditing ? 'Chỉnh Sửa Phản Hồi' : 'Gửi Phản Hồi Hỗ Trợ',
                      style: const TextStyle(
                        fontSize: 18,
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
                const SizedBox(height: 16),
                TextFormField(
                  controller: _replyController,
                  maxLines: 5,
                  decoration: const InputDecoration(
                    labelText: 'Nội dung phản hồi hỗ trợ...',
                    labelStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                  ),
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return 'Vui lòng nhập nội dung phản hồi';
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
                        isEditing ? 'Cập Nhật' : 'Gửi Phản Hồi',
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
