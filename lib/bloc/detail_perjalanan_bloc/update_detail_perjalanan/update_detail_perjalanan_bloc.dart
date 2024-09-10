import 'package:bloc/bloc.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_perjalanan/update_detail_perjalanan_event.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_perjalanan/update_detail_perjalanan_state.dart';
import 'package:diantar_jarak/data/service/detail_perjalanan_service/update_detail_perjalanan_service.dart';

class UpdateDetailPerjalananBloc
    extends Bloc<UpdateDetailPerjalananEvent, UpdateDetailPerjalananState> {
  final UpdateDetailPerjalananService service;

  UpdateDetailPerjalananBloc(this.service)
      : super(UpdateDetailPerjalananInitial()) {
    on<SubmitUpdateDetailPerjalanan>(_onSubmitUpdateDetailPerjalanan);
  }

  void _onSubmitUpdateDetailPerjalanan(SubmitUpdateDetailPerjalanan event,
      Emitter<UpdateDetailPerjalananState> emit) async {
    emit(UpdateDetailPerjalananLoading());
    try {
      await service.updateDetailPerjalanan(event.detail);
      emit(UpdateDetailPerjalananSuccess());
    } catch (e) {
      emit(UpdateDetailPerjalananError(e.toString()));
    }
  }
}
