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
class RemoveGenericBlocEvent<R, T> extends GenericBlocEvent<R> {
  final T entity;

  RemoveGenericBlocEvent({required this.entity});
}
