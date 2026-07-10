import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import '../../domain/entities/chemical_entity.dart';

class ChemicalDetailPage extends StatelessWidget {
  final ChemicalEntity chemical;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const ChemicalDetailPage({
    super.key,
    required this.chemical,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm', 'vi_VN');

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'Chi tiết hóa chất',
          style: TextStyle(
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
        actions: [
          if (onEdit != null)
            IconButton(
              icon: const Icon(Icons.edit_outlined),
              onPressed: () {
                Navigator.pop(context);
                onEdit!();
              },
              tooltip: 'Chỉnh sửa',
            ),
          if (onDelete != null)
            IconButton(
              icon: const Icon(Icons.delete_outline),
              color: Colors.red,
              onPressed: () {
                Navigator.pop(context);
                onDelete!();
              },
              tooltip: 'Xóa',
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: AppColors.primaryColor.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Icon(Icons.science_outlined,
                    color: AppColors.primaryColor, size: 36),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      chemical.commonName,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    if (chemical.casNumber != null &&
                        chemical.casNumber!.isNotEmpty)
                      Text(
                        'Mã CAS: ${chemical.casNumber}',
                        style: TextStyle(
                            fontSize: 14, color: Colors.grey[600]),
                      ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              if (chemical.signalWord != null &&
                  chemical.signalWord!.isNotEmpty) ...[
                _buildBadge(
                  chemical.signalWord!,
                  chemical.signalWord == 'Nguy hiểm'
                      ? Colors.red
                      : Colors.orange,
                ),
                const SizedBox(width: 8),
              ],
              _buildBadge(
                chemical.isBanned ? 'Bị cấm sử dụng' : 'Được phép sử dụng',
                chemical.isBanned ? Colors.red : Colors.green,
              ),
            ],
          ),
          if (chemical.hazardSymbol != null &&
              chemical.hazardSymbol!.isNotEmpty) ...[
            const SizedBox(height: 20),
            _buildInfoSection(
              icon: Icons.warning_amber_outlined,
              title: 'Biểu tượng nguy hại',
              content: chemical.hazardSymbol!,
              color: Colors.deepOrange,
            ),
          ],
          if (chemical.hazardStatement != null &&
              chemical.hazardStatement!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildInfoSection(
              icon: Icons.report_problem_outlined,
              title: 'Cảnh báo nguy cơ',
              content: chemical.hazardStatement!,
              color: Colors.red,
            ),
          ],
          if (chemical.precautionaryStatement != null &&
              chemical.precautionaryStatement!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildInfoSection(
              icon: Icons.shield_outlined,
              title: 'Biện pháp phòng ngừa',
              content: chemical.precautionaryStatement!,
              color: AppColors.primaryColor,
            ),
          ],
          if (chemical.firstAidMeasures != null &&
              chemical.firstAidMeasures!.isNotEmpty) ...[
            const SizedBox(height: 12),
            _buildInfoSection(
              icon: Icons.medical_services_outlined,
              title: 'Biện pháp sơ cứu',
              content: chemical.firstAidMeasures!,
              color: Colors.blue,
            ),
          ],
          const SizedBox(height: 24),
          if (chemical.createdByName != null)
            Text(
              'Người tạo: ${chemical.createdByName}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          if (chemical.createdAt != null)
            Text(
              'Ngày tạo: ${dateFormat.format(chemical.createdAt!)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          if (chemical.updatedAt != null)
            Text(
              'Cập nhật lần cuối: ${dateFormat.format(chemical.updatedAt!)}',
              style: const TextStyle(fontSize: 12, color: Colors.grey),
            ),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildBadge(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildInfoSection({
    required IconData icon,
    required String title,
    required String content,
    required Color color,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.06),
        borderRadius: BorderRadius.circular(12),
        border: Border(
          left: BorderSide(color: color, width: 3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 18, color: color),
              const SizedBox(width: 8),
              Text(
                title,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: color,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            content,
            style: const TextStyle(
              fontSize: 14,
              color: Colors.black87,
              height: 1.5,
            ),
          ),
        ],
      ),
    );
  }
}
