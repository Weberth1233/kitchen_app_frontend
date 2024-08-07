import 'package:dartz/dartz.dart';
import 'package:kitchen_app/modules/00_core_module/failures/failures.dart';
import '../repositories/irepository.dart';
import 'iuse_case.dart';

class UseCase<T, Params, R extends T> implements IUseCase<T, Params, R> {
  final IRepository<T, R> reposity;
  UseCase({required this.reposity});

  @override
  Future<Either<Failure, List<T>>> call(GetAllParams<R> params) async {
    return reposity.getAll(params.table, params.fromJson);
  }
}
