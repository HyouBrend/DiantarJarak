import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_driver_bloc/dropdown_driver_event.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_driver_bloc/dropdown_driver_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:diantar_jarak/data/service/search_dropdown_service/dropdown_driver_service.dart';

class DriverBloc extends Bloc<DriverEvent, DriverState> {
  final DropdriveService dropdriveService;

  DriverBloc({required this.dropdriveService}) : super(DriverInitial()) {
    on<FetchDrivers>((event, emit) async {
      emit(DriverLoading());
      try {
        final result = await dropdriveService.getDrivers(event.query);
        if (result.data.isNotEmpty) {
          emit(DriverHasData(result.data));
        } else {
          emit(DriverEmpty());
        }
      } catch (error) {
        emit(DriverError(error.toString()));
      }
    });
  }
}
