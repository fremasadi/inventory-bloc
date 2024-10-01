import 'package:equatable/equatable.dart';

import '../../../core/models/category.dart';

abstract class CategoryState extends Equatable {
  @override
  List<Object?> get props => [];
}

class CategoryInitial extends CategoryState {}

class CategoryLoading extends CategoryState {}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;

  CategoryLoaded(this.categories);

  @override
  List<Object?> get props => [categories];
}

class CategoryError extends CategoryState {
  final String message;

  CategoryError(this.message);

  @override
  List<Object?> get props => [message];
}

class CategoryDeleted extends CategoryState {
  final String message;

  CategoryDeleted(this.message);

  @override
  List<Object?> get props => [message];
}
