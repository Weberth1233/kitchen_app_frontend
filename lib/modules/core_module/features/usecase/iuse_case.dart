import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import '../../failures/failures.dart';

abstract class IUseCase<T, Params, R> {
  Future<Either<Failure, List<T>>> call(GetAllParams<R> params);
  Future<Either<Failure, T>> entity(GetEntityParams<R> params);
}

abstract class Params extends Equatable {}

class NoParams extends Params {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetAllParams<R> extends Params {
  final String table;
  final Map<String, dynamic>? mapParams;
  final List<R> Function(String p1) fromJson;

  GetAllParams({required this.table, required this.fromJson, this.mapParams});

  @override
  // TODO: implement props
  List<Object?> get props => [table, fromJson];
}

class GetEntityParams<R> extends Params {
  final String table;
  final R Function(Map<String, dynamic> json) fromJson;

  GetEntityParams({required this.table, required this.fromJson});

  @override
  // TODO: implement props
  List<Object?> get props => [table, fromJson];
}

class RemoveParams<R> extends Params {
  final String table;
  final int id;

  RemoveParams({required this.table, required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
