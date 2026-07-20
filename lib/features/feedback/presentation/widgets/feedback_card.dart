import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import '../../domain/entities/feedback.dart';

class FeedbackCard extends StatelessWidget {
  final FeedbackEntity feedback;
  final AuthEntity currentUser;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;
  final Function(String replyContent)? onReply;

  const FeedbackCard({
    super.key,
    required this.feedback,
    required this.currentUser,
    this.onEdit,
    this.onDelete,
    this.onReply,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');
    final isCustomer = currentUser.role?.toLowerCase() == 'customer';
    final isStaffOrAdmin = currentUser.role?.toLowerCase() == 'staff' || currentUser.role?.toLowerCase() == 'admin';
    final isOwnFeedback = feedback.customerId == currentUser.id;
    final hasReply = feedback.replyContent != null && feedback.replyContent!.isNotEmpty;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header of the card (rating, status, and metadata)
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                // Star Rating
                Row(
                  children: List.generate(5, (index) {
                    return Icon(
                      index < feedback.rating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 20,
                    );
                  }),
                ),
                // Status Chip
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: feedback.status == 'replied'
                        ? Colors.green.withOpacity(0.1)
                        : Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: feedback.status == 'replied'
                          ? Colors.green.withOpacity(0.5)
                          : Colors.orange.withOpacity(0.5),
                      width: 0.8,
                    ),
                  ),
                  child: Text(
                    feedback.status == 'replied' ? 'Đã phản hồi' : 'Chờ xử lý',
                    style: TextStyle(
                      fontSize: 11,
                      fontWeight: FontWeight.bold,
                      color: feedback.status == 'replied'
                          ? Colors.green[700]
                          : Colors.orange[700],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Feedback content (Title, author, main body)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  feedback.title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  feedback.content,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[800],
                    height: 1.4,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Bởi: ${feedback.customerName} (${feedback.customerEmail})',
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[600],
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    Text(
                      dateFormat.format(feedback.createdAt),
                      style: TextStyle(
                        fontSize: 11,
                        color: Colors.grey[500],
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Reply section (if any)
          if (hasReply)
            Container(
              margin: const EdgeInsets.fromLTRB(16, 12, 16, 8),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.primaryColor.withOpacity(0.04),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppColors.primaryColor.withOpacity(0.15),
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(
                            Icons.support_agent_outlined,
                            size: 16,
                            color: AppColors.primaryColor,
                          ),
                          const SizedBox(width: 6),
                          Text(
                            feedback.replyAuthorName ?? 'Đội ngũ hỗ trợ',
                            style: const TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: AppColors.primaryColor,
                            ),
                          ),
                        ],
                      ),
                      if (feedback.repliedAt != null)
                        Text(
                          dateFormat.format(feedback.repliedAt!),
                          style: TextStyle(
                            fontSize: 10,
                            color: Colors.grey[500],
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    feedback.replyContent!,
                    style: TextStyle(
                      fontSize: 13,
                      color: Colors.grey[800],
                      height: 1.4,
                    ),
                  ),
                ],
              ),
            ),

          // Action Buttons
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                // Customer actions: Edit & Delete their own feedback
                if (isCustomer && isOwnFeedback) ...[
                  TextButton.icon(
                    onPressed: onEdit,
                    icon: const Icon(Icons.edit_outlined, size: 16, color: Colors.blueAccent),
                    label: const Text(
                      'Sửa',
                      style: TextStyle(fontSize: 12, color: Colors.blueAccent, fontWeight: FontWeight.w600),
                    ),
                  ),
                  TextButton.icon(
                    onPressed: onDelete,
                    icon: const Icon(Icons.delete_outline, size: 16, color: Colors.redAccent),
                    label: const Text(
                      'Xóa',
                      style: TextStyle(fontSize: 12, color: Colors.redAccent, fontWeight: FontWeight.w600),
                    ),
                  ),
                ],

                // Staff/Admin actions: Reply or Edit Reply
                if (isStaffOrAdmin) ...[
                  if (!hasReply)
                    TextButton.icon(
                      onPressed: () {
                        if (onReply != null) {
                          onReply!('');
                        }
                      },
                      icon: const Icon(Icons.reply, size: 16, color: AppColors.primaryColor),
                      label: const Text(
                        'Phản hồi',
                        style: TextStyle(fontSize: 12, color: AppColors.primaryColor, fontWeight: FontWeight.w600),
                      ),
                    )
                  else
                    TextButton.icon(
                      onPressed: () {
                        if (onReply != null) {
                          onReply!(feedback.replyContent!);
                        }
                      },
                      icon: const Icon(Icons.rate_review_outlined, size: 16, color: Colors.indigoAccent),
                      label: const Text(
                        'Sửa phản hồi',
                        style: TextStyle(fontSize: 12, color: Colors.indigoAccent, fontWeight: FontWeight.w600),
                      ),
                    ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
