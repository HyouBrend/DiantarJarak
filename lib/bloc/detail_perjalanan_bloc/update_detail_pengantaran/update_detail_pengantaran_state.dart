import 'package:equatable/equatable.dart';

abstract class UpdateDetailPengantaranState extends Equatable {
  const UpdateDetailPengantaranState();

  @override
  List<Object> get props => [];
}

class UpdateDetailPengantaranInitial extends UpdateDetailPengantaranState {}

class UpdateDetailPengantaranLoading extends UpdateDetailPengantaranState {}

class UpdateDetailPengantaranSuccess extends UpdateDetailPengantaranState {}

class UpdateDetailPengantaranError extends UpdateDetailPengantaranState {
  final String message;

  const UpdateDetailPengantaranError(this.message);

  @override
  List<Object> get props => [message];
}
