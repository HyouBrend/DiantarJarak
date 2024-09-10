import 'package:diantar_jarak/util/format_date.dart';

class DetailPerjalananModel {
  final String googleMapsURL;
  final String inputLatitude;
  final String inputLongitude;
  final String kontakID;
  final String createdBy;
  final String createdDate;
  final String displayName;
  final int driverID;
  final String? jamKembali;
  final String? jamPengiriman;
  final String lokasi;
  final double minDurasiPengiriman;
  final double minJarakPengiriman;
  final String namaDriver;
  final String noHp;
  final int nomorFaktur;
  final String nomorPolisiKendaraan;
  final int pengantaranID;
  final String perjalananID;
  final String posisi;
  final int shiftKe;
  final String tipeKendaraan;
  final String updateAt;
  final String updateBy;
  final int urutanPengiriman;
  final String status;

  DetailPerjalananModel({
    required this.googleMapsURL,
    required this.inputLatitude,
    required this.inputLongitude,
    required this.kontakID,
    required this.createdBy,
    required this.createdDate,
    required this.displayName,
    required this.driverID,
    this.jamKembali,
    this.jamPengiriman,
    required this.lokasi,
    required this.minDurasiPengiriman,
    required this.minJarakPengiriman,
    required this.namaDriver,
    required this.noHp,
    required this.nomorFaktur,
    required this.nomorPolisiKendaraan,
    required this.pengantaranID,
    required this.perjalananID,
    required this.posisi,
    required this.shiftKe,
    required this.tipeKendaraan,
    required this.updateAt,
    required this.updateBy,
    required this.urutanPengiriman,
    required this.status,
  });

  factory DetailPerjalananModel.fromJson(Map<String, dynamic> json) {
    return DetailPerjalananModel(
      googleMapsURL: json['GoogleMapsURL'],
      inputLatitude: json['Input_latitude'],
      inputLongitude: json['Input_longitude'],
      kontakID: json['KontakID'],
      createdBy: json['created_by'],
      createdDate: formatDisplayDate(json['created_date']) ?? '',
      displayName: json['display_name'],
      driverID: json['driver_id'],
      jamKembali: formatTimeBakAndSend(json['jam_kembali']),
      jamPengiriman: formatTimeBakAndSend(json['jam_pengiriman']),
      lokasi: json['lokasi'],
      minDurasiPengiriman:
          double.tryParse(json['min_durasi_pengiriman'].toString()) ?? 0.0,
      minJarakPengiriman:
          double.tryParse(json['min_jarak_pengiriman'].toString()) ?? 0.0,
      namaDriver: json['nama_driver'],
      noHp: json['no_hp'],
      nomorFaktur: json['nomor_faktur'],
      nomorPolisiKendaraan: json['nomor_polisi_kendaraan'],
      pengantaranID: json['pengantaran_id'],
      perjalananID: json['perjalanan_id'],
      posisi: json['posisi'],
      shiftKe: json['shift_ke'],
      tipeKendaraan: json['tipe_kendaraan'],
      updateAt: formatDisplayDate(json['update_at']) ?? '',
      updateBy: json['update_by'],
      urutanPengiriman: json['urutan_pengiriman'],
      status: json['status'],
    );
  }
}
