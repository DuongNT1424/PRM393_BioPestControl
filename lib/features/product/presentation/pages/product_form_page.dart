import 'package:flutter/material.dart';
import '../../domain/entities/product_entity.dart';
import '../../../../shared/theme/app_colors.dart';
import '../widgets/product_text_field.dart';

/// [ProductFormPage] là trang dùng để thêm mới hoặc chỉnh sửa sản phẩm.
class ProductFormPage extends StatefulWidget {
  final ProductEntity? product;
  final Function(ProductEntity) onSave;

  const ProductFormPage({super.key, this.product, required this.onSave});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _skuController;
  late TextEditingController _nameController;
  late TextEditingController _descriptionController;
  late TextEditingController _priceController;
  late TextEditingController _stockController;
  late TextEditingController _categoryIdController;
  late TextEditingController _imageUrlController;
  bool _isActive = true;

  @override
  void initState() {
    super.initState();
    _skuController = TextEditingController(text: widget.product?.sku ?? '');
    _nameController = TextEditingController(text: widget.product?.name ?? '');
    _descriptionController = TextEditingController(text: widget.product?.description ?? '');
    _priceController = TextEditingController(text: widget.product?.price.toString() ?? '');
    _stockController = TextEditingController(text: widget.product?.stock.toString() ?? '');
    _categoryIdController = TextEditingController(text: widget.product?.categoryId.toString() ?? '1');
    _imageUrlController = TextEditingController(text: widget.product?.imageUrl ?? '');
    _isActive = widget.product?.isActive ?? true;
  }

  @override
  void dispose() {
    _skuController.dispose();
    _nameController.dispose();
    _descriptionController.dispose();
    _priceController.dispose();
    _stockController.dispose();
    _categoryIdController.dispose();
    _imageUrlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = widget.product != null;

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(isEdit ? 'Sửa sản phẩm' : 'Thêm sản phẩm mới'),
        backgroundColor: Colors.white,
        foregroundColor: AppColors.primaryColor,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ProductTextField(
                controller: _skuController,
                label: 'Mã SKU',
                hint: 'VD: BIO-001',
                validator: (v) => v!.isEmpty ? 'Vui lòng nhập SKU' : null,
              ),
              const SizedBox(height: 16),
              ProductTextField(
                controller: _nameController,
                label: 'Tên sản phẩm',
                hint: 'Nhập tên sản phẩm...',
                validator: (v) => v!.isEmpty ? 'Vui lòng nhập tên' : null,
              ),
              const SizedBox(height: 16),
              ProductTextField(
                controller: _descriptionController,
                label: 'Mô tả',
                hint: 'Nhập mô tả sản phẩm...',
                maxLines: 3,
              ),
              const SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ProductTextField(
                      controller: _priceController,
                      label: 'Giá (₫)',
                      hint: '0',
                      keyboardType: TextInputType.number,
                      validator: (v) => v!.isEmpty ? 'Nhập giá' : null,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: ProductTextField(
                      controller: _stockController,
                      label: 'Số lượng kho',
                      hint: '0',
                      keyboardType: TextInputType.number,
                      validator: (v) => v!.isEmpty ? 'Nhập số lượng' : null,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              ProductTextField(
                controller: _categoryIdController,
                label: 'ID Danh mục',
                hint: '1',
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 16),
              ProductTextField(
                controller: _imageUrlController,
                label: 'URL Hình ảnh',
                hint: 'https://...',
              ),
              const SizedBox(height: 16),
              SwitchListTile(
                title: const Text('Đang kinh doanh', style: TextStyle(fontWeight: FontWeight.bold)),
                value: _isActive,
                activeColor: AppColors.primaryColor,
                onChanged: (val) => setState(() => _isActive = val),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submit,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primaryColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: Text(
                  isEdit ? 'CẬP NHẬT' : 'THÊM SẢN PHẨM',
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Xử lý lưu thông tin sản phẩm.
  void _submit() {
    if (_formKey.currentState!.validate()) {
      final product = ProductEntity(
        id: widget.product?.id,
        sku: _skuController.text,
        name: _nameController.text,
        description: _descriptionController.text,
        price: double.tryParse(_priceController.text) ?? 0,
        stock: int.tryParse(_stockController.text) ?? 0,
        categoryId: int.tryParse(_categoryIdController.text) ?? 1,
        imageUrl: _imageUrlController.text,
        isActive: _isActive,
      );
      widget.onSave(product);
      Navigator.pop(context);
    }
  }
}
