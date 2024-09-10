import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/detail_perjalanan/detail_perjalanan_event.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/detail_perjalanan/detail_perjalanan_state.dart';
import 'package:diantar_jarak/data/service/detail_perjalanan_service/detail_perjalanan_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPerjalananBloc
    extends Bloc<DetailPerjalananEvent, DetailPerjalananState> {
  final DetailPerjalananService detailPerjalananService;

  DetailPerjalananBloc(this.detailPerjalananService)
      : super(DetailPerjalananInitial()) {
    on<FetchDetailPerjalanan>(_onFetchDetailPerjalanan);
  }

  void _onFetchDetailPerjalanan(
      FetchDetailPerjalanan event, Emitter<DetailPerjalananState> emit) async {
    emit(DetailPerjalananLoading());
    try {
      final details = await detailPerjalananService
          .fetchDetailPengantaran(event.perjalananID);
      emit(DetailPerjalananLoaded(details));
    } catch (e) {
      emit(DetailPerjalananError(e.toString()));
    }
  }
}
