import 'package:diantar_jarak/bloc/search_dropdown_bloc/submit_perjalanan/submit_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/submit_perjalanan/submit_perjalanan_event.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/submit_perjalanan/submit_perjalanan_state.dart';
import 'package:diantar_jarak/data/models/submit_perjalanan_model/submit_perjalanan_model.dart';
import 'package:diantar_jarak/data/service/submit_perjalanan_service/submit_perjalanan_service.dart';
import 'package:diantar_jarak/pages/search_dropdown/search_dropdown_widget/show_load.dart';
import 'package:diantar_jarak/pages/submit_perjalanan/submit_pengantaran.dart';
import 'package:diantar_jarak/pages/search_dropdown/search_dropdown_widget/cek_google_widget/container_cek_google.dart';
import 'package:diantar_jarak/util/size.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_drive_model.dart';
import 'package:diantar_jarak/pages/history_perjalanan/history_perjalanan_page.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_customer_model.dart';
import 'package:diantar_jarak/data/service/search_dropdown_service/cek_google_service.dart';
import 'package:diantar_jarak/helpers/network/api_helper.dart';
import 'package:diantar_jarak/helpers/network/api_helper_dio.dart';
import 'package:diantar_jarak/pages/search_dropdown/search_dropdown_widget/dropdown_widget/dropdown_customer.dart';
import 'package:diantar_jarak/pages/search_dropdown/search_dropdown_widget/dropdown_widget/dropdown_agent.dart';
import 'package:diantar_jarak/pages/search_dropdown/search_dropdown_widget/dropdown_widget/dropdown_driver.dart';
import 'package:diantar_jarak/pages/search_dropdown/search_dropdown_widget/dropdown_widget/dropdown_shift.dart';
import 'package:diantar_jarak/pages/search_dropdown/search_dropdown_widget/dropdown_widget/dropdown_tipekendaraan.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchDropdown extends StatefulWidget {
  const SearchDropdown({super.key});

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchDropdown> {
  final TextEditingController _shiftController = TextEditingController();
  final TextEditingController _jamPengirimanController =
      TextEditingController();
  final TextEditingController _jamKembaliController = TextEditingController();
  final TextEditingController _tipeKendaraanController =
      TextEditingController();
  final TextEditingController _nomorPolisiKendaraanController =
      TextEditingController();
  final TextEditingController _agentController = TextEditingController();
  final TextEditingController _driverController = TextEditingController();
  DropdownDriveModel? _selectedDriver;
  DropdownVehicleModel? _selectedVehicle;
  List<DropdownCustomerModel> _selectedCustomers = [];
  late final SubmitPerjalananBloc submitPerjalananBloc;

  late final ApiHelper apiHelper;
  late final CekGoogleService cekGoogleService;

  _SearchPageState() {
    apiHelper = ApiHelperImpl(dio: Dio());
    cekGoogleService = CekGoogleService(apiHelper: apiHelper);
    submitPerjalananBloc = SubmitPerjalananBloc(
        submitPerjalananService: SubmitPerjalananService(apiHelper: apiHelper));
  }

  void showLoadingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return LoadingDialog();
      },
    );
  }

  Future<void> someAsyncOperation(BuildContext context) async {
    showLoadingDialog(context);

    try {
      // Simulate a delay for the async operation
      await Future.delayed(Duration(seconds: 3));
      // Perform your async operations here

      // Close the dialog after the operation
      Navigator.of(context).pop();
    } catch (error) {
      // Handle errors
      Navigator.of(context).pop();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $error')),
      );
    }
  }

  void _addCustomerDropdown() {
    setState(() {
      _selectedCustomers.add(
        DropdownCustomerModel(
          kontakID: UniqueKey().toString(),
          displayName: '',
          type: '',
          latitude: '',
          lokasi: '',
          longitude: '',
          nomorFaktur: '',
          urutanPengiriman: 0,
        ),
      );
    });
  }

  void _removeCustomerDropdown(DropdownCustomerModel customer) {
    setState(() {
      _selectedCustomers.remove(customer);
    });
  }

  Widget _buildCustomerDropdown(DropdownCustomerModel customer) {
    return Column(
      key: ValueKey(customer.kontakID),
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              flex: 4,
              child: DropdownCustomer(
                onDetailsEntered: (newDetails) {},
                onCustomerSelected: (selectedCustomer) {
                  setState(() {
                    int index = _selectedCustomers.indexOf(customer);
                    _selectedCustomers[index] = selectedCustomer;
                  });
                },
                selectedCustomer: customer,
              ),
            ),
            SizedBox(width: 4),
            Align(
              alignment: Alignment.centerLeft,
              child: ElevatedButton(
                onPressed: () => _removeCustomerDropdown(customer),
                style: ElevatedButton.styleFrom(
                  foregroundColor: CustomColorPalette.buttonTextColor,
                  backgroundColor: CustomColorPalette.buttonColor,
                ),
                child: const Icon(Icons.remove),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _submitData(BuildContext context) async {
    try {
      if (_selectedCustomers.isNotEmpty && _selectedDriver != null) {
        // Generate Google Maps URL
        String maps = '';
        for (int i = 0; i < _selectedCustomers.length; i++) {
          final customer = _selectedCustomers[i];
          maps += '/${customer.latitude},${customer.longitude}';
        }
        maps = maps.replaceAll(' ', '');
        String googleMapsUrl = 'https://www.google.com/maps/dir' + maps;

        // Show loading dialog
        showLoadingDialog(context);

        // Call the API to get minDistance and minDuration
        final cekGoogleResult = await cekGoogleService.cekGoogle(
            _selectedCustomers, _selectedDriver!);

        // Create Kontak objects from API result
        final kontaks = cekGoogleResult.kontaks.map((customer) {
          return Kontak(
            displayName: customer.displayName,
            kontakID: customer.kontakID,
            type: customer.type,
            urutanPengiriman: customer.urutanPengiriman,
            latitude: customer.latitude,
            lokasi: customer.lokasi,
            longitude: customer.longitude,
            nomorFaktur: int.tryParse(customer.nomorFaktur) ?? 0,
          );
        }).toList();

        // Create SubmitPengantaranModel object with API response
        final submitPengantaranModel = SubmitPerjalananModel(
          googleMapsUrl: googleMapsUrl,
          shiftKe: int.parse(_shiftController.text),
          jamPengiriman: _jamPengirimanController.text,
          jamKembali: _jamKembaliController.text,
          driverId: _selectedDriver!.karyawanID ?? 0,
          namaDriver: _selectedDriver!.nama ?? '',
          tipeKendaraan: _selectedVehicle!.tipe,
          nomorPolisiKendaraan: _selectedVehicle!.nomorPolisi,
          createdBy: _agentController.text,
          kontaks: kontaks,
          minDistance: cekGoogleResult.minDistance,
          minDuration: cekGoogleResult.minDuration,
        );

        // Close loading dialog
        Navigator.of(context).pop();

        // Submit detailPengantaran to Bloc with waktuPesanan
        submitPerjalananBloc.add(SubmitPerjalanan(
          submitPerjalananModel: submitPengantaranModel,
        ));
      } else {
        throw FormatException("Selected customers or driver is invalid");
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => submitPerjalananBloc,
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            'Diantar Jarak',
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Color(0xFF363535),
            ),
          ),
          centerTitle: true,
          backgroundColor: CustomColorPalette.backgroundColor,
          actions: [
            IconButton(
              icon: Icon(Icons.history,
                  color: CustomColorPalette.buttonColor, size: 30),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HistoryPerjalananPage()));
              },
            ),
            SizedBox(width: 4),
          ],
        ),
        body: BlocListener<SubmitPerjalananBloc, SubmitPerjalananState>(
          listener: (context, state) {
            if (state is PerjalananSubmitted) {
              Navigator.of(context).pop(); // Close the loading dialog
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SubmitResultPage(
                    submitPengantaranModel: state.detailPerjalanan,
                  ),
                ),
              );
            } else if (state is SubmitPerjalananError) {
              Navigator.of(context).pop(); // Close the loading dialog
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: ${state.message}')),
              );
            }
          },
          child: Padding(
            padding: EdgeInsets.all(16),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: 300,
                      right: 300,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      DropdownAgent(
                                        controller: _agentController,
                                        onAgentSelected: (agent) {
                                          setState(() {
                                            // Handle agent selected
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 12),
                                      DropdownDriver(
                                        controller: _driverController,
                                        onPositionSelected: (position) {
                                          setState(() {
                                            // Handle position selected
                                          });
                                        },
                                        onDriverSelected: (driver) {
                                          setState(() {
                                            _selectedDriver = driver;
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 12),
                                      DropdownShift(
                                        controller: _shiftController,
                                        onShiftSelected: (shift) {
                                          setState(() {
                                            // Handle shift selected
                                          });
                                        },
                                      ),
                                      const SizedBox(height: 12),
                                      DropdownTipeKendaraan(
                                        vehicleTypeController:
                                            _tipeKendaraanController,
                                        plateNumberController:
                                            _nomorPolisiKendaraanController,
                                        onTipeSelected: (tipe) {
                                          setState(() {
                                            _selectedVehicle =
                                                DropdownVehicleModel(
                                              tipe:
                                                  _tipeKendaraanController.text,
                                              nomorPolisi:
                                                  _nomorPolisiKendaraanController
                                                      .text,
                                            );
                                          });
                                        },
                                        selectedDriver: _selectedDriver,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: Sizes.dp3(context)),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ElevatedButton(
                                  onPressed: _addCustomerDropdown,
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor:
                                        CustomColorPalette.buttonTextColor,
                                    backgroundColor:
                                        CustomColorPalette.buttonColor,
                                  ),
                                  child: const Icon(Icons.add),
                                ),
                              ),
                              SizedBox(height: 4),
                              Expanded(
                                child: SingleChildScrollView(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children:
                                        _selectedCustomers.map((customer) {
                                      return _buildCustomerDropdown(customer);
                                    }).toList(),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 20),
                              if (_selectedCustomers.isNotEmpty &&
                                  _selectedDriver != null)
                                Expanded(
                                  child: ContainerCekGoogle(
                                    key: UniqueKey(),
                                    selectedCustomers: _selectedCustomers,
                                    selectedDriver: _selectedDriver!,
                                    cekGoogleService: cekGoogleService,
                                  ),
                                ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => _submitData(context),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: CustomColorPalette.buttonTextColor,
                    backgroundColor: CustomColorPalette.buttonColor,
                  ),
                  child: const Text('Submit'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
