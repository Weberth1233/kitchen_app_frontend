import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../failures/failures.dart';

abstract class IUseCase<T, Params, R> {
  Future<Either<Failure, List<T>>> call(GetAllParams<R> params);
  Future<Either<Failure, bool>> remove(RemoveParams<R> params);
}

abstract class Params extends Equatable {}

class NoParams extends Params {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GetAllParams<R> extends Params {
  final String table;
  final R Function(Map<String, dynamic> map) fromMap;

  GetAllParams({required this.table, required this.fromMap});

  @override
  // TODO: implement props
  List<Object?> get props => [table, fromMap];
}

class RemoveParams<R> extends Params {
  final String table;
  final int id;

  RemoveParams({required this.table, required this.id});
  @override
  // TODO: implement props
  List<Object?> get props => throw UnimplementedError();
}
