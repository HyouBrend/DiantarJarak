import 'package:equatable/equatable.dart';
import 'package:diantar_jarak/data/models/detail_perjalanan_model/update_detail_perjalanan_model.dart';

abstract class UpdateDetailPerjalananEvent extends Equatable {
  const UpdateDetailPerjalananEvent();

  @override
  List<Object> get props => [];
}

class SubmitUpdateDetailPerjalanan extends UpdateDetailPerjalananEvent {
  final UpdateDetailPerjalananModel detail;

  const SubmitUpdateDetailPerjalanan(this.detail);

  @override
  List<Object> get props => [detail];
}
