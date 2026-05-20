import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../entities/profile_entity.dart';

abstract class ProfileRepository {
  Future<Either<Failure, ProfileEntity>> updateProfile({required String name, String? photoUrl});
  Future<Either<Failure, void>> changePassword({required String oldPassword, required String newPassword});
}
