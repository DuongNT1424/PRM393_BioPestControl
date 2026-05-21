import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import '../../domain/entities/news_entity.dart';

/// [NewsDetailPage] hiển thị chi tiết một tin tức/bài viết.
class NewsDetailPage extends StatelessWidget {
  final NewsEntity news;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const NewsDetailPage({
    super.key,
    required this.news,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm', 'vi_VN');

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // SliverAppBar với ảnh bìa
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            backgroundColor: AppColors.primaryColor,
            foregroundColor: Colors.white,
            iconTheme: const IconThemeData(color: Colors.white),
            actions: [
              if (onEdit != null)
                IconButton(
                  icon: const Icon(Icons.edit_outlined),
                  onPressed: () {
                    Navigator.pop(context);
                    onEdit!();
                  },
                  tooltip: 'Chỉnh sửa',
                ),
              if (onDelete != null)
                IconButton(
                  icon: const Icon(Icons.delete_outline),
                  color: Colors.red[200],
                  onPressed: () {
                    Navigator.pop(context);
                    onDelete!();
                  },
                  tooltip: 'Xóa',
                ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: news.imageUrl != null && news.imageUrl!.isNotEmpty
                  ? Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.network(
                          news.imageUrl!,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              _buildImagePlaceholder(),
                        ),
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Colors.black.withValues(alpha: 0.6),
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  : _buildImagePlaceholder(),
            ),
          ),

          // Nội dung bài viết
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Badges: Danh mục + Trạng thái
                  Row(
                    children: [
                      if (news.category != null)
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 4),
                          decoration: BoxDecoration(
                            color: AppColors.primaryColor
                                .withValues(alpha: 0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            news.category!,
                            style: const TextStyle(
                              color: AppColors.primaryColor,
                              fontSize: 12,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      const SizedBox(width: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 4),
                        decoration: BoxDecoration(
                          color: news.isPublished
                              ? Colors.green.withValues(alpha: 0.1)
                              : Colors.orange.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          news.isPublished ? 'Đã đăng' : 'Nháp',
                          style: TextStyle(
                            color: news.isPublished
                                ? Colors.green
                                : Colors.orange,
                            fontSize: 12,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Tiêu đề
                  Text(
                    news.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black87,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Thông tin tác giả và ngày đăng
                  Row(
                    children: [
                      const CircleAvatar(
                        radius: 16,
                        backgroundColor: AppColors.primaryColor,
                        child:
                            Icon(Icons.person, size: 16, color: Colors.white),
                      ),
                      const SizedBox(width: 8),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            news.authorName ?? 'Admin',
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 13,
                              color: Colors.black87,
                            ),
                          ),
                          if (news.createdAt != null)
                            Text(
                              dateFormat.format(news.createdAt!),
                              style: const TextStyle(
                                  fontSize: 12, color: Colors.grey),
                            ),
                        ],
                      ),
                    ],
                  ),

                  if (news.summary != null) ...[
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: AppColors.primaryColor.withValues(alpha: 0.06),
                        borderRadius: BorderRadius.circular(12),
                        // Fix: Border.left() is not a static method — use Border() with only left side
                        border: const Border(
                          left: BorderSide(
                            color: AppColors.primaryColor,
                            width: 3,
                          ),
                        ),
                      ),
                      child: Text(
                        news.summary!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black87,
                          fontStyle: FontStyle.italic,
                          height: 1.5,
                        ),
                      ),
                    ),
                  ],

                  const Divider(height: 32),

                  // Nội dung bài viết
                  Text(
                    news.content,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.black87,
                      height: 1.7,
                    ),
                  ),

                  const SizedBox(height: 32),

                  // Thông tin cập nhật cuối
                  if (news.updatedAt != null)
                    Text(
                      'Cập nhật lần cuối: ${dateFormat.format(news.updatedAt!)}',
                      style:
                          const TextStyle(fontSize: 12, color: Colors.grey),
                    ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImagePlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primaryColor,
            AppColors.primaryColor.withValues(alpha: 0.5),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: const Center(
        child: Icon(Icons.article_outlined, size: 64, color: Colors.white54),
      ),
    );
  }
}
