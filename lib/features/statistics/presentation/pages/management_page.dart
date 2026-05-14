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
import 'package:prm393_biopestcontrol/features/auth/presentation/pages/login_page.dart';
import 'package:prm393_biopestcontrol/app/app.dart';
import '../widgets/management_stat_card.dart';

/// [ManagementPage] là trang Dashboard chính dành cho Admin và Staff.
/// Sử dụng tông màu TRẮNG và XANH chủ đạo.
class ManagementPage extends StatelessWidget {
  final AuthEntity user;

  const ManagementPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    final bool isAdmin = user.role?.toLowerCase() == 'admin';
    final currencyFormat = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          isAdmin ? 'Admin Dashboard' : 'Staff Dashboard',
          style: const TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        actions: [
          IconButton(
            onPressed: () {
              context.read<AuthBloc>().add(LogoutRequested());
              Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(builder: (_) => const AuthWrapper()),
                (route) => false,
              );
            },
            icon: const Icon(Icons.logout, color: Colors.redAccent),
          ),
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1.0),
          child: Divider(height: 1, color: AppColors.primaryColor),
        ),
      ),
      drawer: ManagementDrawer(
        user: user,
        isAdmin: isAdmin,
        onLogout: () {
          context.read<AuthBloc>().add(LogoutRequested());
          Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (_) => const AuthWrapper()),
            (route) => false,
          );
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
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Xin chào, ${user.name}!',
                              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.black),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Quyền hạn: ${user.role?.toUpperCase()}',
                              style: const TextStyle(
                                color: Colors.black87,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        if (isAdmin) _buildFilterDropdown(context, state.currentFilter),
                      ],
                    ),
                    const SizedBox(height: 24),
                    GridView.count(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      crossAxisCount: 2,
                      mainAxisSpacing: 16,
                      crossAxisSpacing: 16,
                      children: [
                        ManagementStatCard(
                          title: 'Đơn hàng mới',
                          value: stats.newOrders.toString(),
                          icon: Icons.shopping_cart,
                          color: AppColors.primaryColor,
                        ),
                        if (isAdmin)
                          ManagementStatCard(
                            title: 'Tổng sản phẩm',
                            value: stats.totalLinkedProducts.toString(),
                            icon: Icons.eco,
                            color: AppColors.primaryColor,
                          ),
                        if (isAdmin)
                          ManagementStatCard(
                            title: 'Doanh thu',
                            value: currencyFormat.format(stats.totalRevenue),
                            icon: Icons.attach_money,
                            color: AppColors.primaryColor,
                          ),
                        if (isAdmin)
                          ManagementStatCard(
                            title: 'Sản phẩm đã bán',
                            value: stats.totalSold.toString(),
                            icon: Icons.trending_up,
                            color: AppColors.primaryColor,
                          ),
                        if (!isAdmin)
                          const ManagementStatCard(
                            title: 'Sản phẩm',
                            value: '145',
                            icon: Icons.eco,
                            color: AppColors.primaryColor,
                          ),
                      ],
                    ),
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
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        color: Colors.white, // Đảm bảo nền màu TRẮNG
        border: Border.all(color: AppColors.primaryColor, width: 1.5), // Viền màu XANH
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentFilter,
          dropdownColor: Colors.white, // Menu xổ xuống màu trắng
          icon: const Icon(Icons.filter_list, size: 18, color: AppColors.primaryColor),
          style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w600),
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
