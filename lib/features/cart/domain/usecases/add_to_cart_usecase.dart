import 'package:dartz/dartz.dart';
import 'package:prm393_biopestcontrol/core/errors/failures.dart';
import 'package:prm393_biopestcontrol/features/cart/domain/repositories/cart_repository.dart';
import 'package:prm393_biopestcontrol/features/product/domain/entities/product_entity.dart';

class AddToCartParams {
  final ProductEntity product;
  final int quantity;

  AddToCartParams({required this.product, required this.quantity});
}

/// [AddToCartUseCase] Lớp UseCase (Domain Layer) chịu trách nhiệm thực thi logic nghiệp vụ cho việc thêm sản phẩm vào giỏ.
/// - Nhận yêu cầu từ [CartBloc].
/// - Gọi đến [CartRepository] để thực hiện việc lưu trữ.
/// - Trả về kết quả dưới dạng [Either] (chứa lỗi [Failure] nếu thất bại, hoặc void nếu thành công).
class AddToCartUseCase {
  final CartRepository repository;

  AddToCartUseCase(this.repository);

  /// Phương thức `call` cho phép đối tượng được gọi như một hàm.
  /// Ví dụ ở CartBloc: `await addToCartUseCase(params)`
  Future<Either<Failure, void>> call(AddToCartParams params) {
    return repository.addToCart(params.product, params.quantity);
  }
}
