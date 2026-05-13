import 'package:flutter/material.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import 'package:prm393_biopestcontrol/shared/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/features/product/presentation/pages/product_page.dart';
import 'package:prm393_biopestcontrol/features/category/presentation/pages/category_page.dart';
import 'package:prm393_biopestcontrol/features/warehouse/presentation/pages/warehouse_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/features/statistics/presentation/pages/management_page.dart';
import 'package:prm393_biopestcontrol/features/statistics/presentation/bloc/statistics_bloc.dart';
import 'package:prm393_biopestcontrol/features/statistics/presentation/bloc/statistics_event.dart';
import 'package:prm393_biopestcontrol/injection_container.dart' as di;

/// [ManagementDrawer] là Menu bên (Side Menu) dùng cho hệ thống quản trị.
/// 
/// Chứa các liên kết điều hướng đến các tính năng như Kho hàng, Sản phẩm, Đơn hàng...
/// Giao diện tự động điều chỉnh hiển thị các mục menu dựa trên vai trò [isAdmin].
class ManagementDrawer extends StatelessWidget {
  /// Thông tin người dùng để hiển thị trên Header của Drawer.
  final AuthEntity user;
  
  /// Biến kiểm tra quyền Admin để hiển thị/ẩn các mục quản lý nhân sự.
  final bool isAdmin;
  
  /// Hàm callback xử lý đăng xuất.
  final VoidCallback onLogout;

  const ManagementDrawer({
    super.key,
    required this.user,
    required this.isAdmin,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    // Xác định trang hiện tại dựa trên ModalRoute để đánh dấu 'selected'
    final String? currentRoute = ModalRoute.of(context)?.settings.name;

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(
              user.name ?? 'No Name',
              style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
            ),
            accountEmail: Text(
              user.email ?? 'No Email',
              style: const TextStyle(color: Colors.black87),
            ),
            currentAccountPicture: CircleAvatar(
              backgroundColor: AppColors.primaryColor.withOpacity(0.1),
              child: Text(
                user.name?[0].toUpperCase() ?? 'U',
                style: const TextStyle(fontSize: 40.0, color: AppColors.primaryColor, fontWeight: FontWeight.bold),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.white,
              border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: [
                _buildMenuItem(
                  context,
                  icon: Icons.dashboard_outlined,
                  title: 'Dashboard',
                  selected: currentRoute == '/management' || currentRoute == '/',
                  onTap: () {
                    Navigator.pop(context); // Đóng drawer
                    if (currentRoute != '/management' && currentRoute != '/') {
                      // Vì ManagementPage cần StatisticsBloc, chúng ta điều hướng qua AuthWrapper hoặc tái tạo lại
                      // Tuy nhiên đơn giản nhất là pop cho đến khi về trang gốc nếu dùng pushReplacement
                      // Hoặc dùng Navigator.pushReplacement
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MultiBlocProvider(
                            providers: [
                              BlocProvider(create: (context) => di.sl<StatisticsBloc>()..add(const LoadStatisticsEvent())),
                            ],
                            child: ManagementPage(user: user),
                          ),
                          settings: const RouteSettings(name: '/management'),
                        ),
                      );
                    }
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.warehouse_outlined,
                  title: 'Warehouse',
                  selected: currentRoute == '/warehouse',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRoute != '/warehouse') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => WarehousePage(user: user),
                          settings: const RouteSettings(name: '/warehouse'),
                        ),
                      );
                    }
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.eco,
                  title: 'Product',
                  selected: currentRoute == '/products',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRoute != '/products') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProductPage(user: user),
                          settings: const RouteSettings(name: '/products'),
                        ),
                      );
                    }
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.category_outlined,
                  title: 'Category',
                  selected: currentRoute == '/categories',
                  onTap: () {
                    Navigator.pop(context);
                    if (currentRoute != '/categories') {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoryPage(user: user),
                          settings: const RouteSettings(name: '/categories'),
                        ),
                      );
                    }
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.shopping_cart_outlined,
                  title: 'Order',
                  onTap: () {},
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.sell_outlined,
                  title: 'Discount',
                  onTap: () {},
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.article_outlined,
                  title: 'News/Article',
                  onTap: () {},
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.security_outlined,
                  title: 'Chemical Safety',
                  onTap: () {},
                ),
                if (isAdmin)
                  _buildMenuItem(
                    context,
                    icon: Icons.badge_outlined,
                    title: 'Staff',
                    onTap: () {},
                  ),
                _buildMenuItem(
                  context,
                  icon: Icons.people_alt_outlined,
                  title: 'Customer',
                  onTap: () {},
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Logout', style: TextStyle(color: Colors.redAccent)),
            onTap: onLogout,
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    bool selected = false,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: selected ? Colors.white : Colors.black87),
      title: Text(title, style: TextStyle(color: selected ? Colors.white : Colors.black87)),
      selected: selected,
      selectedTileColor: AppColors.primaryColor,
      selectedColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      onTap: onTap,
    );
  }
}
