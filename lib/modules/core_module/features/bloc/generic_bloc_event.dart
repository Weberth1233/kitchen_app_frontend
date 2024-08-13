import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GenericBlocEvent<R> extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

@immutable
class LoadGenericBlocEvent<R> extends GenericBlocEvent<R> {
  LoadGenericBlocEvent();
}

@immutable
class LoadGenericPaginatedBlocEvent<R> extends GenericBlocEvent<R> {
  final Map<String, dynamic> params;
  final bool filter;
  LoadGenericPaginatedBlocEvent({required this.params, this.filter = false});
}

@immutable
class RemoveGenericBlocEvent<R, T> extends GenericBlocEvent<R> {
  final T entity;

  RemoveGenericBlocEvent({required this.entity});
}
