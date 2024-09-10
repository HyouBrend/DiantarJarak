import 'package:bloc/bloc.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/submit_perjalanan/submit_perjalanan_event.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/submit_perjalanan/submit_perjalanan_state.dart';

import 'package:diantar_jarak/data/service/submit_perjalanan_service/submit_perjalanan_service.dart';

class SubmitPerjalananBloc
    extends Bloc<SubmitPerjalananEvent, SubmitPerjalananState> {
  final SubmitPerjalananService submitPerjalananService;

  SubmitPerjalananBloc({required this.submitPerjalananService})
      : super(SubmitPerjalananInitial());

  @override
  Stream<SubmitPerjalananState> mapEventToState(
    SubmitPerjalananEvent event,
  ) async* {
    if (event is SubmitPerjalanan) {
      yield PerjalananSubmitting();
      try {
        await submitPerjalananService
            .submitPengantaran(event.submitPerjalananModel);
        yield PerjalananSubmitted(
          detailPerjalanan: event.submitPerjalananModel,
        );
      } catch (e) {
        yield SubmitPerjalananError(message: e.toString());
      }
    }
  }
}
