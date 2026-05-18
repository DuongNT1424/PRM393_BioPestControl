import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/discount_repository.dart';

class DeleteDiscountUseCase implements UseCase<void, int> {
  final DiscountRepository repository;
  DeleteDiscountUseCase(this.repository);

  Future<Either<Failure, void>> call(int id) async {
    return await repository.deleteDiscount(id);
  }
}
