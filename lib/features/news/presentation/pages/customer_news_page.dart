import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import '../bloc/news_bloc.dart';
import '../bloc/news_event.dart';
import '../bloc/news_state.dart';
import '../widgets/news_card.dart';
import '../widgets/news_filter_dialog.dart';
import 'news_detail_page.dart';

/// [CustomerNewsPage] trang xem tin tức dành cho Khách hàng.
/// Chỉ hiển thị tin tức đã xuất bản (isPublished = true).
class CustomerNewsPage extends StatefulWidget {
  const CustomerNewsPage({super.key});

  @override
  State<CustomerNewsPage> createState() => _CustomerNewsPageState();
}

class _CustomerNewsPageState extends State<CustomerNewsPage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => di.sl<NewsBloc>()..add(LoadNewsListEvent()),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: const Color(0xFFF8F9FA),
          appBar: AppBar(
            title: const Text(
              'Tin tức & Bài viết',
              style: TextStyle(
                color: AppColors.primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            centerTitle: true,
            iconTheme: const IconThemeData(color: AppColors.primaryColor),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () => _showFilterDialog(context),
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(60),
              child: Container(
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce =
                        Timer(const Duration(milliseconds: 500), () {
                      if (value.isEmpty) {
                        context.read<NewsBloc>().add(LoadNewsListEvent());
                      } else {
                        context
                            .read<NewsBloc>()
                            .add(SearchNewsEvent(value));
                      }
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm tin tức...',
                    hintStyle:
                        const TextStyle(color: Colors.grey, fontSize: 14),
                    prefixIcon: const Icon(Icons.search,
                        color: AppColors.primaryColor),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear, size: 18),
                            onPressed: () {
                              _searchController.clear();
                              context
                                  .read<NewsBloc>()
                                  .add(LoadNewsListEvent());
                            },
                          )
                        : null,
                    filled: true,
                    fillColor: const Color(0xFFF5F5F5),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                    contentPadding: const EdgeInsets.symmetric(vertical: 0),
                  ),
                ),
              ),
            ),
          ),
          body: BlocBuilder<NewsBloc, NewsState>(
            builder: (context, state) {
              if (state is NewsLoading) {
                return const Center(
                  child: CircularProgressIndicator(
                      color: AppColors.primaryColor),
                );
              }

              if (state is NewsError) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(Icons.wifi_off, size: 64, color: Colors.grey),
                      const SizedBox(height: 16),
                      const Text('Không thể tải tin tức',
                          style: TextStyle(color: Colors.grey)),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () => context
                            .read<NewsBloc>()
                            .add(LoadNewsListEvent()),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                        ),
                        child: const Text('Thử lại',
                            style: TextStyle(color: Colors.white)),
                      ),
                    ],
                  ),
                );
              }

              if (state is NewsLoaded) {
                // Khách hàng chỉ xem tin tức đã xuất bản
                final newsList =
                    state.newsList.where((n) => n.isPublished).toList();

                if (newsList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.article_outlined,
                            size: 80, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'Chưa có tin tức nào',
                          style: TextStyle(
                              color: Colors.grey[600], fontSize: 16),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  color: AppColors.primaryColor,
                  onRefresh: () async {
                    context.read<NewsBloc>().add(LoadNewsListEvent());
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: newsList.length,
                    itemBuilder: (ctx, index) {
                      final news = newsList[index];
                      return NewsCard(
                        news: news,
                        onTap: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => NewsDetailPage(news: news),
                          ),
                        ),
                        // Không hiện nút sửa/xóa cho khách hàng
                        onEdit: null,
                        onDelete: null,
                      );
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    // Capture the bloc reference before the async gap
    final newsBloc = context.read<NewsBloc>();
    showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => NewsFilterDialog(
        initialCategory: _selectedCategory,
        initialIsPublished: true, // Khách chỉ xem tin đã đăng
      ),
    ).then((result) {
      if (result != null) {
        setState(() => _selectedCategory = result['category']);
        newsBloc.add(FilterNewsEvent(
              category: _selectedCategory,
              isPublished: true, // Luôn chỉ lọc tin đã xuất bản
            ));
      }
    });
  }
}
