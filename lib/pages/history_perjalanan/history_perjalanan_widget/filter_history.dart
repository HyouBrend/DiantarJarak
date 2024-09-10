import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_driver_bloc/dropdown_driver_event.dart';
import 'package:diantar_jarak/util/capitalize_word.dart';
import 'package:diantar_jarak/util/size.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_bloc.dart';
import 'package:diantar_jarak/bloc/history_perjalanan_bloc/history_perjalanan/history_perjalanan_event.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_driver_bloc/dropdown_driver_bloc.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_driver_bloc/dropdown_driver_state.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_drive_model.dart';
import 'package:diantar_jarak/theme/theme.dart';

class FilterHistory extends StatefulWidget {
  @override
  _FilterHistoryState createState() => _FilterHistoryState();
}

class _FilterHistoryState extends State<FilterHistory> {
  String? selectedDriver;
  String? selectedChecker;
  String? selectedStatus;
  String? selectedTimeline;

  List<DropdownDriveModel> driverList = [];

  @override
  void initState() {
    super.initState();
    context.read<DriverBloc>().add(FetchDrivers());
  }

  InputDecoration getInputDecoration(String labelText,
      {bool hasValue = false}) {
    return InputDecoration(
      labelText: labelText,
      labelStyle: TextStyle(fontSize: 14),
      hintStyle:
          TextStyle(color: CustomColorPalette.hintTextColor, fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(10.0)),
      ),
      filled: true,
      fillColor: CustomColorPalette.surfaceColor,
      contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      isDense: true,
      suffixIcon: hasValue
          ? IconButton(
              icon: Icon(Icons.clear),
              onPressed: () {
                setState(() {
                  if (labelText == 'Nama Driver') {
                    selectedDriver = null;
                  } else if (labelText == 'Checker') {
                    selectedChecker = null;
                  } else if (labelText == 'Status') {
                    selectedStatus = null;
                  } else if (labelText == 'Timeline') {
                    selectedTimeline = null;
                  }
                });
                _applyFilters();
              },
            )
          : null,
    );
  }

  void _applyFilters() {
    context.read<HistoryPerjalananBloc>().add(
          FetchHistory(
            page: 1,
            namaDriver: selectedDriver ?? '',
            createdBy: selectedChecker ?? '',
            status: selectedStatus ?? '',
            timeline: selectedTimeline ?? '',
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Filter",
              style: TextStyle(
                color: CustomColorPalette.textColor,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: Sizes.dp1(context),
            ),
            Row(
              children: [
                SizedBox(
                  width: 150,
                  child: BlocListener<DriverBloc, DriverState>(
                    listener: (context, state) {
                      if (state is DriverHasData) {
                        setState(() {
                          driverList = state.drivers;
                        });
                      }
                    },
                    child: DropdownButtonFormField<String>(
                      decoration: getInputDecoration('Nama Driver',
                          hasValue: selectedDriver != null),
                      items: [
                        DropdownMenuItem<String>(
                          value: '',
                          child: Text('Pilih Nama Driver'),
                        ),
                        ...driverList.map((DropdownDriveModel driver) {
                          return DropdownMenuItem<String>(
                            value: driver.nama,
                            child: Text(capitalizeWords(driver.nama ?? '')),
                          );
                        }).toList(),
                      ],
                      selectedItemBuilder: (BuildContext context) {
                        return driverList.map((DropdownDriveModel driver) {
                          return Text(
                            selectedDriver != null
                                ? capitalizeWords(selectedDriver!)
                                : 'Nama Driver',
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.black,
                            ),
                          );
                        }).toList();
                      },
                      onChanged: (value) {
                        setState(() {
                          selectedDriver = value;
                        });
                        _applyFilters();
                      },
                      value: selectedDriver,
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                ),
                SizedBox(width: 8.0),
                SizedBox(
                  width: 150,
                  child: DropdownButtonFormField<String>(
                    decoration: getInputDecoration('Checker',
                        hasValue: selectedChecker != null),
                    items: [
                      DropdownMenuItem<String>(
                        value: '',
                        child: Text('Pilih Checker'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Dita',
                        child: Text('Dita'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Dona',
                        child: Text('Dona'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Gita',
                        child: Text('Gita'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Linda',
                        child: Text('Linda'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Richard',
                        child: Text('Richard'),
                      ),
                    ],
                    selectedItemBuilder: (BuildContext context) {
                      return <String>[
                        '',
                        'Dita',
                        'Dona',
                        'Gita',
                        'Linda',
                        'Richard',
                      ].map((String value) {
                        return Text(
                          selectedChecker ?? 'Checker',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        );
                      }).toList();
                    },
                    onChanged: (value) {
                      setState(() {
                        selectedChecker = value;
                      });
                      _applyFilters();
                    },
                    value: selectedChecker,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(width: 8.0),
                SizedBox(
                  width: 175,
                  child: DropdownButtonFormField<String>(
                    decoration: getInputDecoration('Status',
                        hasValue: selectedStatus != null),
                    items: [
                      DropdownMenuItem<String>(
                        value: '',
                        child: Text('Pilih Status'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Belum Dikirim',
                        child: Text('Belum Dikirim'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Sudah Dikirim',
                        child: Text('Sudah Dikirim'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Selesai',
                        child: Text('Selesai'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Tidak Dikirim',
                        child: Text('Tidak Dikirim'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Tidak Diinput',
                        child: Text('Tidak Diinput'),
                      ),
                    ],
                    selectedItemBuilder: (BuildContext context) {
                      return <String>[
                        '',
                        'Belum Dikirim',
                        'Sudah Dikirim',
                        'Selesai',
                        'Tidak Dikirim',
                        'Salah Input',
                      ].map((String value) {
                        return Text(
                          selectedStatus ?? 'Status',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        );
                      }).toList();
                    },
                    onChanged: (value) {
                      setState(() {
                        selectedStatus = value;
                      });
                      _applyFilters();
                    },
                    value: selectedStatus,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
                SizedBox(width: 8.0),
                SizedBox(
                  width: 150,
                  child: DropdownButtonFormField<String>(
                    decoration: getInputDecoration('Timeline',
                        hasValue: selectedTimeline != null),
                    items: [
                      DropdownMenuItem<String>(
                        value: '',
                        child: Text('Pilih Timeline'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Today',
                        child: Text('Today'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Yesterday',
                        child: Text('Yesterday'),
                      ),
                      DropdownMenuItem<String>(
                        value: 'Week',
                        child: Text('Week'),
                      ),
                    ],
                    selectedItemBuilder: (BuildContext context) {
                      return <String>[
                        '',
                        'Today',
                        'Yesterday',
                        'Week',
                      ].map((String value) {
                        return Text(
                          selectedTimeline ?? 'Timeline',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        );
                      }).toList();
                    },
                    onChanged: (value) {
                      setState(() {
                        selectedTimeline = value;
                      });
                      _applyFilters();
                    },
                    value: selectedTimeline,
                    style: TextStyle(fontSize: 14),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
