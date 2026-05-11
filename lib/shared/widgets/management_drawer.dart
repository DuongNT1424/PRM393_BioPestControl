import 'package:flutter/material.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import 'package:prm393_biopestcontrol/shared/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/features/product/presentation/pages/product_page.dart';
import 'package:prm393_biopestcontrol/features/category/presentation/pages/category_page.dart';

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
    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
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
          ListTile(
            leading: const Icon(Icons.dashboard_outlined),
            title: const Text('Dashboard'),
            selectedTileColor: AppColors.primaryColor,
            selectedColor: Colors.white,
            selected: true, // Giả định Dashboard đang được chọn
            onTap: () => Navigator.pop(context),
          ),
          _buildMenuItem(
            context,
            icon: Icons.warehouse_outlined,
            title: 'Warehouse',
            onTap: () {},
          ),
          _buildMenuItem(
            context,
            icon: Icons.eco,
            title: 'Product',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const ProductPage()),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.category_outlined,
            title: 'Category',
            onTap: () {
              Navigator.pop(context);
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => CategoryPage(user: user)),
              );
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
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Logout', style: TextStyle(color: Colors.redAccent)),
            onTap: onLogout,
          ),
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
