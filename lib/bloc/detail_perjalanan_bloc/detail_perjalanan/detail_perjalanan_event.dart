import 'package:equatable/equatable.dart';

abstract class DetailPerjalananEvent extends Equatable {
  const DetailPerjalananEvent();

  @override
  List<Object> get props => [];
}

class FetchDetailPerjalanan extends DetailPerjalananEvent {
  final String perjalananID;

  const FetchDetailPerjalanan(this.perjalananID);

  @override
  List<Object> get props => [perjalananID];
}
