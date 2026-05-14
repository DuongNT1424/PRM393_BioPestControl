import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/auth_entity.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

/// Triển khai thực tế (Implementation) của AuthRepository.
/// Lớp này chịu trách nhiệm điều phối việc lấy dữ liệu từ RemoteDataSource
/// và xử lý các lỗi phát sinh để trả về các đối tượng Failure hoặc Entity.
class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;

  AuthRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, AuthEntity>> login({
    required String email,
    required String password,
  }) async {
    try {
      // Gọi tới nguồn dữ liệu từ xa (Firebase/API)
      final user = await remoteDataSource.login(email, password);
      return Right(user); // Trả về kết quả thành công bên phải (Right)
    } catch (e) {
      // Nếu có lỗi, trả về lỗi bên trái (Left)
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> register({
    required String email,
    required String password,
    required String name,
    String phone = '',
  }) async {
    try {
      final user = await remoteDataSource.register(email, password, name, phone);
      return Right(user);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity>> loginWithGoogle() async {
    try {
      final user = await remoteDataSource.loginWithGoogle();
      return Right(user);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> logout() async {
    try {
      await remoteDataSource.logout();
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, AuthEntity?>> getCurrentUser() async {
    try {
      final user = await remoteDataSource.getCurrentUser();
      return Right(user);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
