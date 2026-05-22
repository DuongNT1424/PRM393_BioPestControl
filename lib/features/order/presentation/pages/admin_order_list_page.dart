import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import '../../domain/entities/order.dart';
import '../bloc/order_bloc.dart';
import '../bloc/order_event.dart';
import '../bloc/order_state.dart';
import '../widgets/order_card.dart';
import 'admin_order_detail_page.dart';

class AdminOrderListPage extends StatefulWidget {
  const AdminOrderListPage({super.key});

  @override
  State<AdminOrderListPage> createState() => _AdminOrderListPageState();
}

class _AdminOrderListPageState extends State<AdminOrderListPage> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);
    
    // Tải toàn bộ đơn hàng của hệ thống (Staff/Admin không truyền customerId)
    context.read<OrderBloc>().add(const LoadOrdersEvent());
  }

  @override
  void dispose() {
    _tabController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _triggerSearch() {
    context.read<OrderBloc>().add(LoadOrdersEvent(
          searchQuery: _searchController.text.trim(),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text('Quản lý đơn hàng', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black87,
        elevation: 0,
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: AppColors.primaryColor,
        onRefresh: () async {
          context.read<OrderBloc>().add(const LoadOrdersEvent());
        },
        child: Column(
          children: [
            // Ô tìm kiếm khách hàng hoặc mã đơn hàng
            Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              child: Container(
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
                          hintText: 'Tìm kiếm theo tên khách, mã đơn...',
                          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 13),
                          border: InputBorder.none,
                          isDense: true,
                        ),
                        style: const TextStyle(fontSize: 13),
                        onChanged: (_) => _triggerSearch(),
                      ),
                    ),
                    if (_searchController.text.isNotEmpty)
                      GestureDetector(
                        onTap: () {
                          _searchController.clear();
                          _triggerSearch();
                        },
                        child: Icon(Icons.clear, color: Colors.grey[500], size: 18),
                      ),
                  ],
                ),
              ),
            ),
            // Các Tab lọc đơn hàng cho Admin/Staff
            Container(
              color: Colors.white,
              child: TabBar(
                controller: _tabController,
                indicatorColor: AppColors.primaryColor,
                labelColor: AppColors.primaryColor,
                unselectedLabelColor: Colors.grey[500],
                labelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                unselectedLabelStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500),
                tabs: const [
                  Tab(text: 'Tất cả'),
                  Tab(text: 'Chờ duyệt'),
                  Tab(text: 'Đang xử lý'),
                  Tab(text: 'Lịch sử'),
                ],
              ),
            ),
            // Hiển thị danh sách đơn hàng
            Expanded(
              child: BlocBuilder<OrderBloc, OrderState>(
                builder: (context, state) {
                  if (state is OrderLoading) {
                    return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
                  }

                  if (state is OrderError) {
                    return Center(
                      child: Text('Lỗi tải dữ liệu: ${state.message}', style: const TextStyle(color: Colors.redAccent)),
                    );
                  }

                  if (state is OrdersLoaded) {
                    final allOrders = state.orders;

                    return TabBarView(
                      controller: _tabController,
                      children: [
                        _buildAdminOrderList(allOrders), // Tất cả
                        _buildAdminOrderList(
                          allOrders.where((o) => o.deliveryStatus == 'Pending').toList(),
                        ), // Chờ duyệt
                        _buildAdminOrderList(
                          allOrders.where((o) => o.deliveryStatus == 'Preparing' || o.deliveryStatus == 'Delivering').toList(),
                        ), // Đang xử lý
                        _buildAdminOrderList(
                          allOrders.where((o) => o.deliveryStatus == 'Delivered' || o.deliveryStatus == 'Cancelled' || o.deliveryStatus == 'Returned').toList(),
                        ), // Lịch sử
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

  Widget _buildAdminOrderList(List<OrderEntity> orders) {
    if (orders.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.receipt_long, size: 64, color: Colors.grey[300]),
            const SizedBox(height: 16),
            Text('Không tìm thấy đơn hàng nào', style: TextStyle(color: Colors.grey[500], fontSize: 13)),
          ],
        ),
      );
    }

    return ListView.separated(
      padding: const EdgeInsets.all(24),
      itemCount: orders.length,
      separatorBuilder: (_, __) => const SizedBox(height: 16),
      itemBuilder: (context, index) {
        final order = orders[index];

        return AdminOrderCard(
          order: order,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => AdminOrderDetailPage(orderId: order.id),
              ),
            ).then((_) {
              // Làm mới danh sách đơn hàng sau khi Admin thao tác xong quay lại
              context.read<OrderBloc>().add(const LoadOrdersEvent());
            });
          },
        );
      },
    );
  }
}
