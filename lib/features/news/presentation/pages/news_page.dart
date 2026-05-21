import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_event.dart';
import 'package:prm393_biopestcontrol/app/app.dart';
import 'package:prm393_biopestcontrol/shared/widgets/management_drawer.dart';
import '../bloc/news_bloc.dart';
import '../bloc/news_event.dart';
import '../bloc/news_state.dart';
import '../widgets/news_card.dart';
import '../widgets/news_filter_dialog.dart';
import '../../domain/entities/news_entity.dart';
import 'news_detail_page.dart';
import 'news_form_page.dart';

/// [NewsPage] trang quản lý tin tức dành cho Staff và Admin.
class NewsPage extends StatefulWidget {
  final AuthEntity user;
  const NewsPage({super.key, required this.user});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final TextEditingController _searchController = TextEditingController();
  String? _selectedCategory;
  bool? _selectedIsPublished;
  Timer? _debounce;

  @override
  void dispose() {
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = widget.user.role?.toLowerCase() == 'admin';

    return BlocProvider(
      create: (context) => di.sl<NewsBloc>()..add(LoadNewsListEvent()),
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Quản lý Tin tức',
              style: TextStyle(
                  color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.primaryColor),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () => _showFilterDialog(context),
                tooltip: 'Lọc tin tức',
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(70),
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
                child: TextField(
                  controller: _searchController,
                  onChanged: (value) {
                    if (_debounce?.isActive ?? false) _debounce!.cancel();
                    _debounce = Timer(const Duration(milliseconds: 500), () {
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
                    prefixIcon: const Icon(Icons.search,
                        color: AppColors.primaryColor),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
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
          drawer: ManagementDrawer(
            user: widget.user,
            isAdmin: isAdmin,
            onLogout: () {
              context.read<AuthBloc>().add(LogoutRequested());
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AuthWrapper()),
                (route) => false,
              );
            },
          ),
          body: BlocConsumer<NewsBloc, NewsState>(
            listener: (context, state) {
              if (state is NewsActionSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message),
                    backgroundColor: AppColors.primaryColor,
                  ),
                );
              }
            },
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
                      const Icon(Icons.error_outline,
                          size: 64, color: Colors.red),
                      const SizedBox(height: 16),
                      Text(state.message,
                          style: const TextStyle(color: Colors.red)),
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
                final newsList = state.newsList;

                if (newsList.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.article_outlined,
                            size: 80, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'Không tìm thấy tin tức nào',
                          style:
                              TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                        const SizedBox(height: 8),
                        TextButton(
                          onPressed: () {
                            _searchController.clear();
                            setState(() {
                              _selectedCategory = null;
                              _selectedIsPublished = null;
                            });
                            context
                                .read<NewsBloc>()
                                .add(LoadNewsListEvent());
                          },
                          child: const Text('Đặt lại bộ lọc'),
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
                        onTap: () => _navigateToDetail(context, news),
                        onEdit: () => _navigateToForm(context, news: news),
                        onDelete: () => _confirmDelete(context, news),
                      );
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
          floatingActionButton: FloatingActionButton.extended(
            onPressed: () => _navigateToForm(context),
            backgroundColor: AppColors.primaryColor,
            icon: const Icon(Icons.add, color: Colors.white),
            label: const Text('Thêm tin',
                style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, NewsEntity news) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewsDetailPage(
          news: news,
          onEdit: () => _navigateToForm(context, news: news),
          onDelete: () => _confirmDelete(context, news),
        ),
      ),
    );
  }

  void _navigateToForm(BuildContext context, {NewsEntity? news}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => NewsFormPage(
          news: news,
          user: widget.user,
          onSave: (n) {
            if (news == null) {
              context.read<NewsBloc>().add(CreateNewsEvent(n));
            } else {
              context.read<NewsBloc>().add(UpdateNewsEvent(n));
            }
          },
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, NewsEntity news) {
    showDialog(
      context: context,
      builder: (_) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Xác nhận xóa'),
        content:
            Text('Bạn có chắc muốn xóa tin tức "${news.title}" không?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              context
                  .read<NewsBloc>()
                  .add(DeleteNewsEvent(news.id!));
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child:
                const Text('Xóa', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    // Capture the bloc reference before the async gap to avoid context issues
    final newsBloc = context.read<NewsBloc>();
    showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => NewsFilterDialog(
        initialCategory: _selectedCategory,
        initialIsPublished: _selectedIsPublished,
      ),
    ).then((result) {
      if (result != null) {
        setState(() {
          _selectedCategory = result['category'];
          _selectedIsPublished = result['isPublished'];
        });
        if (_selectedCategory == null && _selectedIsPublished == null) {
          newsBloc.add(LoadNewsListEvent());
        } else {
          newsBloc.add(FilterNewsEvent(
                category: _selectedCategory,
                isPublished: _selectedIsPublished,
              ));
        }
      }
    });
  }
}
