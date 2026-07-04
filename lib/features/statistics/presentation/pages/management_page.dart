import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:prm393_biopestcontrol/features/auth/presentation/bloc/auth_event.dart';
import 'package:prm393_biopestcontrol/features/statistics/presentation/bloc/statistics_bloc.dart';
import 'package:prm393_biopestcontrol/features/statistics/presentation/bloc/statistics_event.dart';
import 'package:prm393_biopestcontrol/features/statistics/presentation/bloc/statistics_state.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/shared/widgets/management_drawer.dart';
import '../widgets/management_stat_card.dart';
import '../widgets/revenue_chart.dart'; // [NEW] Import Revenue Chart

/// [ManagementPage] là trang Dashboard chính dành cho Admin và Staff.
/// Cập nhật UI hiện đại với Gradient, Glassmorphism và Biểu đồ.
class ManagementPage extends StatelessWidget {
  final AuthEntity user;

  const ManagementPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = user.role?.toLowerCase() == 'admin';
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    return Scaffold(
      backgroundColor: Colors.grey[50], // Nền sáng nhẹ giúp nổi bật các Card
      appBar: AppBar(
        title: Text(
          isAdmin ? 'Admin Dashboard' : 'Staff Dashboard',
          style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
              Navigator.of(context).popUntil((route) => route.isFirst);
            },
            icon: const Icon(Icons.logout, color: Colors.redAccent),
          ),
        ],
      ),
      drawer: ManagementDrawer(
        user: user,
        isAdmin: isAdmin,
        onLogout: () {
          context.read<AuthBloc>().add(LogoutRequested());
          Navigator.of(context).popUntil((route) => route.isFirst);
        },
      ),
      body: BlocBuilder<StatisticsBloc, StatisticsState>(
        builder: (context, state) {
          if (state is StatisticsLoading) {
            return const Center(child: CircularProgressIndicator(color: AppColors.primaryColor));
          }
          
          if (state is StatisticsError) {
            return Center(child: Text(state.message, style: const TextStyle(color: AppColors.primaryColor)));
          }

          if (state is StatisticsLoaded) {
            final stats = state.statistics;
            
            return RefreshIndicator(
              color: AppColors.primaryColor,
              onRefresh: () async {
                context.read<StatisticsBloc>().add(LoadStatisticsEvent(filterType: state.currentFilter));
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header Section
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Xin chào, ${user.name} 👋',
                                style: const TextStyle(fontSize: 26, fontWeight: FontWeight.w900, color: Colors.black87),
                              ),
                              const SizedBox(height: 6),
                              Container(
                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                decoration: BoxDecoration(
                                  color: AppColors.primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Text(
                                  'Vai trò: ${user.role?.toUpperCase()}',
                                  style: const TextStyle(
                                    color: AppColors.primaryColor,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (isAdmin) _buildFilterDropdown(context, state.currentFilter),
                      ],
                    ),
                    const SizedBox(height: 30),

                    // Thống kê tổng quan (Stat Cards)
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      childAspectRatio: 1.1,
                      children: [
                        ManagementStatCard(
                          title: 'Đơn hàng mới',
                          value: stats.newOrders.toString(),
                          icon: Icons.shopping_cart_outlined,
                          color: const Color(0xFF4CAF50), // Xanh lá
                        ),
                        if (isAdmin)
                          ManagementStatCard(
                            title: 'Tổng sản phẩm',
                            value: stats.totalLinkedProducts.toString(),
                            icon: Icons.eco_outlined,
                            color: const Color(0xFF2196F3), // Xanh dương
                          ),
                        if (isAdmin)
                          ManagementStatCard(
                            title: 'Doanh thu',
                            value: currencyFormat.format(stats.totalRevenue),
                            icon: Icons.attach_money_rounded,
                            color: const Color(0xFFFF9800), // Cam
                          ),
                        if (isAdmin)
                          ManagementStatCard(
                            title: 'Đã bán',
                            value: stats.totalSold.toString(),
                            icon: Icons.trending_up_rounded,
                            color: const Color(0xFF9C27B0), // Tím
                          ),
                        if (!isAdmin)
                          const ManagementStatCard(
                            title: 'Sản phẩm',
                            value: '145',
                            icon: Icons.eco_outlined,
                            color: Color(0xFF2196F3),
                          ),
                      ],
                    ),
                    const SizedBox(height: 32),

                    // Biểu đồ Doanh Thu
                    if (isAdmin) ...[
                      RevenueChart(
                        totalRevenue: stats.totalRevenue,
                        revenueByWeekday: stats.revenueByWeekday,
                        primaryColor: AppColors.primaryColor,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ],
                ),
              ),
            );
          }

          return const SizedBox.shrink();
        },
      ),
    );
  }

  Widget _buildFilterDropdown(BuildContext context, String currentFilter) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 2),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: AppColors.primaryColor.withOpacity(0.5), width: 1.5),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryColor.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentFilter,
          dropdownColor: Colors.white,
          icon: const Icon(Icons.keyboard_arrow_down_rounded, size: 22, color: AppColors.primaryColor),
          style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.w700, fontSize: 13),
          onChanged: (String? newValue) {
            if (newValue != null) {
              context.read<StatisticsBloc>().add(LoadStatisticsEvent(filterType: newValue));
            }
          },
          items: const [
            DropdownMenuItem(value: 'today', child: Text('Hôm nay')),
            DropdownMenuItem(value: 'week', child: Text('Tuần này')),
            DropdownMenuItem(value: 'month', child: Text('Tháng này')),
          ],
        ),
      ),
    );
  }
}
