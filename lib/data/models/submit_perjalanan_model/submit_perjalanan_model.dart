import 'package:diantar_jarak/util/format_date.dart';
import 'package:equatable/equatable.dart';

class Kontak extends Equatable {
  final String displayName;
  final String kontakID;
  final String? type;
  final int urutanPengiriman;
  final String latitude;
  final String lokasi;
  final String longitude;
  final int nomorFaktur;

  Kontak({
    required this.displayName,
    required this.kontakID,
    this.type,
    required this.urutanPengiriman,
    required this.latitude,
    required this.lokasi,
    required this.longitude,
    required this.nomorFaktur,
  });

  factory Kontak.fromJson(Map<String, dynamic> json) {
    return Kontak(
      displayName: json['DisplayName'],
      kontakID: json['KontakID'],
      type: json['Type'],
      urutanPengiriman: json['urutan_pengiriman'],
      latitude: json['latitude'],
      lokasi: json['lokasi'],
      longitude: json['longitude'],
      nomorFaktur: json['nomor_faktur'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DisplayName': displayName,
      'KontakID': kontakID,
      'Type': type,
      'urutan_pengiriman': urutanPengiriman,
      'latitude': latitude,
      'lokasi': lokasi,
      'longitude': longitude,
      'nomor_faktur': nomorFaktur,
    };
  }

  @override
  List<Object?> get props => [kontakID];
}

class SubmitPerjalananModel extends Equatable {
  final String googleMapsUrl;
  final int shiftKe;
  final String? jamPengiriman;
  final String? jamKembali;
  final int driverId;
  final String namaDriver;
  final String tipeKendaraan;
  final String nomorPolisiKendaraan;
  final String createdBy;
  final List<Kontak> kontaks;
  final double minDistance;
  final double minDuration;

  SubmitPerjalananModel({
    required this.googleMapsUrl,
    required this.shiftKe,
    this.jamPengiriman,
    this.jamKembali,
    required this.driverId,
    required this.namaDriver,
    required this.tipeKendaraan,
    required this.nomorPolisiKendaraan,
    required this.createdBy,
    required this.kontaks,
    required this.minDistance,
    required this.minDuration,
  });

  factory SubmitPerjalananModel.fromJson(Map<String, dynamic> json) {
    var kontaksJson = json['kontaks'] as List;
    List<Kontak> kontaksList =
        kontaksJson.map((i) => Kontak.fromJson(i)).toList();

    return SubmitPerjalananModel(
      googleMapsUrl: json['google_maps_url'],
      shiftKe: json['shift_ke'],
      jamKembali: formatDisplayDate(json['jam_kembali']),
      jamPengiriman: formatDisplayDate(json['jam_pengiriman']),
      driverId: json['driver_id'],
      namaDriver: json['nama_driver'],
      tipeKendaraan: json['tipe_kendaraan'],
      nomorPolisiKendaraan: json['nomor_polisi_kendaraan'],
      createdBy: json['created_by'],
      kontaks: kontaksList,
      minDistance: json['min_distance'],
      minDuration: json['min_duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'google_maps_url': googleMapsUrl,
      'shift_ke': shiftKe,
      'jam_pengiriman': jamPengiriman,
      'jam_kembali': jamKembali,
      'driver_id': driverId,
      'nama_driver': namaDriver,
      'tipe_kendaraan': tipeKendaraan,
      'nomor_polisi_kendaraan': nomorPolisiKendaraan,
      'created_by': createdBy,
      'kontaks': kontaks.map((k) => k.toJson()).toList(),
      'min_distance': minDistance,
      'min_duration': minDuration,
    };
  }

  @override
  List<Object?> get props => [googleMapsUrl];
}
