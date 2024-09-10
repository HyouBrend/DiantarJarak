import 'package:equatable/equatable.dart';

abstract class UpdateDetailPerjalananState extends Equatable {
  const UpdateDetailPerjalananState();

  @override
  List<Object> get props => [];
}

class UpdateDetailPerjalananInitial extends UpdateDetailPerjalananState {}

class UpdateDetailPerjalananLoading extends UpdateDetailPerjalananState {}

class UpdateDetailPerjalananSuccess extends UpdateDetailPerjalananState {}

class UpdateDetailPerjalananError extends UpdateDetailPerjalananState {
  final String message;

  const UpdateDetailPerjalananError(this.message);

  @override
  List<Object> get props => [message];
}
