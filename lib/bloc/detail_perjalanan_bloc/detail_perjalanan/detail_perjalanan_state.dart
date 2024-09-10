import 'package:diantar_jarak/data/models/detail_perjalanan_model/detail_perjalanan_model.dart';
import 'package:equatable/equatable.dart';

abstract class DetailPerjalananState extends Equatable {
  const DetailPerjalananState();

  @override
  List<Object> get props => [];
}

class DetailPerjalananInitial extends DetailPerjalananState {}

class DetailPerjalananLoading extends DetailPerjalananState {}

class DetailPerjalananLoaded extends DetailPerjalananState {
  final List<DetailPerjalananModel> detailPerjalanan;

  const DetailPerjalananLoaded(this.detailPerjalanan);

  @override
  List<Object> get props => [detailPerjalanan];
}

class DetailPerjalananError extends DetailPerjalananState {
  final String message;

  const DetailPerjalananError(this.message);

  @override
  List<Object> get props => [message];
}
