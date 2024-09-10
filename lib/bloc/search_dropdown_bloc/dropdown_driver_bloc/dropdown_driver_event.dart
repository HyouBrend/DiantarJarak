import 'package:equatable/equatable.dart';

abstract class DriverEvent extends Equatable {
  const DriverEvent();
}

class FetchDrivers extends DriverEvent {
  final String query;

  const FetchDrivers({this.query = ''});

  @override
  List<Object?> get props => [query];
}

class LoadDrivers extends DriverEvent {
  @override
  List<Object?> get props => [];
}
