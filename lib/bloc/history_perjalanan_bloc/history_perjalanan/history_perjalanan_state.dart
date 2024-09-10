import 'package:equatable/equatable.dart';
import 'package:diantar_jarak/data/models/history_perjalanan_model/history_perjalanan_model.dart';

abstract class HistoryPerjalananState extends Equatable {
  final bool isLoading;

  HistoryPerjalananState({this.isLoading = true});

  @override
  List<Object?> get props => [isLoading];
}

class HistoryPerjalananInitial extends HistoryPerjalananState {}

class HistoryPerjalananLoading extends HistoryPerjalananState {
  HistoryPerjalananLoading() : super(isLoading: true);
}

class HistoryPerjalananLoaded extends HistoryPerjalananState {
  final List<HistoryPerjalananModel> histories;
  final int currentPage;
  final int totalCount;

  HistoryPerjalananLoaded({
    required this.histories,
    required this.currentPage,
    required this.totalCount,
    bool isLoading = false,
  }) : super(isLoading: isLoading);

  @override
  List<Object?> get props => [histories, currentPage, totalCount, isLoading];
}

class HistoryPerjalananError extends HistoryPerjalananState {
  final String message;

  HistoryPerjalananError({required this.message}) : super(isLoading: false);

  @override
  List<Object?> get props => [message, isLoading];
}

class HistoryPerjalananNoData extends HistoryPerjalananState {
  HistoryPerjalananNoData() : super(isLoading: false);
}
