import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/models/item.dart';
import '../../../core/repository/item_repository.dart';
import 'item_event.dart';
import 'item_state.dart';

// Item Bloc
class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository itemRepository;

  ItemBloc(this.itemRepository) : super(ItemInitial()) {
    // Fetch Items
    on<FetchItems>((event, emit) async {
      emit(ItemLoading());
      try {
        final items = await itemRepository.fetchItems();
        emit(ItemLoaded(items));
      } catch (e) {
        emit(ItemError("Failed to load items: ${e.toString()}"));
      }
    });

    // Create Item
    on<CreateItem>((event, emit) async {
      emit(ItemLoading());
      try {
        await itemRepository.createItem(event.item);
        emit(ItemSuccess("Item created successfully"));
        add(FetchItems()); // Refresh the list after creation
      } catch (e) {
        emit(ItemError("Failed to create item: ${e.toString()}"));
      }
    });

    // Update Item
    on<UpdateItem>((event, emit) async {
      emit(ItemLoading());
      try {
        await itemRepository.updateItem(event.item);
        emit(ItemSuccess("Item updated successfully"));
        add(FetchItems()); // Refresh the list after update
      } catch (e) {
        emit(ItemError("Failed to update item: ${e.toString()}"));
      }
    });

    on<DeleteItem>((event, emit) async {
      emit(ItemLoading());
      try {
        await itemRepository.deleteItem(event.itemId);
        add(FetchItems()); // Fetch the updated item list
        emit(ItemSuccess("Item Berhasil Dihapus"));
      } catch (e) {
        emit(ItemError("Failed to delete item: ${e.toString()}"));
      }
    });

    on<SearchItems>((event, emit) async {
      emit(ItemLoading());
      try {
        final items = await itemRepository.searchItems(event.query);
        emit(ItemLoaded(items));
      } catch (e) {
        emit(ItemError('Failed to search items'));
      }
    });
  }
}
