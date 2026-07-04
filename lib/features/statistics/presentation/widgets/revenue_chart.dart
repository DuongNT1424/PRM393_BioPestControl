import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class RevenueChart extends StatelessWidget {
  final double totalRevenue;
  final List<double> revenueByWeekday;
  final Color primaryColor;

  const RevenueChart({
    super.key,
    required this.totalRevenue,
    required this.revenueByWeekday,
    required this.primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    // Tìm ngày có doanh thu cao nhất để scale chiều cao trục Y
    double maxRevenue = 0;
    for (var r in revenueByWeekday) {
      if (r > maxRevenue) maxRevenue = r;
    }
    
    // Đảm bảo max y-axis tối thiểu để biểu đồ không quá nhỏ khi không có doanh thu
    final maxY = maxRevenue > 0 ? maxRevenue * 1.2 : 1000000.0;
    final double avg = maxRevenue > 0 ? (maxRevenue / 5) : 200000;

    // Tạo 7 cột dữ liệu tương ứng Thứ 2 -> Chủ Nhật
    final barGroups = List.generate(7, (index) {
      return _makeBarGroup(index, revenueByWeekday[index], maxY);
    });

    return Container(
      height: 300,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Doanh Thu Theo Ngày (Thực Tế)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tổng: ${NumberFormat.currency(locale: 'vi_VN', symbol: '₫').format(totalRevenue)}',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 24),
          Expanded(
            child: BarChart(
              BarChartData(
                maxY: maxY,
                alignment: BarChartAlignment.spaceBetween,
                borderData: FlBorderData(show: false),
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 30,
                      getTitlesWidget: (value, meta) {
                        const days = ['T2', 'T3', 'T4', 'T5', 'T6', 'T7', 'CN'];
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            days[value.toInt() % 7],
                            style: TextStyle(
                              color: Colors.grey[500],
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(showTitles: false), // Ẩn cột Y để UI gọn gàng
                  ),
                  rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                  topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                ),
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: avg > 0 ? avg : 1,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: Colors.grey[200],
                      strokeWidth: 1,
                      dashArray: [5, 5],
                    );
                  },
                ),
                barGroups: barGroups,
              ),
            ),
          ),
        ],
      ),
    );
  }

  BarChartGroupData _makeBarGroup(int x, double y, double maxY) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: y,
          color: primaryColor,
          width: 16,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(6),
            topRight: Radius.circular(6),
          ),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: maxY, // Chiều cao ảo của cột nền luôn bằng maxY
            color: primaryColor.withOpacity(0.05),
          ),
        ),
      ],
    );
  }
}
