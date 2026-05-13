import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/shared/widgets/management_drawer.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'package:prm393_biopestcontrol/features/product/presentation/bloc/product_bloc.dart';
import 'package:prm393_biopestcontrol/features/product/presentation/bloc/product_event.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_event.dart';
import 'package:prm393_biopestcontrol/features/warehouse/presentation/bloc/warehouse_bloc.dart';
import 'package:prm393_biopestcontrol/features/warehouse/presentation/widgets/warehouse_inventory_list.dart';
import 'package:prm393_biopestcontrol/features/warehouse/presentation/widgets/import_product_dialog.dart';

/// [WarehousePage] là màn hình chính của tính năng quản lý kho.
/// Hiển thị danh sách tồn kho và cho phép Admin thực hiện nhập hàng.
class WarehousePage extends StatelessWidget {
  final AuthEntity user;

  const WarehousePage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    // Kiểm tra quyền hạn của người dùng (Admin mới được nhập hàng)
    final bool isAdmin = user.role?.toLowerCase() == 'admin';

    return MultiBlocProvider(
      providers: [
        // Cung cấp WarehouseBloc để quản lý tồn kho
        BlocProvider(create: (context) => di.sl<WarehouseBloc>()..add(LoadWarehousesEvent())),
        // Cung cấp ProductBloc để lấy danh sách sản phẩm phục vụ việc nhập kho
        BlocProvider(create: (context) => di.sl<ProductBloc>()..add(LoadProductsEvent())),
      ],
      child: Builder(
        builder: (context) => Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            title: const Text(
              'Quản lý Kho hàng',
              style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
            ),
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: const IconThemeData(color: AppColors.primaryColor),
          ),
          drawer: ManagementDrawer(
            user: user,
            isAdmin: isAdmin,
            onLogout: () {
              Navigator.pop(context);
              context.read<AuthBloc>().add(LogoutRequested());
            },
          ),
          body: BlocConsumer<WarehouseBloc, WarehouseState>(
            listener: (context, state) {
              // Hiển thị thông báo khi có hành động thành công hoặc lỗi
              if (state is WarehouseActionSuccess) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message), backgroundColor: AppColors.primaryColor),
                );
              }
              if (state is WarehouseError) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.message), backgroundColor: Colors.red),
                );
              }
            },
            builder: (context, state) {
              if (state is WarehouseLoading) {
                return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
              }

              if (state is WarehouseLoaded) {
                return Column(
                  children: [
                    _buildSearchBar(context),
                    Expanded(
                      child: WarehouseInventoryList(
                        inventory: state.inventory,
                        isAdmin: isAdmin,
                      ),
                    ),
                  ],
                );
              }

              return const SizedBox.shrink();
            },
          ),
          // Chỉ Admin mới thấy nút Nhập kho (Import)
          floatingActionButton: isAdmin
              ? FloatingActionButton.extended(
                  onPressed: () => _showImportDialog(context),
                  backgroundColor: AppColors.primaryColor,
                  icon: const Icon(Icons.add_shopping_cart, color: Colors.white),
                  label: const Text('Nhập hàng', style: TextStyle(color: Colors.white)),
                )
              : null,
        ),
      ),
    );
  }

  /// Thanh tìm kiếm sản phẩm trong kho.
  Widget _buildSearchBar(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        onChanged: (value) {
          context.read<WarehouseBloc>().add(SearchWarehouseInventoryEvent(value));
        },
        decoration: InputDecoration(
          hintText: 'Tìm kiếm sản phẩm trong kho...',
          prefixIcon: const Icon(Icons.search, color: AppColors.primaryColor),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  /// Hiển thị hộp thoại nhập kho hàng loạt.
  void _showImportDialog(BuildContext context) {
    final state = context.read<WarehouseBloc>().state;
    if (state is WarehouseLoaded) {
      showDialog(
        context: context,
        builder: (dialogContext) => MultiBlocProvider(
          providers: [
            BlocProvider.value(value: context.read<WarehouseBloc>()),
            BlocProvider.value(value: context.read<ProductBloc>()),
          ],
          child: ImportProductDialog(warehouses: state.warehouses),
        ),
      );
    }
  }
}
