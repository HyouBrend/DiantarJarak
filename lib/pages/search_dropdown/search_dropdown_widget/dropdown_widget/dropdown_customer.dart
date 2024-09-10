import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_customer_bloc/dropdown_customer_bloc.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_customer_bloc/dropdown_customer_event.dart';
import 'package:diantar_jarak/bloc/search_dropdown_bloc/dropdown_customer_bloc/dropdown_customer_state.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_customer_model.dart';
import 'package:diantar_jarak/util/size.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:url_launcher/url_launcher.dart';

class DropdownCustomer extends StatefulWidget {
  final Function(Map<String, String>) onDetailsEntered;
  final Function(DropdownCustomerModel) onCustomerSelected;
  final DropdownCustomerModel? selectedCustomer;

  const DropdownCustomer({
    super.key,
    required this.onDetailsEntered,
    required this.onCustomerSelected,
    this.selectedCustomer,
  });

  @override
  _DropdownCustomerState createState() => _DropdownCustomerState();
}

class _DropdownCustomerState extends State<DropdownCustomer> {
  final TextEditingController _typeAheadController = TextEditingController();
  final TextEditingController _latitudeController = TextEditingController();
  final TextEditingController _longitudeController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.selectedCustomer != null) {
      _typeAheadController.text = widget.selectedCustomer!.displayName;
      _latitudeController.text = widget.selectedCustomer!.latitude ?? '';
      _longitudeController.text = widget.selectedCustomer!.longitude ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<CustomerBloc, CustomerState>(
      listener: (context, state) {
        if (state is CustomerLoading) {
          setState(() {
            _isLoading = true;
          });
        } else {
          setState(() {
            _isLoading = false;
          });
        }
      },
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TypeAheadFormField<DropdownCustomerModel>(
                  textFieldConfiguration: TextFieldConfiguration(
                    controller: _typeAheadController,
                    decoration: InputDecoration(
                      labelText: 'Pelanggan',
                      labelStyle: const TextStyle(fontSize: 14),
                      hintText: 'Masukkan Nama Pelanggan',
                      hintStyle: const TextStyle(fontSize: 14),
                      border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                      ),
                      filled: true,
                      fillColor: CustomColorPalette.surfaceColor,
                      contentPadding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 12),
                      isDense: true, // Mengurangi tinggi TextField
                    ),
                    style: const TextStyle(fontSize: 14),
                  ),
                  suggestionsCallback: (pattern) async {
                    context
                        .read<CustomerBloc>()
                        .add(FetchCustomers(query: pattern));
                    final state =
                        await context.read<CustomerBloc>().stream.firstWhere(
                              (state) => state is! CustomerLoading,
                            );

                    if (state is CustomerHasData) {
                      return state.customers
                          .where((customer) => customer.displayName
                              .toLowerCase()
                              .contains(pattern.toLowerCase()))
                          .take(10)
                          .toList();
                    }
                    return [];
                  },
                  itemBuilder: (context, DropdownCustomerModel suggestion) {
                    return ListTile(
                      title: Text(suggestion.displayName,
                          style: const TextStyle(fontSize: 14)),
                    );
                  },
                  onSuggestionSelected: (DropdownCustomerModel suggestion) {
                    setState(() {
                      _typeAheadController.text = suggestion.displayName;
                      _latitudeController.text = suggestion.latitude ?? '';
                      _longitudeController.text = suggestion.longitude ?? '';
                      widget.onDetailsEntered({
                        'name': suggestion.displayName,
                        'latitude': suggestion.latitude ?? '',
                        'longitude': suggestion.longitude ?? '',
                      });
                      widget.onCustomerSelected(suggestion);
                    });
                  },
                  noItemsFoundBuilder: (context) => const Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text('Pelanggan Tidak Ada',
                        style: TextStyle(fontSize: 14)),
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
              SizedBox(width: Sizes.dp4(context)),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: _latitudeController,
                  decoration: const InputDecoration(
                    labelText: 'Latitude',
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF2F2F2),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    isDense: true, // Mengurangi tinggi TextField
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(width: Sizes.dp4(context)),
              Expanded(
                flex: 1,
                child: TextFormField(
                  controller: _longitudeController,
                  decoration: const InputDecoration(
                    labelText: 'Longitude',
                    labelStyle: TextStyle(fontSize: 14),
                    hintStyle: TextStyle(fontSize: 14),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    filled: true,
                    fillColor: Color(0xFFF2F2F2),

                    contentPadding:
                        EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    isDense: true, // Mengurangi tinggi TextField
                  ),
                  style: const TextStyle(fontSize: 14),
                ),
              ),
              SizedBox(width: Sizes.dp4(context)),
              IconButton(
                icon: Icon(
                  Icons.location_on,
                  color: CustomColorPalette.buttonColor,
                  size: 30,
                ),
                onPressed: () {
                  final lat = _latitudeController.text;
                  final lon = _longitudeController.text;
                  if (lat.isNotEmpty && lon.isNotEmpty) {
                    _launchMapsUrl(lat, lon);
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content:
                            Text('Latitude dan Longitude tidak boleh kosong'),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
          if (widget.selectedCustomer != null) Container(),
        ],
      ),
    );
  }

  void _launchMapsUrl(String lat, String lon) async {
    final url = 'https://www.google.com/maps/search/?api=1&query=$lat,$lon';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
