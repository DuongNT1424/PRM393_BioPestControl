import 'package:flutter/material.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/features/auth/domain/entities/auth_entity.dart';
import '../../domain/entities/chemical_entity.dart';

class ChemicalFormPage extends StatefulWidget {
  final ChemicalEntity? chemical;
  final AuthEntity user;
  final Function(ChemicalEntity) onSave;

  const ChemicalFormPage({
    super.key,
    this.chemical,
    required this.user,
    required this.onSave,
  });

  @override
  State<ChemicalFormPage> createState() => _ChemicalFormPageState();
}

class _ChemicalFormPageState extends State<ChemicalFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _commonNameController;
  late TextEditingController _casNumberController;
  late TextEditingController _hazardStatementController;
  late TextEditingController _precautionaryController;
  late TextEditingController _firstAidController;
  String? _selectedSignalWord;
  String? _selectedHazardSymbol;
  bool _isBanned = false;

  static const List<String> _signalWords = [
    'Nguy hiểm',
    'Cảnh báo',
  ];

  static const List<String> _hazardSymbols = [
    'Độc cấp tính',
    'Ăn mòn',
    'Dễ cháy',
    'Kích ứng',
    'Nguy hại sức khỏe',
    'Nguy hại môi trường',
    'Oxy hóa',
    'Chất nổ',
  ];

  @override
  void initState() {
    super.initState();
    _commonNameController =
        TextEditingController(text: widget.chemical?.commonName ?? '');
    _casNumberController =
        TextEditingController(text: widget.chemical?.casNumber ?? '');
    _hazardStatementController =
        TextEditingController(text: widget.chemical?.hazardStatement ?? '');
    _precautionaryController = TextEditingController(
        text: widget.chemical?.precautionaryStatement ?? '');
    _firstAidController =
        TextEditingController(text: widget.chemical?.firstAidMeasures ?? '');
    _selectedSignalWord = widget.chemical?.signalWord;
    _selectedHazardSymbol = widget.chemical?.hazardSymbol;
    _isBanned = widget.chemical?.isBanned ?? false;
  }

  @override
  void dispose() {
    _commonNameController.dispose();
    _casNumberController.dispose();
    _hazardStatementController.dispose();
    _precautionaryController.dispose();
    _firstAidController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.chemical != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          isEdit ? 'Chỉnh sửa hóa chất' : 'Thêm hóa chất mới',
          style: const TextStyle(
              color: AppColors.primaryColor, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primaryColor),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            _buildSectionLabel('Tên hóa chất *'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _commonNameController,
              maxLength: 200,
              decoration: _inputDecoration('Nhập tên thông dụng của hóa chất...'),
              validator: (v) => (v == null || v.trim().isEmpty)
                  ? 'Vui lòng nhập tên hóa chất'
                  : null,
            ),
            const SizedBox(height: 16),

            _buildSectionLabel('Mã số CAS'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _casNumberController,
              maxLength: 20,
              decoration: _inputDecoration('VD: 71751-41-2 (tùy chọn)'),
            ),
            const SizedBox(height: 16),

            _buildSectionLabel('Từ cảnh báo'),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              initialValue: _selectedSignalWord,
              hint: const Text('Chọn từ cảnh báo'),
              decoration: _dropdownDecoration(),
              items: [
                const DropdownMenuItem<String>(
                    value: null, child: Text('-- Không có --')),
                ..._signalWords.map(
                  (word) =>
                      DropdownMenuItem<String>(value: word, child: Text(word)),
                ),
              ],
              onChanged: (val) => setState(() => _selectedSignalWord = val),
            ),
            const SizedBox(height: 16),

            _buildSectionLabel('Biểu tượng nguy hại'),
            const SizedBox(height: 6),
            DropdownButtonFormField<String>(
              initialValue: _selectedHazardSymbol,
              hint: const Text('Chọn biểu tượng nguy hại'),
              decoration: _dropdownDecoration(),
              items: [
                const DropdownMenuItem<String>(
                    value: null, child: Text('-- Không có --')),
                ..._hazardSymbols.map(
                  (symbol) => DropdownMenuItem<String>(
                      value: symbol, child: Text(symbol)),
                ),
              ],
              onChanged: (val) =>
                  setState(() => _selectedHazardSymbol = val),
            ),
            const SizedBox(height: 16),

            _buildSectionLabel('Cảnh báo nguy cơ'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _hazardStatementController,
              maxLines: 3,
              maxLength: 1000,
              decoration: _inputDecoration(
                  'VD: Gây kích ứng da và mắt nghiêm trọng...'),
            ),
            const SizedBox(height: 16),

            _buildSectionLabel('Biện pháp phòng ngừa'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _precautionaryController,
              maxLines: 3,
              maxLength: 1000,
              decoration: _inputDecoration(
                  'VD: Đeo găng tay, kính bảo hộ khi sử dụng...'),
            ),
            const SizedBox(height: 16),

            _buildSectionLabel('Biện pháp sơ cứu'),
            const SizedBox(height: 6),
            TextFormField(
              controller: _firstAidController,
              maxLines: 3,
              maxLength: 1000,
              decoration: _inputDecoration(
                  'VD: Rửa ngay với nhiều nước sạch trong 15 phút...'),
            ),
            const SizedBox(height: 20),

            Container(
              decoration: BoxDecoration(
                border: Border.all(
                    color: AppColors.primaryColor.withValues(alpha: 0.3)),
                borderRadius: BorderRadius.circular(12),
              ),
              child: SwitchListTile(
                title: const Text(
                  'Hóa chất bị cấm',
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                subtitle: Text(
                  _isBanned
                      ? 'Hóa chất này bị cấm sử dụng'
                      : 'Hóa chất này được phép sử dụng',
                  style: TextStyle(
                    fontSize: 12,
                    color: _isBanned ? Colors.red : Colors.green,
                  ),
                ),
                value: _isBanned,
                activeThumbColor: AppColors.primaryColor,
                onChanged: (val) => setState(() => _isBanned = val),
              ),
            ),

            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primaryColor,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(vertical: 16),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14)),
              ),
              child: Text(
                isEdit ? 'CẬP NHẬT HÓA CHẤT' : 'THÊM HÓA CHẤT',
                style: const TextStyle(
                    fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        color: Colors.black87,
      ),
    );
  }

  InputDecoration _inputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor, width: 2),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.red),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  InputDecoration _dropdownDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide:
            BorderSide(color: AppColors.primaryColor.withValues(alpha: 0.3)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryColor),
      ),
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final chemical = ChemicalEntity(
        id: widget.chemical?.id,
        commonName: _commonNameController.text.trim(),
        casNumber: _casNumberController.text.trim().isEmpty
            ? null
            : _casNumberController.text.trim(),
        signalWord: _selectedSignalWord,
        hazardStatement: _hazardStatementController.text.trim().isEmpty
            ? null
            : _hazardStatementController.text.trim(),
        precautionaryStatement: _precautionaryController.text.trim().isEmpty
            ? null
            : _precautionaryController.text.trim(),
        firstAidMeasures: _firstAidController.text.trim().isEmpty
            ? null
            : _firstAidController.text.trim(),
        hazardSymbol: _selectedHazardSymbol,
        isBanned: _isBanned,
        createdById: widget.chemical?.createdById ?? widget.user.id,
        createdByName: widget.chemical?.createdByName ??
            (widget.user.name ?? widget.user.email),
        createdAt: widget.chemical?.createdAt ?? DateTime.now(),
      );
      widget.onSave(chemical);
      Navigator.pop(context);
    }
  }
}
