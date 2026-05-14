import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/staff_entity.dart';
import '../repositories/staff_repository.dart';

class GetStaffsUseCase implements UseCase<List<StaffEntity>, NoParams> {
  final StaffRepository repository;

  GetStaffsUseCase(this.repository);

  @override
  Future<Either<Failure, List<StaffEntity>>> call(NoParams params) async {
    return await repository.getStaffs();
  }
}
