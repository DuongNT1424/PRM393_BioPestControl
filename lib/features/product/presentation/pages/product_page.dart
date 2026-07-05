import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../widgets/product_card.dart';
import '../../domain/entities/product_entity.dart';
import 'product_detail_page.dart';
import 'product_form_page.dart';
import '../widgets/product_filter_dialog.dart';
import 'package:prm393_biopestcontrol/features/category/domain/entities/category_entity.dart';
import 'package:prm393_biopestcontrol/features/category/presentation/bloc/category_bloc.dart';
import 'package:prm393_biopestcontrol/features/category/presentation/bloc/category_event.dart';
import 'package:prm393_biopestcontrol/features/category/presentation/bloc/category_state.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_event.dart';
import 'package:prm393_biopestcontrol/shared/widgets/management_drawer.dart';

class ProductPage extends StatefulWidget {
  final AuthEntity user;
  const ProductPage({super.key, required this.user});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final TextEditingController _searchController = TextEditingController();
  int? _selectedCategoryId;
  bool? _selectedIsActive;
  Timer? _debounce;

  @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchTextChanged);
  }

  void _onSearchTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');
    final bool isAdmin = widget.user.role?.toLowerCase() == 'admin';

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<ProductBloc>()..add(LoadProductsEvent())),
        BlocProvider(create: (context) => di.sl<CategoryBloc>()..add(LoadCategoriesEvent())),
      ],
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Quản lý Sản phẩm',
              style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.primaryColor),
            actions: [
              IconButton(
                icon: const Icon(Icons.filter_list),
                onPressed: () => _showFilterDialog(context),
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
                      context.read<ProductBloc>().add(SearchProductEvent(value));
                    });
                  },
                  decoration: InputDecoration(
                    hintText: 'Tìm kiếm sản phẩm...',
                    prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
                    suffixIcon: _searchController.text.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear),
                            onPressed: () {
                              _searchController.clear();
                              context.read<ProductBloc>().add(LoadProductsEvent());
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
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
          ),
          body: BlocConsumer<ProductBloc, ProductState>(
            buildWhen: (previous, current) {
              return current is ProductLoading || current is ProductLoaded || current is ProductError;
            },
            listener: (context, state) {
              if (state is ProductActionSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message), backgroundColor: AppColors.primaryColor),
                );
              }
            },
            builder: (context, state) {
              if (state is ProductLoading) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
              }

              if (state is ProductError) {
                return Center(child: Text(state.message, style: const TextStyle(color: Colors.red)));
              }

              if (state is ProductLoaded) {
                final products = state.products;

                if (products.isEmpty) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory_2_outlined, size: 80, color: Colors.grey[300]),
                        const SizedBox(height: 16),
                        Text(
                          'Không tìm thấy sản phẩm nào',
                          style: TextStyle(color: Colors.grey[600], fontSize: 16),
                        ),
                        TextButton(
                          onPressed: () {
                            _searchController.clear();
                            context.read<ProductBloc>().add(LoadProductsEvent());
                          },
                          child: const Text('Đặt lại bộ lọc'),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () async {
                    context.read<ProductBloc>().add(LoadProductsEvent());
                  },
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: products.length,
                    itemBuilder: (builderContext, index) {
                      final product = products[index];
                      return ProductCard(
                        product: product,
                        currencyFormat: currencyFormat,
                        onTap: () => _navigateToDetail(context, product),
                      );
                    },
                  ),
                );
              }

              return const SizedBox.shrink();
            },
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () => _navigateToForm(context),
            backgroundColor: AppColors.primaryColor,
            child: const Icon(Icons.add, color: Colors.white),
          ),
        ),
      ),
    );
  }

  void _navigateToDetail(BuildContext context, ProductEntity product) {
    final productBloc = context.read<ProductBloc>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: productBloc,
          child: ProductDetailPage(
            product: product,
            onEdit: (p) => _navigateToForm(context, product: p),
            onDelete: (id) => productBloc.add(DeleteProductEvent(id)),
          ),
        ),
      ),
    );
  }

  void _navigateToForm(BuildContext context, {ProductEntity? product}) {
    final productBloc = context.read<ProductBloc>();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => ProductFormPage(
          product: product,
          onSave: (p) {
            if (product == null) {
              productBloc.add(AddProductEvent(p));
            } else {
              productBloc.add(UpdateProductEvent(p));
            }
          },
        ),
      ),
    );
  }

  void _showFilterDialog(BuildContext context) {
    final productBloc = context.read<ProductBloc>();
    final categoryState = context.read<CategoryBloc>().state;
    List<CategoryEntity> categories = [];
    if (categoryState is CategoryLoaded) {
      categories = categoryState.categories;
    }

    showDialog<Map<String, dynamic>>(
      context: context,
      builder: (context) => ProductFilterDialog(
        categories: categories,
        initialCategoryId: _selectedCategoryId,
        initialIsActive: _selectedIsActive,
      ),
    ).then((result) {
      if (result != null) {
        _selectedCategoryId = result['categoryId'];
        _selectedIsActive = result['isActive'];
        productBloc.add(FilterProductEvent(
              categoryId: _selectedCategoryId,
              isActive: _selectedIsActive,
            ));
      }
    });
  }
}
