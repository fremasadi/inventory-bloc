import 'package:equatable/equatable.dart';

import '../../../core/models/item.dart';

// Item Events
abstract class ItemEvent extends Equatable {
  const ItemEvent();

  @override
  List<Object?> get props => [];
}

class FetchItems extends ItemEvent {}

class CreateItem extends ItemEvent {
  final Item item;

  const CreateItem(this.item);

  @override
  List<Object?> get props => [item];
}

class UpdateItem extends ItemEvent {
  final Item item;

  const UpdateItem(this.item);

  @override
  List<Object?> get props => [item];
}

class DeleteItem extends ItemEvent {
  final int itemId;

  const DeleteItem(this.itemId);

  @override
  List<Object> get props => [itemId];
}
