import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrderDetailUseCase implements UseCase<OrderEntity, String> {
  final OrderRepository repository;

  GetOrderDetailUseCase(this.repository);

  @override
  Future<Either<Failure, OrderEntity>> call(String orderId) async {
    return await repository.getOrderDetail(orderId);
  }
}
