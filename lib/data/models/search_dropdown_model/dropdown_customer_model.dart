import 'package:equatable/equatable.dart';
import 'package:collection/collection.dart';

class DropdownCustomerModel extends Equatable {
  final String displayName;
  final String kontakID;
  final String? type;
  final String latitude;
  final String lokasi;
  final String longitude;
  final String nomorFaktur;
  final int urutanPengiriman;

  DropdownCustomerModel({
    required this.displayName,
    required this.kontakID,
    this.type,
    required this.latitude,
    required this.lokasi,
    required this.longitude,
    required this.nomorFaktur,
    required this.urutanPengiriman,
  });

  factory DropdownCustomerModel.fromJson(Map<String, dynamic> json) {
    return DropdownCustomerModel(
      displayName: json['DisplayName'] ?? '',
      kontakID: json['KontakID'] ?? '',
      type: json['Type'],
      latitude: json['latitude'] ?? '',
      lokasi: json['lokasi'] ?? '',
      longitude: json['longitude'] ?? '',
      nomorFaktur: json['nomor_faktur'],
      urutanPengiriman: json['urutan_pengiriman'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'DisplayName': displayName,
      'KontakID': kontakID,
      'Type': type,
      'latitude': latitude,
      'lokasi': lokasi,
      'longitude': longitude,
      'nomor_faktur': nomorFaktur,
      'urutan_pengiriman': urutanPengiriman,
    };
  }

  @override
  List<Object?> get props => [
        displayName,
        kontakID,
        type,
        latitude,
        lokasi,
        longitude,
        nomorFaktur,
        urutanPengiriman,
      ];
}

class CustomerData {
  final List<DropdownCustomerModel>? data;

  CustomerData({this.data});

  factory CustomerData.fromJson(Map<String, dynamic> json) {
    return CustomerData(
      data: (json['data'] as List<dynamic>?)
          ?.map((item) => DropdownCustomerModel.fromJson(item))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': data?.map((item) => item.toJson()).toList(),
    };
  }

  @override
  String toString() {
    return 'CustomerData(data: $data)';
  }

  @override
  bool operator ==(covariant CustomerData other) {
    if (identical(this, other)) return true;
    final listEquals = const DeepCollectionEquality().equals;
    return listEquals(other.data, data);
  }

  @override
  int get hashCode {
    return data.hashCode;
  }
}
