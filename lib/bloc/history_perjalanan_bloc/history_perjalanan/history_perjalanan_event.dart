import 'package:equatable/equatable.dart';

abstract class HistoryPerjalananEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class FetchHistory extends HistoryPerjalananEvent {
  final int page;
  final String namaDriver;
  final String createdBy;
  final String status;
  final String timeline;

  FetchHistory({
    required this.page,
    this.namaDriver = '',
    this.createdBy = '',
    this.status = '',
    this.timeline = '',
  });

  @override
  List<Object> get props => [page, namaDriver, createdBy, status, timeline];
}

class ChangeHistoryStatusEvent extends HistoryPerjalananEvent {
  final String perjalananID;
  final String newStatus;

  ChangeHistoryStatusEvent(this.perjalananID, this.newStatus);

  @override
  List<Object> get props => [perjalananID, newStatus];
}

class UpdateHistoryEvent extends HistoryPerjalananEvent {
  final String perjalananID;

  UpdateHistoryEvent(this.perjalananID);

  @override
  List<Object> get props => [perjalananID];
}
