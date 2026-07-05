import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/discount_entity.dart';
import '../bloc/discount_bloc.dart';
import '../bloc/discount_event.dart';
import 'package:prm393_biopestcontrol/features/product/domain/usecases/get_products_usecase.dart';
import 'package:prm393_biopestcontrol/features/product/domain/entities/product_entity.dart';
import 'package:prm393_biopestcontrol/core/di/injection_container.dart' as di;
import 'package:prm393_biopestcontrol/app/theme/app_colors.dart';
import 'package:intl/intl.dart';

class DiscountFormPage extends StatefulWidget {
  final DiscountEntity? discount;
  const DiscountFormPage({super.key, this.discount});

  @override
  State<DiscountFormPage> createState() => _DiscountFormPageState();
}

class _DiscountFormPageState extends State<DiscountFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _descController;
  late TextEditingController _percentController;
  
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 7));
  List<int> _selectedProductIds = [];
  bool _isAllProducts = false;
  bool _isActive = true;

  List<ProductEntity> _products = [];
  bool _isLoadingProducts = true;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.discount?.name ?? '');
    _descController = TextEditingController(text: widget.discount?.description ?? '');
    _percentController = TextEditingController(text: widget.discount?.discountPercent.toString() ?? '');
    
    if (widget.discount != null) {
      _startDate = widget.discount!.startDate;
      _endDate = widget.discount!.endDate;
      _selectedProductIds = List.from(widget.discount!.productIds);
      _isAllProducts = widget.discount!.isAllProducts;
      _isActive = widget.discount!.isActive;
    }

    _loadProducts();
  }

  Future<void> _loadProducts() async {
    try {
      final result = await di.sl<GetProductsUseCase>().call();
      result.fold(
        (failure) {
          setState(() => _isLoadingProducts = false);
        },
        (products) {
          setState(() {
            _products = products;
            _isLoadingProducts = false;
          });
        },
      );
    } catch (e) {
      setState(() => _isLoadingProducts = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.discount == null ? 'Create Discount' : 'Edit Discount'),
      ),
        body: _isLoadingProducts 
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Name
                    TextFormField(
                      controller: _nameController,
                      decoration: const InputDecoration(
                        labelText: 'Discount Name (e.g. Summer Sale)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.label_outlined),
                      ),
                      validator: (v) => v == null || v.isEmpty ? 'Required' : null,
                    ),
                    const SizedBox(height: 16),
                    
                    // All Products Toggle
                    SwitchListTile(
                      title: const Text('Apply to ALL products'),
                      subtitle: const Text('This will override specific selections'),
                      value: _isAllProducts,
                      onChanged: (v) => setState(() => _isAllProducts = v),
                      activeThumbColor: AppColors.primaryColor,
                    ),
                    const SizedBox(height: 8),

                    // Multi-Product Selection (Only if not all products)
                    if (!_isAllProducts) ...[
                      const Text('Select Products:', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      InkWell(
                        onTap: _showProductSelectionDialog,
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey.shade400),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            _selectedProductIds.isEmpty 
                              ? 'Click to select products...' 
                              : '${_selectedProductIds.length} products selected',
                            style: TextStyle(color: _selectedProductIds.isEmpty ? Colors.grey : Colors.black),
                          ),
                        ),
                      ),
                    ],
                    const SizedBox(height: 16),

                    // Discount Percent
                    TextFormField(
                      controller: _percentController,
                      decoration: const InputDecoration(
                        labelText: 'Discount Percent (%)',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.percent),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(decimal: true),
                      validator: (v) {
                        if (v == null || v.isEmpty) return 'Required';
                        final n = double.tryParse(v);
                        if (n == null) return 'Invalid number';
                        if (n < 0 || n > 100) return '0-100 only';
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),

                    // Date Pickers
                    Row(
                      children: [
                        Expanded(
                          child: _buildDatePicker(
                            'Start Date', 
                            _startDate, 
                            (date) => setState(() => _startDate = date)
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: _buildDatePicker(
                            'End Date', 
                            _endDate, 
                            (date) => setState(() => _endDate = date)
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),

                    // Description
                    TextFormField(
                      controller: _descController,
                      decoration: const InputDecoration(
                        labelText: 'Description (Optional)',
                        border: OutlineInputBorder(),
                      ),
                      maxLines: 3,
                    ),
                    const SizedBox(height: 16),

                    // Active Switch
                    SwitchListTile(
                      title: const Text('Active Status'),
                      value: _isActive,
                      onChanged: (v) => setState(() => _isActive = v),
                      activeThumbColor: AppColors.primaryColor,
                    ),
                    
                    const SizedBox(height: 32),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: () => _submit(context),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryColor,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        ),
                        child: const Text('Save Discount', style: TextStyle(color: Colors.white, fontSize: 16)),
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }

  void _showProductSelectionDialog() {
    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setDialogState) {
            return AlertDialog(
              title: const Text('Select Products'),
              content: SizedBox(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: _products.length,
                  itemBuilder: (context, index) {
                    final p = _products[index];
                    final isSelected = _selectedProductIds.contains(p.id);
                    return CheckboxListTile(
                      title: Text(p.name),
                      subtitle: Text('SKU: ${p.sku}'),
                      value: isSelected,
                      onChanged: (val) {
                        setDialogState(() {
                          if (val == true) {
                            if (p.id != null) _selectedProductIds.add(p.id!);
                          } else {
                            _selectedProductIds.remove(p.id);
                          }
                        });
                        // Sync with main state
                        setState(() {});
                      },
                      activeColor: AppColors.primaryColor,
                    );
                  },
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Done'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildDatePicker(String label, DateTime date, Function(DateTime) onSelected) {
    return InkWell(
      onTap: () async {
        final picked = await showDatePicker(
          context: context,
          initialDate: date,
          firstDate: DateTime(2020),
          lastDate: DateTime(2100),
        );
        if (picked != null) onSelected(picked);
      },
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade400),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label, style: TextStyle(fontSize: 12, color: Colors.grey.shade600)),
            const SizedBox(height: 4),
            Text(DateFormat('dd/MM/yyyy').format(date)),
          ],
        ),
      ),
    );
  }

  void _submit(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      // Validate product selection if not all products
      if (!_isAllProducts && _selectedProductIds.isEmpty) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select at least one product')),
        );
        return;
      }

      final discount = DiscountEntity(
        id: widget.discount?.id,
        name: _nameController.text.trim(),
        description: _descController.text.trim(),
        discountPercent: double.parse(_percentController.text),
        startDate: _startDate,
        endDate: _endDate,
        productIds: _isAllProducts ? [] : _selectedProductIds,
        isAllProducts: _isAllProducts,
        isActive: _isActive,
      );

      if (widget.discount == null) {
        context.read<DiscountBloc>().add(AddDiscount(discount));
      } else {
        context.read<DiscountBloc>().add(UpdateDiscount(discount));
      }
      
      Navigator.pop(context, true);
    }
  }
}
