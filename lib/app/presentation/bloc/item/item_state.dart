import 'package:equatable/equatable.dart';

import '../../../data/models/category.dart';
import '../../../data/models/item.dart';
import '../../../data/models/supplier.dart';

abstract class DataState extends Equatable {
  @override
  List<Object> get props => [];
}

class DataInitial extends DataState {}

class DataLoading extends DataState {}

class DataLoaded extends DataState {
  final List<Item> items;
  final List<Category> categories;
  final List<Supplier> suppliers;

  DataLoaded(
      {required this.items, required this.categories, required this.suppliers});

  @override
  List<Object> get props => [items, categories, suppliers];
}

class DataError extends DataState {
  final String message;

  DataError({required this.message});

  @override
  List<Object> get props => [message];
}
