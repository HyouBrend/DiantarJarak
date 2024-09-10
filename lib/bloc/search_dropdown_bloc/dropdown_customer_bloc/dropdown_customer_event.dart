import 'package:equatable/equatable.dart';

abstract class CustomerEvent extends Equatable {
  const CustomerEvent();
}

class FetchCustomers extends CustomerEvent {
  final String query;

  const FetchCustomers({this.query = ''});

  @override
  List<Object?> get props => [query];
}

class LoadCustomers extends CustomerEvent {
  @override
  List<Object?> get props => [];
}
