import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_perjalanan/update_detail_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_perjalanan/update_detail_perjalanan_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:dio/dio.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_event.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_state.dart';
import 'package:diantar_jarak/data/service/history_perjalanan_service/history_perjalanan_service.dart';
import 'package:diantar_jarak/helpers/network/api_helper_dio.dart';
import 'package:diantar_jarak/pages/history_perjalanan/history_perjalanan_widget/card_history.dart';
import 'package:diantar_jarak/pages/history_perjalanan/history_perjalanan_widget/filter_history.dart';
import 'package:diantar_jarak/pages/history_perjalanan/history_perjalanan_widget/paging_history.dart';
import 'package:diantar_jarak/theme/theme.dart';

class HistoryPerjalananPage extends StatefulWidget {
  @override
  _HistoryPerjalananPageState createState() => _HistoryPerjalananPageState();
}

class _HistoryPerjalananPageState extends State<HistoryPerjalananPage> {
  String? selectedDriver;
  String? selectedChecker;
  String? selectedStatus;
  String? selectedTimeline;

  void _applyFilter(
      String? driver, String? checker, String? status, String? timeline) {
    setState(() {
      selectedDriver = driver;
      selectedChecker = checker;
      selectedStatus = status;
      selectedTimeline = timeline;
    });
    context.read<HistoryPerjalananBloc>().add(FetchHistory(
          page: 1,
          namaDriver: driver ?? '',
          createdBy: checker ?? '',
          status: status ?? '',
          timeline: timeline ?? '',
        ));
  }

  @override
  Widget build(BuildContext context) {
    final apiHelper = ApiHelperImpl(dio: Dio());
    final historyService = HistoryPerjalananService(apiHelper: apiHelper);

    return BlocProvider(
      create: (context) => HistoryPerjalananBloc(
        historyPerjalananService: historyService,
      )..add(FetchHistory(page: 1)),
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'History Perjalanan',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.bold,
              color: Color(0xFF363535),
            ),
          ),
          backgroundColor: CustomColorPalette.backgroundColor,
          centerTitle: true,
        ),
        body: MultiBlocListener(
          listeners: [
            BlocListener<HistoryPerjalananBloc, HistoryPerjalananState>(
              listener: (context, state) {
                if (state is HistoryPerjalananError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Error: ${state.message}')),
                  );
                } else if (state is HistoryPerjalananLoaded) {
                  // Handle any specific UI updates when histories are loaded
                }
              },
            ),
            BlocListener<UpdateDetailPerjalananBloc,
                UpdateDetailPerjalananState>(
              listener: (context, state) {
                if (state is UpdateDetailPerjalananSuccess) {
                  // Refresh list after update success
                  context.read<HistoryPerjalananBloc>().add(FetchHistory(
                        page: 1,
                        namaDriver: selectedDriver ?? '',
                        createdBy: selectedChecker ?? '',
                        status: selectedStatus ?? '',
                        timeline: selectedTimeline ?? '',
                      ));
                }
              },
            ),
          ],
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 300),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FilterHistory(),
                Expanded(
                  child: BlocBuilder<HistoryPerjalananBloc,
                      HistoryPerjalananState>(
                    builder: (context, state) {
                      if (state is HistoryPerjalananLoading) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (state is HistoryPerjalananError) {
                        return Center(child: Text('Error: ${state.message}'));
                      } else if (state is HistoryPerjalananNoData) {
                        return const Center(child: Text('Tidak ada data'));
                      } else if (state is HistoryPerjalananLoaded) {
                        final historyPerjalanan = state.histories;
                        final displayedHistory = historyPerjalanan
                            .skip((state.currentPage - 1) * 10)
                            .take(10)
                            .toList();
                        final totalPages = (state.totalCount / 10).ceil();

                        return Column(
                          children: [
                            Expanded(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListView.builder(
                                  itemCount: displayedHistory.length,
                                  itemBuilder: (context, index) {
                                    final item = displayedHistory[index];
                                    return CardHistory(historyItem: item);
                                  },
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: PagingHistory(
                                currentPage: state.currentPage,
                                totalPages: totalPages,
                                onPageChanged: (newPage) {
                                  context.read<HistoryPerjalananBloc>().add(
                                        FetchHistory(
                                          page: newPage,
                                          namaDriver: selectedDriver ?? '',
                                          createdBy: selectedChecker ?? '',
                                          status: selectedStatus ?? '',
                                          timeline: selectedTimeline ?? '',
                                        ),
                                      );
                                },
                              ),
                            ),
                          ],
                        );
                      }
                      return const Center(child: Text('No data available'));
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
