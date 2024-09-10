import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_event.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_state.dart';
import 'package:diantar_jarak/data/service/history_perjalanan_service/history_perjalanan_service.dart';
import 'package:diantar_jarak/data/models/history_perjalanan_model/history_perjalanan_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HistoryPerjalananBloc
    extends Bloc<HistoryPerjalananEvent, HistoryPerjalananState> {
  final HistoryPerjalananService historyPerjalananService;

  HistoryPerjalananBloc({
    required this.historyPerjalananService,
  }) : super(HistoryPerjalananInitial()) {
    on<FetchHistory>(_onFetchHistory);
    on<ChangeHistoryStatusEvent>(_onChangeHistoryStatusEvent);
    on<UpdateHistoryEvent>(_onUpdateHistoryEvent);
  }

  void _onFetchHistory(
      FetchHistory event, Emitter<HistoryPerjalananState> emit) async {
    if (state is HistoryPerjalananLoading) return;

    final currentState = state;
    var currentPage = event.page;
    var oldHistories = <HistoryPerjalananModel>[];

    if (currentState is HistoryPerjalananLoaded && currentPage > 1) {
      oldHistories = currentState.histories;
    } else {
      currentPage = 1;
    }

    emit(HistoryPerjalananLoading());

    try {
      final historyData =
          await historyPerjalananService.getHistoriesWithFilters(
        namaDriver: event.namaDriver,
        createdBy: event.createdBy,
        status: event.status,
        timeline: event.timeline,
      );
      var filteredHistories = historyData.data;

      final totalCount = filteredHistories.length;
      final pagedHistories =
          filteredHistories.skip((currentPage - 1) * 10).take(10).toList();

      if (pagedHistories.isEmpty && currentPage == 1) {
        emit(HistoryPerjalananNoData());
      } else if (pagedHistories.isEmpty) {
        emit(HistoryPerjalananLoaded(
          histories: oldHistories,
          currentPage: currentPage,
          totalCount: totalCount,
        ));
      } else {
        emit(HistoryPerjalananLoaded(
          histories: oldHistories + pagedHistories,
          currentPage: currentPage,
          totalCount: totalCount,
        ));
      }
    } catch (e) {
      emit(HistoryPerjalananError(message: e.toString()));
    }
  }

  void _onChangeHistoryStatusEvent(
      ChangeHistoryStatusEvent event, Emitter<HistoryPerjalananState> emit) {
    if (state is HistoryPerjalananLoaded) {
      final currentState = state as HistoryPerjalananLoaded;
      final updatedHistories = currentState.histories.map((history) {
        if (history.perjalananId == event.perjalananID) {
          return HistoryPerjalananModel(
            createdBy: history.createdBy,
            jamKembali: history.jamKembali,
            jamPengiriman: history.jamPengiriman,
            minDurasiPengiriman: history.minDurasiPengiriman,
            minJarakPengiriman: history.minJarakPengiriman,
            namaDriver: history.namaDriver,
            nomorPolisiKendaraan: history.nomorPolisiKendaraan,
            perjalananId: history.perjalananId,
            shiftKe: history.shiftKe,
            status: event.newStatus,
            tipeKendaraan: history.tipeKendaraan,
          );
        }
        return history;
      }).toList();
      emit(HistoryPerjalananLoaded(
        histories: updatedHistories,
        currentPage: currentState.currentPage,
        totalCount: currentState.totalCount,
      ));
    }
  }

  void _onUpdateHistoryEvent(
      UpdateHistoryEvent event, Emitter<HistoryPerjalananState> emit) async {
    emit(HistoryPerjalananLoading());
    try {
      final historyData =
          await historyPerjalananService.getHistoriesWithFilters(
        namaDriver: '',
        createdBy: '',
        status: '',
        timeline: '',
      );

      emit(HistoryPerjalananLoaded(
        histories: historyData.data,
        currentPage: 1,
        totalCount: historyData.data.length,
      ));
    } catch (e) {
      emit(HistoryPerjalananError(message: e.toString()));
    }
  }
}
