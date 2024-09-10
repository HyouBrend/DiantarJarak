import 'package:diantar_jarak/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

class DropdownAgent extends StatefulWidget {
  final TextEditingController controller;
  final Function(String) onAgentSelected;

  const DropdownAgent({
    Key? key,
    required this.controller,
    required this.onAgentSelected,
  }) : super(key: key);

  @override
  _DropdownAgentState createState() => _DropdownAgentState();
}

class _DropdownAgentState extends State<DropdownAgent> {
  @override
  Widget build(BuildContext context) {
    return TypeAheadFormField<String>(
      textFieldConfiguration: TextFieldConfiguration(
        controller: widget.controller,
        decoration: InputDecoration(
          labelText: 'Checker',
          labelStyle: TextStyle(fontSize: 14),
          hintText: 'Masukkan Checker',
          hintStyle:
              TextStyle(color: CustomColorPalette.hintTextColor, fontSize: 14),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          filled: true,
          fillColor: CustomColorPalette.surfaceColor,
          contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
          isDense: true, // Reduces the height of the TextField
        ),
        style: TextStyle(fontSize: 14),
      ),
      suggestionsCallback: (pattern) async {
        await Future.delayed(const Duration(milliseconds: 500));
        return [
          'Dita',
          'Dona',
          'Gita',
          'Linda',
          'Richard',
        ]
            .where(
                (agent) => agent.toLowerCase().contains(pattern.toLowerCase()))
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
          widget.onAgentSelected(suggestion);
        });
      },
      noItemsFoundBuilder: (context) => Padding(
        padding: EdgeInsets.all(8.0),
        child: Text('Checker Tidak Ditemukan',
            style:
                TextStyle(color: CustomColorPalette.textColor, fontSize: 14)),
      ),
    );
  }
}
