import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/util/capitalize_word.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_drive_model.dart';
import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_customer_model.dart';
import 'package:diantar_jarak/data/service/search_dropdown_service/cek_google_service.dart';
import 'package:url_launcher/url_launcher.dart';

class ContainerCekGoogle extends StatelessWidget {
  final List<DropdownCustomerModel> selectedCustomers;
  final DropdownDriveModel selectedDriver;
  final CekGoogleService cekGoogleService;

  ContainerCekGoogle({
    Key? key,
    required this.selectedCustomers,
    required this.selectedDriver,
    required this.cekGoogleService,
  }) : super(key: key);

  void _openGoogleMaps(BuildContext context) async {
    try {
      if (selectedCustomers.isNotEmpty) {
        final result =
            await cekGoogleService.cekGoogle(selectedCustomers, selectedDriver);

        String googleMapsUrl = result.googleMapsUrl;
        if (await canLaunch(googleMapsUrl)) {
          await launch(
            googleMapsUrl,
            forceSafariVC: false,
            forceWebView: false,
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Could not launch $googleMapsUrl')),
          );
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error: $e')),
      );
    }
  }

  Widget buildRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        children: [
          Container(
            width: 150, // Set width as per your need
            child: Text(
              label,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: CustomColorPalette.textColor),
            ),
          ),
          SizedBox(
            width: 8,
          ),
          Container(
            child: Text(
              ":",
              style:
                  TextStyle(fontSize: 16, color: CustomColorPalette.textColor),
            ),
          ),
          SizedBox(width: 8), // Space between label and value
          Flexible(
            child: Text(
              value,
              style:
                  TextStyle(fontSize: 16, color: CustomColorPalette.textColor),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: cekGoogleService.cekGoogle(selectedCustomers, selectedDriver),
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final result = snapshot.data;
          final sortedCustomers = result.kontaks;

          return SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.all(8.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: CustomColorPalette.BgBorder,
                border: Border.all(
                  color: CustomColorPalette.textColor,
                ),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Driver',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  buildRow('Nama', capitalizeWords(selectedDriver.nama!)),
                  const SizedBox(height: 20),
                  Text(
                    'List Customer',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 28,
                    ),
                  ),
                  const SizedBox(height: 8),
                  ...sortedCustomers.map((customer) {
                    return Column(
                      key: ValueKey(customer.kontakID), // Ensure unique key
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        buildRow('Nama', customer.displayName),
                        buildRow('Alamat', customer.lokasi),
                        buildRow('Urutan Pengiriman',
                            customer.urutanPengiriman.toString()),
                        const Divider(color: Colors.purple),
                      ],
                    );
                  }).toList(),
                  const SizedBox(height: 8),
                  buildRow('Min Distance',
                      '${result.minDistance.toStringAsFixed(2)} km'),
                  buildRow('Min Duration',
                      '${result.minDuration.toStringAsFixed(2)} minutes'),
                  const SizedBox(height: 16),
                  Center(
                    child: ElevatedButton(
                      onPressed: () => _openGoogleMaps(context),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: CustomColorPalette.buttonTextColor,
                        backgroundColor: CustomColorPalette.buttonColor,
                      ),
                      child: Text('Cek Maps'),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          );
        }
        return Center(child: Text('No data available'));
      },
    );
  }
}
