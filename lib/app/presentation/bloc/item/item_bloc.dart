import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:inventory/app/data/models/item.dart';
import '../../../core/repository/item_repository.dart';

// Event
abstract class ItemEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchItem extends ItemEvent {}

// State
abstract class ItemState extends Equatable {
  @override
  List<Object?> get props => [];
}

class ItemInitial extends ItemState {}

class ItemLoading extends ItemState {}

class ItemLoaded extends ItemState {
  final List<Item> items;

  ItemLoaded(this.items);

  @override
  List<Object?> get props => [items];
}

class ItemError extends ItemState {
  final String message;

  ItemError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository itemRepository;

  ItemBloc(this.itemRepository) : super(ItemInitial()) {
    on<FetchItem>((event, emit) async {
      emit(ItemLoading());
      try {
        final items = await itemRepository.fetchItems();
        emit(ItemLoaded(items));
      } catch (e) {
        emit(ItemError("Failed to fetch items: ${e.toString()}"));
      }
    });
  }
}
