import 'package:diantar_jarak/util/capitalize_word.dart';
import 'package:diantar_jarak/util/size.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_drive_model.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class DropdownTipeKendaraan extends StatefulWidget {
  final TextEditingController vehicleTypeController;
  final TextEditingController plateNumberController;
  final Function(DropdownVehicleModel) onTipeSelected;
  final DropdownDriveModel? selectedDriver;

  const DropdownTipeKendaraan({
    Key? key,
    required this.vehicleTypeController,
    required this.plateNumberController,
    required this.onTipeSelected,
    this.selectedDriver,
  }) : super(key: key);

  @override
  _DropdownTipeKendaraanState createState() => _DropdownTipeKendaraanState();
}

class _DropdownTipeKendaraanState extends State<DropdownTipeKendaraan> {
  final Map<String, List<String>> _platNomorByTipeKendaraan = {
    'Pick Up': [
      'B9809BAY',
      'B9028JAC',
      'B9029CAK',
      'B9405BAT',
      'B9785BAX',
      'B9869BAU'
    ],
    'Roda 3': ['B6372JYA', 'B4997KYE'],
    'Truck': ['B9434BCQ']
  };

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Container(
            width: 100, // Set width as per your need
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: CustomColorPalette.textColor,
              ),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            child: Text(
              ":",
              style: TextStyle(
                fontSize: 16,
                color: CustomColorPalette.textColor,
              ),
            ),
          ),
          SizedBox(width: 8), // Space between label and value
          Flexible(
            child: Text(
              value,
              style: TextStyle(
                fontSize: 16,
                color: CustomColorPalette.textColor,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TypeAheadFormField<String>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: widget.vehicleTypeController,
                  decoration: InputDecoration(
                    labelText: 'Tipe Kendaraan',
                    labelStyle: TextStyle(fontSize: 14),
                    hintText: 'Masukkan tipe kendaraan',
                    hintStyle: TextStyle(
                        color: CustomColorPalette.hintTextColor, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    filled: true,
                    fillColor: CustomColorPalette.surfaceColor,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    isDense: true,
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                suggestionsCallback: (pattern) async {
                  await Future.delayed(const Duration(milliseconds: 500));
                  return ['Pick Up', 'Roda 3', 'Truck']
                      .where((tipe) =>
                          tipe.toLowerCase().contains(pattern.toLowerCase()))
                      .toList();
                },
                itemBuilder: (context, String suggestion) {
                  return ListTile(
                    title: Text(suggestion, style: TextStyle(fontSize: 14)),
                  );
                },
                onSuggestionSelected: (String suggestion) {
                  setState(() {
                    widget.vehicleTypeController.text = suggestion;
                    widget.onTipeSelected(
                      DropdownVehicleModel(
                        tipe: suggestion,
                        nomorPolisi: widget.plateNumberController.text,
                      ),
                    );
                    widget.plateNumberController.clear();
                  });
                },
                noItemsFoundBuilder: (context) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Tidak ada tipe kendaraan ditemukan',
                      style: TextStyle(
                          color: CustomColorPalette.textColor, fontSize: 14)),
                ),
              ),
            ),
            SizedBox(width: 12),
            Expanded(
              child: TypeAheadFormField<String>(
                textFieldConfiguration: TextFieldConfiguration(
                  controller: widget.plateNumberController,
                  decoration: InputDecoration(
                    labelText: 'Nomor Plat',
                    labelStyle: TextStyle(fontSize: 14),
                    hintText: 'Masukkan nomor plat',
                    hintStyle: TextStyle(
                        color: CustomColorPalette.hintTextColor, fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    filled: true,
                    fillColor: CustomColorPalette.surfaceColor,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    isDense: true,
                  ),
                  style: TextStyle(fontSize: 14),
                ),
                suggestionsCallback: (pattern) async {
                  final tipe = widget.vehicleTypeController.text;
                  final platNomor = _platNomorByTipeKendaraan[tipe] ?? [];
                  await Future.delayed(const Duration(milliseconds: 500));
                  return platNomor
                      .where((plat) =>
                          plat.toLowerCase().contains(pattern.toLowerCase()))
                      .toList();
                },
                itemBuilder: (context, String suggestion) {
                  return ListTile(
                    title: Text(suggestion, style: TextStyle(fontSize: 14)),
                  );
                },
                onSuggestionSelected: (String suggestion) {
                  setState(() {
                    widget.plateNumberController.text = suggestion;
                    widget.onTipeSelected(
                      DropdownVehicleModel(
                        tipe: widget.vehicleTypeController.text,
                        nomorPolisi: suggestion,
                      ),
                    );
                  });
                },
                noItemsFoundBuilder: (context) => Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Tidak ada nomor plat ditemukan',
                      style: TextStyle(
                          color: CustomColorPalette.textColor, fontSize: 14)),
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 12),
        if (widget.selectedDriver != null)
          IntrinsicHeight(
            child: IntrinsicWidth(
              child: Container(
                decoration: BoxDecoration(
                  color: CustomColorPalette.BgBorder,
                  border: Border.all(color: CustomColorPalette.textColor),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                padding: EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: CustomColorPalette.textColor, width: 1),
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10.0),
                        child: Image.asset(
                          'assets/${widget.selectedDriver?.nama}.jpeg',
                          height: 600,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Column(
                      children: [
                        buildRow(
                            'Nama',
                            widget.selectedDriver?.nama != null
                                ? capitalizeWords(widget.selectedDriver!.nama!)
                                : ''),
                        buildRow(
                            'No. Telepon', widget.selectedDriver?.noHP ?? ''),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class DropdownVehicleModel {
  final String tipe;
  final String nomorPolisi;

  DropdownVehicleModel({
    required this.tipe,
    required this.nomorPolisi,
  });

  Map<String, dynamic> toJson() {
    return {
      'tipe': tipe,
      'nomorPolisi': nomorPolisi,
    };
  }
}
