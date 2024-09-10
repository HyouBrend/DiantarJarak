import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/detail_perjalanan/detail_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_pengantaran/update_detail_pengantaran_bloc.dart';
import 'package:diantar_jarak/bloc/detail_perjalanan_bloc/update_detail_perjalanan/update_detail_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_customer_bloc/dropdown_customer_bloc.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_driver_bloc/dropdown_driver_bloc.dart';
import 'package:diantar_jarak/data/service/detail_perjalanan_service/detail_perjalanan_service.dart';
import 'package:diantar_jarak/data/service/detail_perjalanan_service/update_detail_pengantaran_service.dart';
import 'package:diantar_jarak/data/service/detail_perjalanan_service/update_detail_perjalanan_service.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';
import 'package:diantar_jarak/util/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_bloc.dart';
import 'package:diantar_jarak/data/service/history_perjalanan_service/history_perjalanan_service.dart';
import 'package:diantar_jarak/data/service/search_dropdown_service/dropdown_customer_service.dart';
import 'package:diantar_jarak/data/service/search_dropdown_service/dropdown_driver_service.dart';
import 'package:diantar_jarak/helpers/network/api_helper_dio.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  initializeDateFormatting('id_ID', null).then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiHelper = ApiHelperImpl(dio: Dio());

    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<ApiHelper>(
          create: (context) => apiHelper,
        ),
        RepositoryProvider<DetailPerjalananService>(
          create: (context) => DetailPerjalananService(apiHelper: apiHelper),
        ),
        RepositoryProvider<DropdriveService>(
          create: (context) => DropdriveService(apiHelper: apiHelper),
        ),
        RepositoryProvider<CustomerService>(
          create: (context) => CustomerService(apiHelper: apiHelper),
        ),
        RepositoryProvider<HistoryPerjalananService>(
          create: (context) => HistoryPerjalananService(apiHelper: apiHelper),
        ),
        RepositoryProvider<UpdateDetailPengantaranService>(
          create: (context) =>
              UpdateDetailPengantaranService(apiHelper: apiHelper),
        ),
        RepositoryProvider<UpdateDetailPerjalananService>(
          create: (context) =>
              UpdateDetailPerjalananService(apiHelper: apiHelper),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => DetailPerjalananBloc(
              context.read<DetailPerjalananService>(),
            ),
          ),
          BlocProvider(
            create: (context) => DriverBloc(
              dropdriveService: context.read<DropdriveService>(),
            ),
          ),
          BlocProvider(
            create: (context) => CustomerBloc(
              customerService: context.read<CustomerService>(),
            ),
          ),
          BlocProvider(
            create: (context) => HistoryPerjalananBloc(
              historyPerjalananService:
                  context.read<HistoryPerjalananService>(),
            ),
          ),
          BlocProvider(
            create: (context) => UpdateDetailPengantaranBloc(
              context.read<UpdateDetailPengantaranService>(),
            ),
          ),
          BlocProvider(
            create: (context) => UpdateDetailPerjalananBloc(
              context.read<UpdateDetailPerjalananService>(),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'Diantar Jarak',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            scaffoldBackgroundColor: CustomColorPalette.backgroundColor,
          ),
          home: SplashScreen(),
        ),
      ),
    );
  }
}
