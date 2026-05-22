import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import '../bloc/auth_bloc.dart';
import '../bloc/auth_event.dart';
import 'package:prm393_biopestcontrol/features/product/domain/entities/product_entity.dart';
import 'package:prm393_biopestcontrol/features/product/presentation/bloc/product_bloc.dart';
import 'package:prm393_biopestcontrol/features/product/presentation/bloc/product_event.dart';
import 'package:prm393_biopestcontrol/features/product/presentation/bloc/product_state.dart';
import 'package:prm393_biopestcontrol/features/category/presentation/bloc/category_bloc.dart';
import 'package:prm393_biopestcontrol/features/category/presentation/bloc/category_event.dart';
import 'package:prm393_biopestcontrol/features/category/presentation/bloc/category_state.dart';
import 'package:prm393_biopestcontrol/features/cart/presentation/pages/cart_page.dart';
import 'package:prm393_biopestcontrol/features/cart/presentation/bloc/cart_bloc.dart';
import 'package:prm393_biopestcontrol/features/cart/presentation/bloc/cart_event.dart';
import 'package:prm393_biopestcontrol/features/cart/presentation/bloc/cart_state.dart';
import 'package:prm393_biopestcontrol/features/product/presentation/pages/customer_product_detail_page.dart';
import 'package:prm393_biopestcontrol/features/product/presentation/pages/customer_all_products_page.dart';
import 'package:prm393_biopestcontrol/features/profile/presentation/pages/profile_page.dart';
import 'package:prm393_biopestcontrol/features/notification/presentation/pages/notification_page.dart';
import 'package:prm393_biopestcontrol/features/notification/presentation/bloc/notification_bloc.dart';
import 'package:prm393_biopestcontrol/features/notification/presentation/bloc/notification_event.dart';
import 'package:prm393_biopestcontrol/features/notification/presentation/bloc/notification_state.dart';
import 'package:prm393_biopestcontrol/features/order/presentation/pages/customer_order_list_page.dart';
import 'package:prm393_biopestcontrol/features/news/presentation/pages/customer_news_page.dart';

class CustomerPage extends StatefulWidget {
  final AuthEntity user;
  
  const CustomerPage({super.key, required this.user});

  @override
  State<CustomerPage> createState() => _CustomerPageState();
}

