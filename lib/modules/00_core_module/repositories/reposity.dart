import 'package:dartz/dartz.dart';
import '../datasources/idata_sources.dart';
import '../failures/failures.dart';
import 'irepository.dart';

class Reposity<T, R extends T> implements IRepository<T, R> {
  final IDatasource<R> dataSourcesImpl;
  Reposity({required this.dataSourcesImpl});

  @override
  Future<Either<Failure, List<T>>> getAll(
      String path, List<R> Function(String p1) fromJson) async {
    try {
      final result = await dataSourcesImpl.get(path, fromJson);
      return right(result);
    } on ServerFailure catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, List<T>>> getAllPaginated(String path,
      List<R> Function(String p1) fromJson, Map<String, dynamic> params) async {
    try {
      final result = await dataSourcesImpl.getPaginated(path, fromJson, params);
      return right(result);
    } on ServerFailure catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }

  @override
  Future<Either<Failure, T>> getEntity(
      String path, R Function(Map<String, dynamic> json) fromJson) async {
    try {
      final result = await dataSourcesImpl.getEntity(path, fromJson);
      return right(result);
    } on ServerFailure catch (_) {
      return left(ServerFailure());
    } catch (e) {
      print(e);
      return left(GeneralFailure());
    }
  }
}
