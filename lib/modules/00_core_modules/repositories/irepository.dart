import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

abstract class IRepository<T, R> {
  Future<Either<Failure, List<T>>> getAll(
      String path, R Function(Map<String, dynamic> map) fromMap);
  Future<Either<Failure, T>> getById(String id);
  Future<Either<Failure, bool>> add(T entity);
  Future<Either<Failure, bool>> update(T entity);
  Future<Either<Failure, bool>> delete(String path, int id);
}
