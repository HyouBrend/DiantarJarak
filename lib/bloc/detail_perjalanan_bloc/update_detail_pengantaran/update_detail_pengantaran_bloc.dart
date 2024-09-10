import 'package:bloc/bloc.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_pengantaran/update_detail_pengantaran_event.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_pengantaran/update_detail_pengantaran_state.dart';
import 'package:diantar_jarak/data/service/detail_perjalanan_service/update_detail_pengantaran_service.dart';

class UpdateDetailPengantaranBloc
    extends Bloc<UpdateDetailPengantaranEvent, UpdateDetailPengantaranState> {
  final UpdateDetailPengantaranService service;

  UpdateDetailPengantaranBloc(this.service)
      : super(UpdateDetailPengantaranInitial()) {
    on<SubmitUpdateDetailPengantaran>(_onSubmitUpdateDetailPengantaran);
  }

  void _onSubmitUpdateDetailPengantaran(SubmitUpdateDetailPengantaran event,
      Emitter<UpdateDetailPengantaranState> emit) async {
    emit(UpdateDetailPengantaranLoading());
    try {
      await service.updateDetailPengantaran(event.detail);
      emit(UpdateDetailPengantaranSuccess());
    } catch (e) {
      emit(UpdateDetailPengantaranError(e.toString()));
    }
  }
}
