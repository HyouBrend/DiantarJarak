import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_driver_bloc/dropdown_driver_bloc.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_driver_bloc/dropdown_driver_event.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_driver_bloc/dropdown_driver_state.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_drive_model.dart';
import 'package:diantar_jarak/util/size.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/util/capitalize_word.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class DropdownDriver extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onPositionSelected;
  final Function(DropdownDriveModel) onDriverSelected;

  const DropdownDriver({
    super.key,
    required this.controller,
    required this.onPositionSelected,
    required this.onDriverSelected,
  });

  @override
  _DropdownDriverState createState() => _DropdownDriverState();
}

class _DropdownDriverState extends State<DropdownDriver> {
  DropdownDriveModel? selectedDriver;
  bool _isLoading = false; // Variabel state untuk mengelola loading

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          width: Sizes.dp94(context),
          child: BlocListener<DriverBloc, DriverState>(
            listener: (context, state) {
              if (state is DriverLoading) {
                setState(() {
                  _isLoading = true;
                });
              } else {
                setState(() {
                  _isLoading = false;
                });
              }
            },
            child: TypeAheadFormField<DropdownDriveModel>(
              textFieldConfiguration: TextFieldConfiguration(
                controller: widget.controller,
                decoration: InputDecoration(
                  labelText: 'Driver',
                  hintText: 'Masukkan nama driver',
                  labelStyle: TextStyle(fontSize: 14),
                  hintStyle: TextStyle(
                      color: CustomColorPalette.hintTextColor, fontSize: 14),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  filled: true,
                  fillColor: CustomColorPalette.surfaceColor,
                  contentPadding:
                      EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  isDense: true, // Mengurangi tinggi TextField
                ),
                style: TextStyle(fontSize: 14),
              ),
              suggestionsCallback: (pattern) async {
                context.read<DriverBloc>().add(FetchDrivers(query: pattern));
                final state =
                    await context.read<DriverBloc>().stream.firstWhere(
                          (state) => state is! DriverLoading,
                        );

                if (state is DriverHasData) {
                  return state.drivers.where((driver) => driver.nama!
                      .toLowerCase()
                      .contains(pattern.toLowerCase()));
                }
                return [];
              },
              itemBuilder: (context, DropdownDriveModel suggestion) {
                return ListTile(
                  title: Text(capitalizeWords(suggestion.nama ?? ''),
                      style: TextStyle(fontSize: 14)),
                );
              },
              onSuggestionSelected: (DropdownDriveModel suggestion) {
                setState(() {
                  widget.controller.text =
                      capitalizeWords(suggestion.nama ?? '');
                  widget.onPositionSelected(suggestion.posisi ?? '');
                  selectedDriver = suggestion;
                  widget.onDriverSelected(suggestion);
                });
              },
              noItemsFoundBuilder: (context) => Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('Driver tidak ditemukan',
                    style: TextStyle(
                        color: CustomColorPalette.textColor, fontSize: 14)),
              ),
              loadingBuilder: (context) => Center(
                child: CircularProgressIndicator(),
              ),
              hideOnLoading:
                  !_isLoading, // Mengontrol visibilitas indikator loading
              suggestionsBoxDecoration: SuggestionsBoxDecoration(
                constraints: BoxConstraints(
                    maxHeight: 500), // Mengatur tinggi maksimal dropdown
              ),
            ),
          ),
        ),
      ],
    );
  }
}
