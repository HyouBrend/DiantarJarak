import 'package:diantar_jarak/data/models/search_dropdown_model/dropdown_customer_model.dart';

class CekGoogleResult {
  final String googleMapsUrl;
  final List<DropdownCustomerModel> kontaks;
  final double minDistance;
  final double minDuration;

  CekGoogleResult({
    required this.googleMapsUrl,
    required this.kontaks,
    required this.minDistance,
    required this.minDuration,
  });

  factory CekGoogleResult.fromJson(Map<String, dynamic> json) {
    return CekGoogleResult(
      googleMapsUrl: json['data']['google_maps_url'],
      kontaks: (json['data']['kontaks'] as List<dynamic>)
          .map((item) => DropdownCustomerModel.fromJson(item))
          .toList(),
      minDistance: json['data']['min_distance'],
      minDuration: json['data']['min_duration'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'data': {
        'google_maps_url': googleMapsUrl,
        'kontaks': kontaks.map((item) => item.toJson()).toList(),
        'min_distance': minDistance,
        'min_duration': minDuration,
      },
    };
  }
}
