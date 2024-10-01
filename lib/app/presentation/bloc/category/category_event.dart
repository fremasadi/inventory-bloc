// Event
import 'package:equatable/equatable.dart';

import '../../../core/models/category.dart';

abstract class CategoryEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchCategory extends CategoryEvent {}

class CreateCategory extends CategoryEvent {
  final Category category;

  CreateCategory(this.category);

  @override
  List<Object?> get props => [category];
}

class EditCategory extends CategoryEvent {
  final Category category; // The category to be edited

  EditCategory(this.category);

  @override
  List<Object?> get props => [category]; // Add category to props
}

class SearchCategory extends CategoryEvent {
  final String query;

  SearchCategory(this.query);

  @override
  List<Object?> get props =>
      [query]; // Pastikan untuk memasukkan query ke props
}

class DeleteCategory extends CategoryEvent {
  final int categoryId;

  DeleteCategory(this.categoryId);

  @override
  List<Object?> get props => [categoryId];
}
