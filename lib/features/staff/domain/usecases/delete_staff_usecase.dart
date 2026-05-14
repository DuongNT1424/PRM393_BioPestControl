import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../repositories/staff_repository.dart';

class DeleteStaffUseCase implements UseCase<void, String> {
  final StaffRepository repository;

  DeleteStaffUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(String id) async {
    return await repository.deleteStaff(id);
  }
}
