import 'package:diantar_jarak/pages/search_dropdown/search_dropdown.dart';
import 'package:diantar_jarak/theme/theme.dart';
import 'package:diantar_jarak/util/capitalize_word.dart';
import 'package:flutter/material.dart';
import 'package:diantar_jarak/data/models/submit_perjalanan_model/submit_perjalanan_model.dart';
import 'package:url_launcher/url_launcher.dart';

class SubmitResultPage extends StatelessWidget {
  final SubmitPerjalananModel submitPengantaranModel;

  const SubmitResultPage({
    Key? key,
    required this.submitPengantaranModel,
  }) : super(key: key);

  Widget buildRow(String label, String? value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 250, // Set width as per your need
            child: Text(
              label,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
                color: CustomColorPalette.textColor,
              ),
            ),
          ),
          SizedBox(width: 8),
          Text(
            ":",
            style: TextStyle(
              fontSize: 18,
              color: CustomColorPalette.textColor,
            ),
          ),
          SizedBox(width: 8), // Space between label and value
          Flexible(
            fit: FlexFit.loose,
            child: Text(
              value ?? '',
              style: TextStyle(
                fontSize: 18,
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
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Detail Perjalanan',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Color(0xFF363535),
          ),
        ),
        backgroundColor: CustomColorPalette.backgroundColor,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SearchDropdown()),
            );
          },
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColorPalette.BgBorder,
                      border: Border.all(
                        color: CustomColorPalette.textColor,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(
                      left: 300,
                      right: 300,
                      bottom: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Detail Pengiriman',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF363535)),
                        ),
                        SizedBox(height: 16),
                        ListTile(
                          title: Text(
                              capitalizeWords(
                                  submitPengantaranModel.namaDriver),
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF363535))),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(height: 16),
                              buildRow('Shift',
                                  submitPengantaranModel.shiftKe.toString()),
                              buildRow('Jam Pengiriman',
                                  submitPengantaranModel.jamPengiriman ?? ''),
                              buildRow('Jam Kembali',
                                  submitPengantaranModel.jamKembali ?? ''),
                              buildRow('Tipe Kendaraan',
                                  submitPengantaranModel.tipeKendaraan),
                              buildRow('Nomor Polisi',
                                  submitPengantaranModel.nomorPolisiKendaraan),
                              buildRow('Created By',
                                  submitPengantaranModel.createdBy),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColorPalette.BgBorder,
                      border: Border.all(
                        color: CustomColorPalette.textColor,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(8.0),
                    margin: const EdgeInsets.only(
                      left: 300,
                      right: 300,
                      bottom: 10,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Detail Customers',
                          style: TextStyle(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF363535)),
                        ),
                        ...submitPengantaranModel.kontaks.map((kontak) {
                          return ListTile(
                            title: Text(
                              kontak.displayName,
                              style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF363535)),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                buildRow('Urutan Pengiriman',
                                    kontak.urutanPengiriman.toString()),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 2.0),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment
                                        .center, // Mengatur ke tengah
                                    children: [
                                      SizedBox(
                                        width: 250,
                                        child: Text(
                                          'Latitude',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 18,
                                            color: CustomColorPalette.textColor,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Text(
                                        ":",
                                        style: TextStyle(
                                          fontSize: 18,
                                          color: CustomColorPalette.textColor,
                                        ),
                                      ),
                                      SizedBox(width: 8),
                                      Flexible(
                                        child: Text(
                                          kontak.latitude.toString(),
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: CustomColorPalette.textColor,
                                          ),
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.location_on_rounded,
                                          size: 20,
                                          color: Color(0xFF8A2BE2),
                                        ),
                                        onPressed: () {
                                          if (kontak.latitude != null &&
                                              kontak.longitude != null) {
                                            launch(
                                                'https://www.google.com/maps/search/?api=1&query=${kontak.latitude},${kontak.longitude}');
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                ),
                                buildRow(
                                    'Longitude', kontak.longitude.toString()),
                                buildRow('Lokasi', kontak.lokasi),
                                buildRow(
                                  'Nomor Faktur',
                                  kontak.nomorFaktur.toString(),
                                ),
                                const Divider(color: Colors.purple),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: CustomColorPalette.BgBorder,
                      border: Border.all(
                        color: CustomColorPalette.textColor,
                      ),
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    padding: const EdgeInsets.all(16.0),
                    margin: const EdgeInsets.only(
                      left: 300,
                      right: 300,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          crossAxisAlignment:
                              CrossAxisAlignment.center, // Mengatur ke tengah
                          children: [
                            const Text(
                              'Google Maps',
                              style: TextStyle(
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFF363535)),
                            ),
                            IconButton(
                              icon: const Icon(
                                Icons.map_rounded,
                                size: 30,
                                color: Color(0xFF8A2BE2),
                              ),
                              onPressed: () {
                                if (submitPengantaranModel.googleMapsUrl !=
                                    null) {
                                  launch(submitPengantaranModel.googleMapsUrl!);
                                }
                              },
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(height: 16),
                                buildRow('Min Distance',
                                    '${submitPengantaranModel.minDistance.toStringAsFixed(2)} km'),
                                const SizedBox(height: 8),
                                buildRow('Min Duration',
                                    '${submitPengantaranModel.minDuration.toStringAsFixed(2)} minutes'),
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
