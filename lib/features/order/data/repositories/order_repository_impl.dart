import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../datasources/order_remote_data_source.dart';
import '../models/order_model.dart';

class OrderRepositoryImpl implements OrderRepository {
  final OrderRemoteDataSource remoteDataSource;

  OrderRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, String>> createOrder(OrderEntity order) async {
    try {
      final model = OrderModel.fromEntity(order);
      final id = await remoteDataSource.createOrder(model);
      return Right(id);
    } catch (e) {
      return Left(ServerFailure('Lỗi tạo đơn hàng: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<OrderEntity>>> getOrders({
    String? customerId,
    String? deliveryStatus,
    String? searchQuery,
  }) async {
    try {
      final models = await remoteDataSource.getOrders(
        customerId: customerId,
        deliveryStatus: deliveryStatus,
        searchQuery: searchQuery,
      );
      return Right(models);
    } catch (e) {
      return Left(ServerFailure('Lỗi tải danh sách đơn hàng: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, OrderEntity>> getOrderDetail(String orderId) async {
    try {
      final model = await remoteDataSource.getOrderDetail(orderId);
      return Right(model);
    } catch (e) {
      return Left(ServerFailure('Lỗi tải chi tiết đơn hàng: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> updateOrderStatus(
    String orderId,
    String deliveryStatus, {
    String? paymentStatus,
  }) async {
    try {
      await remoteDataSource.updateOrderStatus(
        orderId,
        deliveryStatus,
        paymentStatus: paymentStatus,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure('Lỗi cập nhật trạng thái đơn hàng: ${e.toString()}'));
    }
  }
}
