import 'package:equatable/equatable.dart';

import '../../../core/models/category.dart';
import '../../../core/models/item.dart';
import '../../../core/models/supplier.dart';

// Item States
abstract class ItemState extends Equatable {
  const ItemState();

  @override
  List<Object?> get props => [];
}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemLoaded extends ItemState {
  final List<Item> items;

  const ItemLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class ItemError extends ItemState {
  final String message;

  const ItemError(this.message);

  @override
  List<Object?> get props => [message];
}

class ItemSuccess extends ItemState {
  final String message;

  const ItemSuccess(this.message);

  @override
  List<Object?> get props => [message];
}
