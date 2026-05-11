import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import 'package:prm393_biopestcontrol/features/category/domain/entities/category_entity.dart';
import 'package:prm393_biopestcontrol/features/category/presentation/bloc/category_bloc.dart';
import 'package:prm393_biopestcontrol/features/category/presentation/bloc/category_event.dart';
import 'package:prm393_biopestcontrol/features/category/presentation/bloc/category_state.dart';
import 'package:prm393_biopestcontrol/features/category/presentation/widgets/category_card.dart';
import 'package:prm393_biopestcontrol/shared/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/injection_container.dart' as di;

class CategoryPage extends StatelessWidget {
  final AuthEntity user;

  const CategoryPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = user.role?.toLowerCase() == 'admin';

    return BlocProvider(
      create: (context) => di.sl<CategoryBloc>()..add(LoadCategoriesEvent()),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text(
            'Quản lý Danh mục',
            style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          iconTheme: const IconThemeData(color: AppColors.primaryColor),
        ),
        body: BlocConsumer<CategoryBloc, CategoryState>(
          listener: (context, state) {
            if (state is CategoryError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message), backgroundColor: Colors.red),
              );
            }
          },
          builder: (context, state) {
            if (state is CategoryLoading) {
              return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
            }

            if (state is CategoryLoaded) {
              final categories = state.categories;

              if (categories.isEmpty) {
                return const Center(child: Text('Không có danh mục nào'));
              }

              return ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: categories.length,
                separatorBuilder: (context, index) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  return CategoryCard(
                    category: categories[index],
                    isAdmin: isAdmin,
                    onEdit: () => _showCategoryDialog(context, category: categories[index]),
                    onDelete: () => _showDeleteConfirm(context, categories[index]),
                  );
                },
              );
            }

            return const SizedBox.shrink();
          },
        ),
        floatingActionButton: isAdmin
            ? FloatingActionButton(
                onPressed: () => _showCategoryDialog(context),
                backgroundColor: AppColors.primaryColor,
                child: const Icon(Icons.add, color: Colors.white),
              )
            : null,
      ),
    );
  }

  void _showCategoryDialog(BuildContext context, {CategoryEntity? category}) {
    final nameController = TextEditingController(text: category?.name);
    final descController = TextEditingController(text: category?.description);
    final bool isEdit = category != null;

    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(isEdit ? 'Sửa danh mục' : 'Thêm danh mục mới'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Tên danh mục'),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: descController,
              decoration: const InputDecoration(labelText: 'Mô tả'),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              final newCategory = CategoryEntity(
                id: isEdit ? category!.id : DateTime.now().millisecondsSinceEpoch,
                name: nameController.text,
                description: descController.text,
              );
              
              if (isEdit) {
                context.read<CategoryBloc>().add(UpdateCategoryEvent(newCategory));
              } else {
                context.read<CategoryBloc>().add(AddCategoryEvent(newCategory));
              }
              Navigator.pop(dialogContext);
            },
            child: Text(isEdit ? 'Cập nhật' : 'Thêm'),
          ),
        ],
      ),
    );
  }

  void _showDeleteConfirm(BuildContext context, CategoryEntity category) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Xác nhận xóa'),
        content: Text('Bạn có chắc muốn xóa danh mục "${category.name}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Hủy'),
          ),
          ElevatedButton(
            onPressed: () {
              context.read<CategoryBloc>().add(DeleteCategoryEvent(category.id));
              Navigator.pop(dialogContext);
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Xóa', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }
}
