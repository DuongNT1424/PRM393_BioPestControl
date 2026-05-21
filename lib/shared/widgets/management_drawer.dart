import 'package:flutter/material.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/features/product/presentation/pages/product_page.dart';
import 'package:prm393_biopestcontrol/features/category/presentation/pages/category_page.dart';
import 'package:prm393_biopestcontrol/features/warehouse/presentation/pages/warehouse_page.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/features/staff/presentation/pages/staff_page.dart';
import 'package:prm393_biopestcontrol/features/customer/presentation/pages/customer_management_page.dart';
import 'package:prm393_biopestcontrol/features/discount/presentation/pages/discount_management_page.dart';
import 'package:prm393_biopestcontrol/features/profile/presentation/pages/profile_page.dart';
import 'package:prm393_biopestcontrol/features/notification/presentation/pages/send_notification_page.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_event.dart';

/// [ManagementDrawer] là Menu bên (Side Menu) dùng cho hệ thống quản trị.
///
/// Chứa các liên kết điều hướng đến các tính năng như Kho hàng, Sản phẩm, Đơn hàng...
/// Giao diện tự động điều chỉnh hiển thị các mục menu dựa trên vai trò [isAdmin].
///
/// QUAN TRỌNG: Chiến lược điều hướng trong drawer sử dụng hai cơ chế khác nhau:
/// - Nếu trang hiện tại là root (isFirst == true): dùng [Navigator.push] để xếp trang mới lên trên,
///   đảm bảo route gốc `/` chứa [AuthWrapper] không bao giờ bị xóa hay thay thế.
/// - Nếu trang hiện tại là non-root (một sub-page): dùng [Navigator.pushReplacement] để thay thế
///   sub-page hiện tại, giữ nguyên root ở dưới cùng của stack.
/// Điều này ngăn lỗi [Navigator] crash do stack history rỗng và màn hình đen khi bấm back.
class ManagementDrawer extends StatelessWidget {
  /// Thông tin người dùng để hiển thị trên Header của Drawer.
  final AuthEntity user;

  /// Biến kiểm tra quyền Admin để hiển thị/ẩn các mục quản lý nhân sự.
  final bool isAdmin;

  /// Hàm callback xử lý đăng xuất (hiện không còn dùng trực tiếp, drawer tự xử lý).
  final VoidCallback onLogout;

  const ManagementDrawer({
    super.key,
    required this.user,
    required this.isAdmin,
    required this.onLogout,
  });

