import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/entities/warehouse_entity.dart';
import 'package:prm393_biopestcontrol/features/warehouse/presentation/bloc/warehouse_bloc.dart';
import 'package:prm393_biopestcontrol/features/warehouse/domain/usecases/import_product_usecase.dart';
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:prm393_biopestcontrol/features/product/domain/entities/product_entity.dart';
import 'package:prm393_biopestcontrol/features/product/presentation/bloc/product_bloc.dart';
import 'package:prm393_biopestcontrol/features/product/presentation/bloc/product_state.dart';

/// [ImportProductDialog] cho phép Admin nhập nhiều sản phẩm vào kho cùng lúc.
class ImportProductDialog extends StatefulWidget {
  final List<WarehouseEntity> warehouses;

  const ImportProductDialog({super.key, required this.warehouses});

  @override
  State<ImportProductDialog> createState() => _ImportProductDialogState();
}

class _ImportProductDialogState extends State<ImportProductDialog> {
  int? _selectedWarehouseId;
  /// Danh sách các dòng nhập hàng hiện tại
  final List<Map<String, dynamic>> _importLines = [
    {'productId': null, 'quantity': TextEditingController()}
  ];

  @override
  void initState() {
    super.initState();
    if (widget.warehouses.isNotEmpty) {
      _selectedWarehouseId = widget.warehouses.first.id;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      surfaceTintColor: Colors.white, // Chống ám màu tím/xanh của Material 3
      title: const Text('Nhập kho hàng loạt', style: TextStyle(color: AppColors.primaryColor, fontWeight: FontWeight.bold)),
      content: SizedBox(
        width: double.maxFinite,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Hiển thị danh sách các dòng sản phẩm cần nhập
              ..._importLines.asMap().entries.map((entry) {
                int index = entry.key;
                Map<String, dynamic> line = entry.value;
                return _buildImportLine(index, line);
              }),
              
              const SizedBox(height: 16),
              // Nút thêm dòng sản phẩm mới
              OutlinedButton.icon(
                onPressed: _addNewLine,
                icon: const Icon(Icons.add),
                label: const Text('Thêm sản phẩm'),
                style: OutlinedButton.styleFrom(foregroundColor: AppColors.primaryColor),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Hủy'),
        ),
        ElevatedButton(
          onPressed: _onImport,
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primaryColor,
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          ),
          child: const Text('Xác nhận nhập kho', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
        ),
      ],
    );
  }

  /// Xây dựng một dòng nhập hàng (Chọn sản phẩm + Số lượng)
  Widget _buildImportLine(int index, Map<String, dynamic> line) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 3,
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ProductLoaded) {
                  return LayoutBuilder(
                    builder: (context, constraints) {
                      return DropdownMenu<int?>(
                        width: constraints.maxWidth,
                        menuHeight: 300, // Chiều cao menu cố định, có scrollbar
                        label: const Text('Sản phẩm'),
                        initialSelection: line['productId'],
                        inputDecorationTheme: const InputDecorationTheme(
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                        ),
                        dropdownMenuEntries: state.products.map((p) {
                          return DropdownMenuEntry<int?>(
                            value: p.id,
                            label: p.name,
                            style: MenuItemButton.styleFrom(
                              visualDensity: VisualDensity.compact,
                            ),
                          );
                        }).toList(),
                        onSelected: (val) => setState(() => line['productId'] = val),
                      );
                    },
                  );
                }
                return const LinearProgressIndicator();
              },
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: TextField(
              controller: line['quantity'],
              keyboardType: TextInputType.number,
              style: const TextStyle(fontSize: 14),
              decoration: const InputDecoration(
                labelText: 'Số lượng',
                border: OutlineInputBorder(),
                // Tăng padding để đạt chiều cao 56-60dp tương đương DropdownMenu
                contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 16),
              ),
            ),
          ),
          if (_importLines.length > 1)
            IconButton(
              icon: const Icon(Icons.remove_circle_outline, color: Colors.red),
              onPressed: () => _removeLine(index),
            ),
        ],
      ),
    );
  }

  void _addNewLine() {
    setState(() {
      _importLines.add({'productId': null, 'quantity': TextEditingController()});
    });
  }

  void _removeLine(int index) {
    setState(() {
      _importLines.removeAt(index);
    });
  }

  /// Xử lý gửi dữ liệu nhập kho hàng loạt
  void _onImport() {
    if (_selectedWarehouseId == null) return;

    final List<ImportItem> items = [];
    for (var line in _importLines) {
      final int? productId = line['productId'];
      final int qty = int.tryParse(line['quantity'].text) ?? 0;
      
      if (productId != null && qty > 0) {
        items.add(ImportItem(productId: productId, quantity: qty));
      }
    }

    if (items.isNotEmpty) {
      context.read<WarehouseBloc>().add(ImportProductEvent(
        warehouseId: _selectedWarehouseId!,
        items: items,
      ));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Vui lòng chọn ít nhất một sản phẩm hợp lệ'), backgroundColor: Colors.orange),
      );
    }
  }
}
