import 'package:dartz/dartz.dart';
import '../../../../core/errors/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/staff_entity.dart';
import '../repositories/staff_repository.dart';

class SearchStaffsUseCase implements UseCase<List<StaffEntity>, String> {
  final StaffRepository repository;

  SearchStaffsUseCase(this.repository);

  @override
  Future<Either<Failure, List<StaffEntity>>> call(String query) async {
    return await repository.searchStaffs(query);
  }
}
