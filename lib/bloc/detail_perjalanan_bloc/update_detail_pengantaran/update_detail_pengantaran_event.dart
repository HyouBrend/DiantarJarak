import 'package:diantar_jarak/data/models/detail_perjalanan_model/update_detail_pengantaran_model.dart';
import 'package:equatable/equatable.dart';

abstract class UpdateDetailPengantaranEvent extends Equatable {
  const UpdateDetailPengantaranEvent();

  @override
  List<Object> get props => [];
}

class SubmitUpdateDetailPengantaran extends UpdateDetailPengantaranEvent {
  final UpdateDetailPengantaranModel detail;

  const SubmitUpdateDetailPengantaran(this.detail);

  @override
  List<Object> get props => [detail];
}
