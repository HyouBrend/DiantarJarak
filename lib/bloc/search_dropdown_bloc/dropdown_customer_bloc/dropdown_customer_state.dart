import 'package:equatable/equatable.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_customer_model.dart';

abstract class CustomerState extends Equatable {
  const CustomerState();

  @override
  List<Object> get props => [];
}

class CustomerInitial extends CustomerState {}

class CustomerLoading extends CustomerState {}

class CustomerError extends CustomerState {
  final String message;

  const CustomerError(this.message);

  @override
  List<Object> get props => [message];
}

class CustomerHasData extends CustomerState {
  final List<DropdownCustomerModel> customers;

  const CustomerHasData(this.customers);

  @override
  List<Object> get props => [customers];
}

class CustomerEmpty extends CustomerState {}
