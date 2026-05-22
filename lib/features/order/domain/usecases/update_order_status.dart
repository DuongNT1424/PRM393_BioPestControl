import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/order_repository.dart';

class UpdateOrderStatusParams {
  final String orderId;
  final String deliveryStatus;
  final String? paymentStatus;

  const UpdateOrderStatusParams({
    required this.orderId,
    required this.deliveryStatus,
    this.paymentStatus,
  });
}

class UpdateOrderStatusUseCase implements UseCase<void, UpdateOrderStatusParams> {
  final OrderRepository repository;

  UpdateOrderStatusUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(UpdateOrderStatusParams params) async {
    return await repository.updateOrderStatus(
      params.orderId,
      params.deliveryStatus,
      paymentStatus: params.paymentStatus,
    );
  }
}
