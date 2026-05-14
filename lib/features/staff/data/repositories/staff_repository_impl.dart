import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../domain/entities/staff_entity.dart';
import '../../domain/repositories/staff_repository.dart';
import '../datasources/staff_remote_data_source.dart';
import '../models/staff_model.dart';

class StaffRepositoryImpl implements StaffRepository {
  final StaffRemoteDataSource remoteDataSource;

  StaffRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<StaffEntity>>> getStaffs() async {
    try {
      final staffs = await remoteDataSource.getStaffs();
      return Right(staffs);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> addStaff(StaffEntity staff) async {
    try {
      final model = StaffModel.fromEntity(staff);
      final password = staff.password ?? '';
      if (password.isEmpty) {
        return Left(ServerFailure('Mật khẩu không được để trống'));
      }
      await remoteDataSource.addStaff(model, password);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> updateStaff(StaffEntity staff) async {
    try {
      final model = StaffModel.fromEntity(staff);
      await remoteDataSource.updateStaff(model, staff.password);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteStaff(String id) async {
    try {
      await remoteDataSource.deleteStaff(id);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<StaffEntity>>> searchStaffs(String query) async {
    try {
      final staffs = await remoteDataSource.searchStaffs(query);
      return Right(staffs);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> sendPasswordReset(String email) async {
    try {
      await remoteDataSource.sendPasswordReset(email);
      return const Right(null);
    } catch (e) {
      return Left(AuthFailure(e.toString()));
    }
  }
}
