import 'package:dartz/dartz.dart';
import '../failures/failures.dart';
import '../repositories/reposity_impl.dart';
import 'iuse_case.dart';

class UseCase<T, Params, R extends T> implements IUseCase<T, Params, R> {
  final Reposity<T, R> reposity;
  UseCase({required this.reposity});

  @override
  Future<Either<Failure, List<T>>> call(GetAllParams<R> params) async {
    try {
      final result = await reposity.getAll(params.table, params.fromMap);
      return result.fold(
        (failure) => Left(failure),
        (entity) => Right(entity),
      );
    } on Exception catch (_) {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, bool>> remove(RemoveParams<R> params) async {
    try {
      final result = await reposity.delete(params.table, params.id);
      return result.fold(
        (failure) => Left(failure),
        (entity) => Right(entity),
      );
    } on Exception catch (_) {
      return Left(ServerFailure());
    }
  }
}
