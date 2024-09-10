import 'package:equatable/equatable.dart';
import 'package:diantar_jarak/data/models/submit_perjalanan_model/submit_perjalanan_model.dart';

abstract class SubmitPerjalananState extends Equatable {
  const SubmitPerjalananState();

  @override
  List<Object> get props => [];
}

class SubmitPerjalananInitial extends SubmitPerjalananState {}

class PerjalananSubmitting extends SubmitPerjalananState {}

class PerjalananSubmitted extends SubmitPerjalananState {
  final SubmitPerjalananModel detailPerjalanan;

  const PerjalananSubmitted({
    required this.detailPerjalanan,
  });

  @override
  List<Object> get props => [detailPerjalanan];
}

class SubmitPerjalananError extends SubmitPerjalananState {
  final String message;

  const SubmitPerjalananError({required this.message});

  @override
  List<Object> get props => [message];
}
