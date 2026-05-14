import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/staff_entity.dart';
import '../repositories/staff_repository.dart';

class AddStaffUseCase implements UseCase<void, StaffEntity> {
  final StaffRepository repository;

  AddStaffUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(StaffEntity staff) async {
    return await repository.addStaff(staff);
  }
}
