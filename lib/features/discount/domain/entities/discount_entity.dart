import 'package:equatable/equatable.dart';

/// [DiscountEntity] đại diện cho một chương trình giảm giá trong hệ thống.
/// Đây là lớp thuộc tầng Domain, chứa logic nghiệp vụ thuần túy.
class DiscountEntity extends Equatable {
  final int? id; // ID tự tăng của giảm giá
  final String name; // Tên chương trình (ví dụ: "Giảm giá mùa hè")
  final String? description; // Mô tả chi tiết
  final double discountPercent; // Phần trăm giảm giá (0-100)
  final DateTime startDate; // Ngày bắt đầu áp dụng
  final DateTime endDate; // Ngày kết thúc
  final List<int> productIds; // Danh sách ID các sản phẩm được áp dụng
  final bool isAllProducts; // Đánh dấu nếu áp dụng cho toàn bộ sản phẩm
  final bool isActive; // Trạng thái kích hoạt (true/false)
  final String? productNames; // Tên các sản phẩm (dùng để hiển thị nhanh trên UI)

  const DiscountEntity({
    this.id,
    required this.name,
    this.description,
    required this.discountPercent,
    required this.startDate,
    required this.endDate,
    this.productIds = const [],
    this.isAllProducts = false,
    this.isActive = true,
    this.productNames,
  });

  @override
  List<Object?> get props => [id, name, description, discountPercent, startDate, endDate, productIds, isAllProducts, isActive, productNames];

  DiscountEntity copyWith({
    int? id,
    String? name,
    String? description,
    double? discountPercent,
    DateTime? startDate,
    DateTime? endDate,
    List<int>? productIds,
    bool? isAllProducts,
    bool? isActive,
    String? productNames,
  }) {
    return DiscountEntity(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      discountPercent: discountPercent ?? this.discountPercent,
      startDate: startDate ?? this.startDate,
      endDate: endDate ?? this.endDate,
      productIds: productIds ?? this.productIds,
      isAllProducts: isAllProducts ?? this.isAllProducts,
      isActive: isActive ?? this.isActive,
      productNames: productNames ?? this.productNames,
    );
  }
}
