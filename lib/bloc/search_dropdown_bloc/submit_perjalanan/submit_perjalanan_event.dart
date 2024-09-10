import 'package:equatable/equatable.dart';
import 'package:diantar_jarak/data/models/submit_perjalanan_model/submit_perjalanan_model.dart';

abstract class SubmitPerjalananEvent extends Equatable {
  const SubmitPerjalananEvent();

  @override
  List<Object> get props => [];
}

class SubmitPerjalanan extends SubmitPerjalananEvent {
  final SubmitPerjalananModel submitPerjalananModel;

  SubmitPerjalanan({
    required this.submitPerjalananModel,
  });

  @override
  List<Object> get props => [submitPerjalananModel];
}
