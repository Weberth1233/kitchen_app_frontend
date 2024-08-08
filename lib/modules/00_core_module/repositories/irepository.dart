import 'package:dartz/dartz.dart';

import '../failures/failures.dart';

abstract class IRepository<T, R> {
  Future<Either<Failure, List<T>>> getAll(
      String path, List<R> Function(String) fromJson);

  Future<Either<Failure, List<T>>> getAllPaginated(String path,
      List<R> Function(String) fromJson, Map<String, dynamic> params);
  // Future<Either<Failure, T>> getById(String id);
}