class _CustomerPageState extends State<CustomerPage> {
  int _currentIndex = 0;
  int? _selectedCategoryId;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => di.sl<ProductBloc>()..add(LoadProductsEvent())),
        BlocProvider(create: (context) => di.sl<CategoryBloc>()..add(LoadCategoriesEvent())),
        BlocProvider(create: (context) => di.sl<NotificationBloc>()..add(LoadNotificationsEvent(widget.user.id ?? ''))),
      ],
      child: Scaffold(
        backgroundColor: AppColors.backgroundColor,
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildStoreTab(),
            _buildPlaceholderTab('Chuyên gia'),
            const CustomerOrderListPage(),
            _buildProfileTab(),
          ],
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            border: Border(top: BorderSide(color: Colors.grey[200]!)),
          ),
          child: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            backgroundColor: AppColors.surfaceColor.withOpacity(0.95),
            currentIndex: _currentIndex,
            selectedItemColor: AppColors.primaryColor,
            unselectedItemColor: Colors.grey[500],
            selectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
            unselectedLabelStyle: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 0.5),
            elevation: 0,
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            items: const [
              BottomNavigationBarItem(
                icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.storefront, size: 22)),
                label: 'CHỢ',
              ),
              BottomNavigationBarItem(
                icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.psychology_alt, size: 22)),
                label: 'CHUYÊN GIA',
              ),
              BottomNavigationBarItem(
                icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.shopping_bag_outlined, size: 22)),
                label: 'ĐƠN HÀNG',
              ),
              BottomNavigationBarItem(
                icon: Padding(padding: EdgeInsets.only(bottom: 4), child: Icon(Icons.person_outline, size: 22)),
                label: 'TÔI',
              ),
            ],
          ),
        ),
        floatingActionButton: _currentIndex == 0 ? FloatingActionButton(
          onPressed: () {},
          backgroundColor: AppColors.primaryColor,
          elevation: 4,
          shape: const CircleBorder(),
          child: const Icon(Icons.chat_bubble_outline, color: Colors.white),
        ) : null,
      ),
    );
  }

  Widget _buildStoreTab() {
    return CustomScrollView(
      slivers: [
        // Header
        SliverAppBar(
          pinned: true,
          floating: true,
          backgroundColor: const Color(0xFFF1F5F1).withOpacity(0.95),
          elevation: 0,
          toolbarHeight: 110,
          flexibleSpace: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.location_on, color: AppColors.primaryColor, size: 16),
                          const SizedBox(width: 4),
                          Text('TIỀN GIANG', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: Colors.grey[700], letterSpacing: 1)),
                        ],
                      ),
                      Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => NotificationPage(user: widget.user),
                                ),
                              ).then((_) {
                                if (mounted) {
                                  context.read<NotificationBloc>().add(LoadNotificationsEvent(widget.user.id ?? ''));
                                }
                              });
                            },
                            child: BlocBuilder<NotificationBloc, NotificationState>(
                              builder: (context, state) {
                                int unreadCount = 0;
                                if (state is NotificationLoaded) {
                                  unreadCount = state.notifications.where((element) => !element.isRead).length;
                                }

                                return Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Icon(Icons.notifications_none, color: Colors.grey[700], size: 22),
                                    if (unreadCount > 0)
                                      Positioned(
                                        right: -2,
                                        top: -2,
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(
                                            color: Colors.redAccent,
                                            shape: BoxShape.circle,
                                          ),
                                          constraints: const BoxConstraints(
                                            minWidth: 14,
                                            minHeight: 14,
                                          ),
                                          child: Text(
                                            '$unreadCount',
                                            style: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 7,
                                              fontWeight: FontWeight.bold,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                          const SizedBox(width: 16),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) => const CartPage()));
                            },
                            child: BlocBuilder<CartBloc, CartState>(
                              builder: (context, state) {
                                return Stack(
                                  clipBehavior: Clip.none,
                                  children: [
                                    Icon(Icons.shopping_cart_outlined, color: Colors.grey[700], size: 22),
                                    if (state.totalItems > 0)
                                      Positioned(
                                        right: -4,
                                        top: -4,
                                        child: Container(
                                          padding: const EdgeInsets.all(4),
                                          decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                                          child: Text(
                                            '${state.totalItems}',
                                            style: const TextStyle(color: Colors.white, fontSize: 8, fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    decoration: const BoxDecoration(
                      border: Border(bottom: BorderSide(color: Colors.black12, width: 1)),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey[500], size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Tìm kiếm giải pháp...',
                              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                              border: InputBorder.none,
                              isDense: true,
                              contentPadding: const EdgeInsets.symmetric(vertical: 8),
                              fillColor: Colors.transparent,
                              filled: true,
                            ),
                            style: const TextStyle(fontSize: 14),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        
        // Body
        SliverToBoxAdapter(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildHeroBanner(),
                const SizedBox(height: 40),
                _buildCategories(),
                const SizedBox(height: 40),
                _buildProductSection(),
                const SizedBox(height: 40),
                _buildBlogSection(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildHeroBanner() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: double.infinity,
          height: 180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.grey[100],
            image: const DecorationImage(
              image: NetworkImage('https://images.unsplash.com/photo-1595841696677-6489ff3f8cd1?q=80&w=800&auto=format&fit=crop'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 16),
        const Text(
          'Giải Pháp Sinh Học Cho Cây Lúa',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.w600, letterSpacing: -0.5, color: Colors.black87),
        ),
        const SizedBox(height: 8),
        Text(
          'Tăng năng suất bền vững với công nghệ vi sinh hiện đại nhất.',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        const SizedBox(height: 12),
        GestureDetector(
          onTap: () {
            final productBloc = context.read<ProductBloc>();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => BlocProvider.value(
                  value: productBloc,
                  child: const CustomerAllProductsPage(),
                ),
              ),
            );
          },
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Xem tất cả sản phẩm',
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
              ),
              SizedBox(width: 4),
              Icon(Icons.arrow_forward, size: 16, color: AppColors.primaryColor),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildCategories() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'DANH MỤC',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),
        BlocBuilder<CategoryBloc, CategoryState>(
          builder: (context, state) {
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  _buildCategoryChip(context, null, 'Tất cả'),
                  if (state is CategoryLoaded)
                    ...state.categories.map((c) => _buildCategoryChip(context, c.id, c.name)),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCategoryChip(BuildContext context, int? id, String name) {
    final isSelected = _selectedCategoryId == id;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: InkWell(
        onTap: () {
          setState(() {
            _selectedCategoryId = id;
          });
          context.read<ProductBloc>().add(FilterProductEvent(categoryId: id, isActive: true));
        },
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryColor : Colors.transparent,
            border: Border.all(
              color: isSelected ? AppColors.primaryColor : Colors.grey[300]!,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            name,
            style: TextStyle(
              fontSize: 12,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              color: isSelected ? Colors.white : Colors.grey[700],
            ),
          ),
        ),
      ),
    );
  }


  Widget _buildProductSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'SẢN PHẨM NỔI BẬT',
          style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),
        BlocBuilder<ProductBloc, ProductState>(
          builder: (context, state) {
            if (state is ProductLoading) {
              return const Center(child: Padding(
                padding: EdgeInsets.all(32.0),
                child: CircularProgressIndicator(color: AppColors.primaryColor),
              ));
            }
            if (state is ProductLoaded) {
              final products = state.products.where((p) => p.isActive).toList(); // Hiện ra tất cả sản phẩm
              if (products.isEmpty) {
                return const Text('Không có sản phẩm nào.');
              }
              return GridView.builder(
                shrinkWrap: true,
                padding: EdgeInsets.zero,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 16,
                  mainAxisSpacing: 32,
                  childAspectRatio: 0.58,
                ),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return _buildMinimalProductCard(context, products[index]);
                },
              );
            }
            return const SizedBox();
          },
        ),
      ],
    );
  }

  Widget _buildMinimalProductCard(BuildContext context, ProductEntity product) {
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: 'đ');
    final imageUrl = (product.imageUrl != null && product.imageUrl!.isNotEmpty)
        ? product.imageUrl!
        : 'https://images.unsplash.com/photo-1628157588553-5eeea00af15c?auto=format&fit=crop&q=80&w=300';
    
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => CustomerProductDetailPage(product: product),
          ),
        );
      },
      child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AspectRatio(
          aspectRatio: 1,
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(8),
              border: Border.all(color: Colors.transparent),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                imageUrl,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const Icon(Icons.image_not_supported, color: Colors.grey),
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          product.name,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: Colors.black87),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        const SizedBox(height: 4),
        Text(
          currencyFormat.format(product.price),
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        const Spacer(),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton(
            onPressed: () {
              context.read<CartBloc>().add(AddToCartEvent(product));
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Đã thêm ${product.name} vào giỏ hàng'), duration: const Duration(seconds: 1)),
              );
            },
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.primaryColor,
              side: const BorderSide(color: AppColors.primaryColor),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
              padding: const EdgeInsets.symmetric(vertical: 8),
            ),
            child: const Text('THÊM', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    ),
    );
  }

  Widget _buildBlogSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'KIẾN THỨC',
              style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, letterSpacing: 2, color: Colors.grey[600]),
            ),
            GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const CustomerNewsPage()),
                );
              },
              child: const Row(
                children: [
                  Text(
                    'Xem tất cả',
                    style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.primaryColor),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, size: 16, color: AppColors.primaryColor),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CustomerNewsPage()),
            );
          },
          child: _buildBlogItem(
            'Mẹo xử lý rầy nâu bằng tỏi và ớt hữu cơ',
            '3 PHÚT ĐỌC',
            'https://images.unsplash.com/photo-1444858291040-58f756a3bdd6?auto=format&fit=crop&w=200&q=80'
          ),
        ),
        const SizedBox(height: 24),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CustomerNewsPage()),
            );
          },
          child: _buildBlogItem(
            'Lịch bón phân tối ưu cho vụ Hè Thu',
            '5 PHÚT ĐỌC',
            'https://images.unsplash.com/photo-1592982537447-7440770cbfc9?auto=format&fit=crop&w=200&q=80'
          ),
        ),
      ],
    );
  }

  Widget _buildBlogItem(String title, String readTime, String imageUrl) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            imageUrl,
            width: 80,
            height: 80,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, height: 1.4),
              ),
              const SizedBox(height: 8),
              Text(
                readTime,
                style: TextStyle(fontSize: 10, fontWeight: FontWeight.bold, letterSpacing: 1.5, color: Colors.grey[500]),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildPlaceholderTab(String title) {
    return Center(
      child: Text(
        'Đang phát triển: $title',
        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
      ),
    );
  }

  Widget _buildProfileTab() {
    return SafeArea(
      child: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          const Text('Tài khoản của tôi', style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
          const SizedBox(height: 32),
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfilePage(user: widget.user)),
              );
            },
            child: Row(
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: AppColors.primaryColor.withOpacity(0.1),
                  child: Text(
                    widget.user.name?.isNotEmpty == true ? widget.user.name![0].toUpperCase() : 'C',
                    style: const TextStyle(fontSize: 24, color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.user.name ?? 'Khách hàng',
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      widget.user.email ?? '',
                      style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(height: 40),
          _buildProfileMenuItem(
            Icons.person_outline,
            'Thông tin cá nhân',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => ProfilePage(user: widget.user)),
              );
            },
          ),
          _buildProfileMenuItem(
            Icons.history,
            'Lịch sử đơn hàng',
            onTap: () {
              setState(() {
                _currentIndex = 2;
              });
            },
          ),
          _buildProfileMenuItem(
            Icons.article_outlined,
            'Tin tức & Kiến thức',
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const CustomerNewsPage()),
              );
            },
          ),
          _buildProfileMenuItem(Icons.location_on_outlined, 'Địa chỉ giao hàng'),
          _buildProfileMenuItem(Icons.payment, 'Phương thức thanh toán'),
          _buildProfileMenuItem(Icons.settings_outlined, 'Cài đặt'),
          const Divider(height: 40),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.logout, color: Colors.redAccent),
            title: const Text('Đăng xuất', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.w500)),
            onTap: () {
              context.read<AuthBloc>().add(LogoutRequested());
            },
          ),
        ],
      ),
    );
  }

  Widget _buildProfileMenuItem(IconData icon, String title, {VoidCallback? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      trailing: Icon(Icons.arrow_forward_ios, size: 14, color: Colors.grey[400]),
      onTap: onTap,
    );
  }
}