  /// Điều hướng an toàn đến một trang quản trị.
  ///
  /// Logic:
  /// - Đóng drawer bằng [Navigator.pop].
  /// - Nếu đang ở trang mục tiêu ([routeName] khớp với route hiện tại), không làm gì thêm.
  /// - Nếu đang ở route gốc (root = `/`): dùng [Navigator.push] để xếp trang mới lên trên,
  ///   không bao giờ xóa route gốc.
  /// - Nếu đang ở sub-page: dùng [Navigator.pushReplacement] để hoán đổi sub-page hiện tại,
  ///   giữ nguyên route gốc ở dưới cùng.
  void _navigateToPage(BuildContext context, Widget targetPage, String routeName) {
    // Đóng drawer trước
    Navigator.pop(context);

    final currentRoute = ModalRoute.of(context)?.settings.name;

    // Nếu đang ở đúng trang mục tiêu rồi thì không điều hướng nữa
    if (currentRoute == routeName) return;

    // Kiểm tra xem trang hiện tại có phải là route gốc không
    final isRootRoute = ModalRoute.of(context)?.isFirst ?? true;

    if (isRootRoute) {
      // Đang ở root: push lên trên, giữ root an toàn
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => targetPage,
          settings: RouteSettings(name: routeName),
        ),
      );
    } else {
      // Đang ở sub-page: hoán đổi sub-page hiện tại, giữ root nguyên
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => targetPage,
          settings: RouteSettings(name: routeName),
        ),
      );
    }
  }

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
                    // Đóng drawer
                    Navigator.pop(context);
                    // Pop về route gốc - nơi AuthWrapper và ManagementPage đang sống
                    // Đây là cách an toàn nhất để quay về Dashboard mà không tạo instance mới
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  },
                ),
                if (!isAdmin)
                  _buildMenuItem(
                    context,
                    icon: Icons.person_outline,
                    title: 'My Profile',
                    selected: currentRoute == '/profile',
                    onTap: () => _navigateToPage(
                      context,
                      ProfilePage(user: user),
                      '/profile',
                    ),
                  ),
                _buildMenuItem(
                  context,
                  icon: Icons.warehouse_outlined,
                  title: 'Warehouse',
                  selected: currentRoute == '/warehouse',
                  onTap: () => _navigateToPage(
                    context,
                    WarehousePage(user: user),
                    '/warehouse',
                  ),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.eco,
                  title: 'Product',
                  selected: currentRoute == '/products',
                  onTap: () => _navigateToPage(
                    context,
                    ProductPage(user: user),
                    '/products',
                  ),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.category_outlined,
                  title: 'Category',
                  selected: currentRoute == '/categories',
                  onTap: () => _navigateToPage(
                    context,
                    CategoryPage(user: user),
                    '/categories',
                  ),
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
                  selected: currentRoute == '/discounts',
                  onTap: () => _navigateToPage(
                    context,
                    DiscountManagementPage(user: user),
                    '/discounts',
                  ),
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.article_outlined,
                  title: 'News/Article',
                  onTap: () {},
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.notifications_active_outlined,
                  title: 'Send Notification',
                  selected: currentRoute == '/send_notification',
                  onTap: () {
                    // SendNotificationPage dùng Navigator.push (không phải pushReplacement)
                    // vì nó là một trang modal riêng, không cùng cấp với các trang quản lý khác
                    Navigator.pop(context); // Đóng drawer
                    if (currentRoute != '/send_notification') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SendNotificationPage(),
                          settings: const RouteSettings(name: '/send_notification'),
                        ),
                      );
                    }
                  },
                ),
                _buildMenuItem(
                  context,
                  icon: Icons.notifications_active_outlined,
                  title: 'Send Notification',
                  selected: currentRoute == '/send_notification',
                  onTap: () {
                    // SendNotificationPage dùng Navigator.push (không phải pushReplacement)
                    // vì nó là một trang modal riêng, không cùng cấp với các trang quản lý khác
                    Navigator.pop(context); // Đóng drawer
                    if (currentRoute != '/send_notification') {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SendNotificationPage(),
                          settings: const RouteSettings(name: '/send_notification'),
                        ),
                      );
                    }
                  },
                ),
                if (isAdmin)
                  _buildMenuItem(
                    context,
                    icon: Icons.badge_outlined,
                    title: 'Staff',
                    selected: currentRoute == '/staff',
                    onTap: () => _navigateToPage(
                      context,
                      StaffPage(user: user),
                      '/staff',
                    ),
                  ),
                _buildMenuItem(
                  context,
                  icon: Icons.people_alt_outlined,
                  title: 'Customer',
                  selected: currentRoute == '/customers',
                  onTap: () => _navigateToPage(
                    context,
                    CustomerManagementPage(user: user),
                    '/customers',
                  ),
                ),
              ],
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Logout', style: TextStyle(color: Colors.redAccent)),
            onTap: () {
              // Đóng drawer trước
              Navigator.pop(context);
              // Gửi sự kiện đăng xuất đến AuthBloc
              context.read<AuthBloc>().add(LogoutRequested());
              // Pop về route gốc (AuthWrapper sẽ tự động hiển thị LoginPage khi state = Unauthenticated)
              // Không dùng pushAndRemoveUntil vì sẽ xóa mất route gốc `/` gây crash Navigator
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
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
