import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:diantar_jarak/theme/theme.dart';

class DropdownShift extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onShiftSelected;

  const DropdownShift({
    Key? key,
    required this.controller,
    required this.onShiftSelected,
  }) : super(key: key);

  @override
  _DropdownShiftState createState() => _DropdownShiftState();
}

class _DropdownShiftState extends State<DropdownShift> {
  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<String>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: 'Shift',
          labelStyle: TextStyle(fontSize: 14),
          hintText: 'Masukkan Shift',
          hintStyle:
              TextStyle(color: CustomColorPalette.hintTextColor, fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          filled: true,
          fillColor: CustomColorPalette.surfaceColor,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          isDense: true,
        ),
        style: TextStyle(fontSize: 14),
      ),
      suggestionsCallback: (pattern) async {
        await Future.delayed(const Duration(milliseconds: 500));
        return ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10', '11', '12']
            .where(
                (shift) => shift.toLowerCase().contains(pattern.toLowerCase()))
            .toList();
      },
      itemBuilder: (context, String suggestion) {
        return ListTile(
          title: Text(suggestion, style: TextStyle(fontSize: 14)),
        );
      },
      onSuggestionSelected: (String suggestion) {
        setState(() {
          widget.controller.text = suggestion;
          widget.onShiftSelected(suggestion);
        });
      },
      noItemsFoundBuilder: (context) => Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Shift Tidak Ditemukan',
            style:
                TextStyle(color: CustomColorPalette.textColor, fontSize: 14)),
      ),
    );
  }
}
