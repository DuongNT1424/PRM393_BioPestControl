import 'package:flutter/material.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';

class ChemicalFilterDialog extends StatefulWidget {
  final String? initialSignalWord;
  final bool? initialIsBanned;

  const ChemicalFilterDialog({
    super.key,
    this.initialSignalWord,
    this.initialIsBanned,
  });

  @override
  State<ChemicalFilterDialog> createState() => _ChemicalFilterDialogState();
}

class _ChemicalFilterDialogState extends State<ChemicalFilterDialog> {
  String? _selectedSignalWord;
  bool? _selectedIsBanned;

  static const List<String> _signalWords = [
    'Nguy hiểm',
    'Cảnh báo',
  ];

  @override
  void initState() {
    super.initState();
    _selectedSignalWord = widget.initialSignalWord;
    _selectedIsBanned = widget.initialIsBanned;
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text(
        'Bộ lọc hóa chất',
        style: TextStyle(
          color: AppColors.primaryColor,
          fontWeight: FontWeight.bold,
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Từ cảnh báo',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<String>(
            initialValue: _selectedSignalWord,
            hint: const Text('Tất cả'),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            items: [
              const DropdownMenuItem<String>(
                  value: null, child: Text('Tất cả')),
              ..._signalWords.map((word) =>
                  DropdownMenuItem(value: word, child: Text(word))),
            ],
            onChanged: (value) =>
                setState(() => _selectedSignalWord = value),
          ),
          const SizedBox(height: 16),
          const Text(
            'Trạng thái',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
          ),
          const SizedBox(height: 8),
          DropdownButtonFormField<bool?>(
            initialValue: _selectedIsBanned,
            hint: const Text('Tất cả'),
            decoration: InputDecoration(
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10)),
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            ),
            items: const [
              DropdownMenuItem<bool?>(value: null, child: Text('Tất cả')),
              DropdownMenuItem<bool?>(value: true, child: Text('Bị cấm')),
              DropdownMenuItem<bool?>(
                  value: false, child: Text('Được phép')),
            ],
            onChanged: (value) => setState(() => _selectedIsBanned = value),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy', style: TextStyle(color: Colors.grey)),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, <String, dynamic>{
            'signalWord': null,
            'isBanned': null,
          }),
          child:
              const Text('Đặt lại', style: TextStyle(color: Colors.orange)),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, <String, dynamic>{
            'signalWord': _selectedSignalWord,
            'isBanned': _selectedIsBanned,
          }),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8)),
          ),
          child:
              const Text('Áp dụng', style: TextStyle(color: Colors.white)),
        ),
      ],
    );
  }
}
