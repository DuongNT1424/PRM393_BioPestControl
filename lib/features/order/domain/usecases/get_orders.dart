import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrdersParams {
  final String? customerId;
  final String? deliveryStatus;
  final String? searchQuery;

  const GetOrdersParams({
    this.customerId,
    this.deliveryStatus,
    this.searchQuery,
  });
}

class GetOrdersUseCase implements UseCase<List<OrderEntity>, GetOrdersParams> {
  final OrderRepository repository;

  GetOrdersUseCase(this.repository);

  @override
  Future<Either<Failure, List<OrderEntity>>> call(GetOrdersParams params) async {
    return await repository.getOrders(
      customerId: params.customerId,
      deliveryStatus: params.deliveryStatus,
      searchQuery: params.searchQuery,
    );
  }
}
