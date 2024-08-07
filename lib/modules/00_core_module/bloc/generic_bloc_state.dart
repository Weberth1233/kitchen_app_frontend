import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
abstract class GenericBlocState<R> extends Equatable {
  @override
  // TODO: implement props
  List<Object?> get props => [];
}

class GenericBlocInitialState<R> extends GenericBlocState<R> {
  GenericBlocInitialState();
}

class GenericBlocLoadingState<R> extends GenericBlocState<R> {
  GenericBlocLoadingState();
}

class GenericBlocLoadedState<R, T> extends GenericBlocState<R> {
  final List<T> entityList;

  GenericBlocLoadedState({required this.entityList});

  @override
  // TODO: implement props
  List<Object?> get props => [entityList];
}

class GenericBlocErrorState<R> extends GenericBlocState<R> {
  final String message;

  GenericBlocErrorState({required this.message});
  @override
  // TODO: implement props
  List<Object?> get props => [message];
}
