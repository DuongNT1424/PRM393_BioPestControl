import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_state.dart';
import '../../domain/entities/order.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import '../widgets/order_card.dart';
import 'customer_order_detail_page.dart';

class CustomerOrderListPage extends StatefulWidget {
  const CustomerOrderListPage({super.key});

  @override
  State<CustomerOrderListPage> createState() => _CustomerOrderListPageState();
}

class _CustomerOrderListPageState extends State<CustomerOrderListPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    _searchController.addListener(_onSearchTextChanged);
    
    // Tải danh sách đơn hàng ban đầu của khách hàng hiện tại
    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      final customerId = authState.user.id ?? '';
      context.read<OrderBloc>().add(LoadOrdersEvent(customerId: customerId));
    }
  }

  void _onSearchTextChanged() {
    setState(() {});
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchTextChanged);
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _triggerSearch() {
    final authState = context.read<AuthBloc>().state;
    if (authState is Authenticated) {
      final customerId = authState.user.id ?? '';
      context.read<OrderBloc>().add(LoadOrdersEvent(
            customerId: customerId,
            searchQuery: _searchController.text.trim(),
          ));
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = context.read<AuthBloc>().state;
    final customerId = authState is Authenticated ? (authState.user.id ?? '') : '';

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Đơn hàng của tôi', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false, // Vì là tab chính
      ),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          context.read<OrderBloc>().add(LoadOrdersEvent(customerId: customerId));
        },
        child: Column(
          children: [
            // Thanh tìm kiếm và bộ lọc nhanh
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Column(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: const Color(0xFFF1F5F9),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey[500], size: 20),
                        const SizedBox(width: 8),
                        Expanded(
                          child: TextField(
                            controller: _searchController,
                            decoration: InputDecoration(
                              hintText: 'Tìm theo mã đơn hoặc sản phẩm...',
                              hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
                              border: InputBorder.none,
                              isDense: true,
                              suffixIcon: _searchController.text.isNotEmpty
                                  ? IconButton(
                                      icon: Icon(Icons.clear, color: Colors.grey[500], size: 18),
                                      padding: EdgeInsets.zero,
                                      constraints: const BoxConstraints(),
                                      onPressed: () {
                                        _searchController.clear();
                                        _triggerSearch();
                                      },
                                    )
                                  : null,
                            ),
                            style: const TextStyle(fontSize: 13),
                            onChanged: (_) => _triggerSearch(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            // Thanh Tab phân loại
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.primaryColor,
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: Colors.grey[500],
                labelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(fontSize: 13, fontWeight: FontWeight.w500),
                tabs: const [
                  Tab(text: 'Tất cả'),
                  Tab(text: 'Chờ duyệt'),
                  Tab(text: 'Đang xử lý'),
                  Tab(text: 'Lịch sử'),
                ],
              ),
            ),
            // Danh sách đơn hàng theo tab
            Expanded(
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoading) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                  }

                  if (state is OrderError) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error_outline, color: Colors.redAccent[100], size: 60),
                          const SizedBox(height: 16),
                          Text('Đã xảy ra lỗi: ${state.message}', style: const TextStyle(color: Colors.grey)),
                        ],
                      ),
                    );
                  }

                  if (state is OrdersLoaded) {
                    final allOrders = state.orders;

                    // Đảm bảo đơn hàng được sắp xếp theo ngày tạo mới nhất lên trên trước khi lọc
                    final sortedOrders = List<OrderEntity>.from(allOrders)
                      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

                    return TabBarView(
                      controller: _tabController,
                      children: [
                        _buildOrderList(sortedOrders), // Tab 1: Tất cả
                        _buildOrderList(
                          sortedOrders.where((o) => o.deliveryStatus == 'Pending').toList(),
                        ), // Tab 2: Chờ duyệt
                        _buildOrderList(
                          sortedOrders.where((o) => o.deliveryStatus == 'Preparing' || o.deliveryStatus == 'Delivering').toList(),
                        ), // Tab 3: Đang xử lý
                        _buildOrderList(
                          sortedOrders.where((o) => o.deliveryStatus == 'Delivered' || o.deliveryStatus == 'Cancelled' || o.deliveryStatus == 'Returned').toList(),
                        ), // Tab 4: Lịch sử (Đã hoàn thành / Đã hủy / Đã trả hàng)
                      ],
                    );
                  }

                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderList(List<OrderEntity> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.shopping_bag_outlined, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text('Bạn chưa có đơn hàng nào', style: TextStyle(color: Colors.grey[500], fontSize: 14)),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: orders.length,
      separatorBuilder: (context, index) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final order = orders[index];
        final orderBloc = context.read<OrderBloc>();
        final authBloc = context.read<AuthBloc>();

        return CustomerOrderCard(
          order: order,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => CustomerOrderDetailPage(orderId: order.id),
              ),
            ).then((_) {
              // Làm mới danh sách đơn hàng khi quay lại
              final authState = authBloc.state;
              if (authState is Authenticated) {
                orderBloc.add(LoadOrdersEvent(customerId: authState.user.id ?? ''));
              }
            });
          },
        );
      },
    );
  }
}
