import 'package:dartz/dartz.dart';
import '../../failures/failures.dart';
import '../repositories/irepository.dart';
import 'iuse_case.dart';

class UseCase<T, Params, R extends T> implements IUseCase<T, Params, R> {
  final IRepository<T, R> reposity;
  UseCase({required this.reposity});

  @override
  Future<Either<Failure, List<T>>> call(GetAllParams<R> params) async {
    if (params.mapParams != null) {
      return reposity.getAllPaginated(
          params.table, params.fromJson, params.mapParams!);
    } else {
      return reposity.getAll(params.table, params.fromJson);
    }
  }

  @override
  Future<Either<Failure, T>> entity(GetEntityParams<R> params) {
    return reposity.getEntity(params.table, params.fromJson);
  }
}
