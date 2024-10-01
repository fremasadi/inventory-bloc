import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../core/models/supplier.dart';
import '../../../core/repository/supplier_repository.dart';

// Event
abstract class SupplierEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class FetchSupplier extends SupplierEvent {}

// State
abstract class SupplierState extends Equatable {
  @override
  List<Object?> get props => [];
}

class SupplierInitial extends SupplierState {}

class SupplierLoading extends SupplierState {}

class SupplierLoaded extends SupplierState {
  final List<Supplier> suppliers;

  SupplierLoaded(this.suppliers);

  @override
  List<Object?> get props => [suppliers];
}

class SupplierError extends SupplierState {
  final String message;

  SupplierError(this.message);

  @override
  List<Object?> get props => [message];
}

// BLoC
class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  final SupplierRepository supplierRepository;

  SupplierBloc(this.supplierRepository) : super(SupplierInitial()) {
    on<FetchSupplier>((event, emit) async {
      emit(SupplierLoading());
      try {
        final suppliers = await supplierRepository.fetchSuppliers();
        emit(SupplierLoaded(suppliers));
      } catch (e) {
        emit(SupplierError("Failed to fetch suppliers: ${e.toString()}"));
      }
    });
  }
}
