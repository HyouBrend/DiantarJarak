import 'package:diantar_jarak/util/format_date.dart';

class HistoryPerjalananModel {
  final String createdBy;
  final String jamPengiriman;
  final String jamKembali;
  final double minDurasiPengiriman;
  final double minJarakPengiriman;
  final String namaDriver;
  final String nomorPolisiKendaraan;
  final String perjalananId;
  final int shiftKe;
  final String status;
  final String tipeKendaraan;

  HistoryPerjalananModel({
    required this.createdBy,
    required this.jamKembali,
    required this.jamPengiriman,
    required this.minDurasiPengiriman,
    required this.minJarakPengiriman,
    required this.namaDriver,
    required this.nomorPolisiKendaraan,
    required this.perjalananId,
    required this.shiftKe,
    required this.status,
    required this.tipeKendaraan,
  });

  factory HistoryPerjalananModel.fromJson(Map<String, dynamic> json) {
    return HistoryPerjalananModel(
      createdBy: json['createdBy'] ?? '',
      jamKembali: formatTimeBakAndSend(json['jam_kembali']) ?? '',
      jamPengiriman: formatTimeBakAndSend(json['jam_pengiriman']) ?? '',
      minJarakPengiriman: (json['min_jarak_pengiriman'] is String)
          ? double.parse(json['min_jarak_pengiriman'])
          : json['min_jarak_pengiriman'] ?? 0.0,
      minDurasiPengiriman: (json['min_durasi_pengiriman'] is String)
          ? double.parse(json['min_durasi_pengiriman'])
          : json['min_durasi_pengiriman'] ?? 0.0,
      namaDriver: json['nama_driver'] ?? '',
      nomorPolisiKendaraan: json['nomor_polisi_kendaraan'] ?? '',
      perjalananId: json['perjalanan_id'] ?? '',
      shiftKe: json['shift_ke'] ?? 0,
      status: json['status'] ?? '',
      tipeKendaraan: json['tipe_kendaraan'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'createdBy': createdBy,
      'jam_kembali': jamKembali,
      'jam_pengiriman': jamPengiriman,
      'min_durasi_pengiriman': minDurasiPengiriman.toString(),
      'min_jarak_pengiriman': minJarakPengiriman.toString(),
      'nama_driver': namaDriver,
      'nomor_polisi_kendaraan': nomorPolisiKendaraan,
      'perjalanan_id': perjalananId,
      'shift_ke': shiftKe,
      'status': status,
      'tipe_kendaraan': tipeKendaraan,
    };
  }
}

class HistoryPerjalananModelData {
  final List<HistoryPerjalananModel> data;

  HistoryPerjalananModelData({required this.data});

  factory HistoryPerjalananModelData.fromJson(Map<String, dynamic> json) {
    return HistoryPerjalananModelData(
      data: (json['data'] as List)
          .map((item) => HistoryPerjalananModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data.map((item) => item.toJson()).toList(),
    };
  }
}
