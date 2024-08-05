import 'package:dartz/dartz.dart';

import '../datasources/idata_sources.dart';
import '../failures/failures.dart';
import 'irepository.dart';

//T - BloodTypeEntity
//R - BloodTypeModel
class Reposity<T, R extends T> implements IRepository<T, R> {
  final IDatasource<R> dataSourcesImpl;

  Reposity({required this.dataSourcesImpl});

  @override
  Future<Either<Failure, bool>> add(T entity) {
    // TODO: implement add
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> delete(String path, int id) async {
    try {
      final result = await dataSourcesImpl.delete(path, id);
      return right(result);
    } on ServerFailure catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, T>> getById(String id) {
    // TODO: implement getById
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, bool>> update(T entity) {
    // TODO: implement update
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List<T>>> getAll(
      String path, R Function(Map<String, dynamic> map) fromMap) async {
    try {
      final result = await dataSourcesImpl.get(path, fromMap);
      return right(result);
    } on ServerFailure catch (_) {
      return left(ServerFailure());
    } catch (e) {
      return left(GeneralFailure());
    }
  }
}
