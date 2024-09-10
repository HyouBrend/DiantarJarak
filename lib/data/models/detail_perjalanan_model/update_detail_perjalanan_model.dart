class UpdateDetailPerjalananModel {
  final String perjalananID;
  final int shiftKe;
  final String jamPengiriman;
  final String? jamKembali;
  final String updateBy;
  final String status;

  UpdateDetailPerjalananModel({
    required this.perjalananID,
    required this.shiftKe,
    required this.jamPengiriman,
    this.jamKembali,
    required this.updateBy,
    required this.status,
  });

  Map<String, dynamic> toJson() {
    return {
      'perjalanan_id': perjalananID,
      'shift_ke': shiftKe,
      'jam_pengiriman': jamPengiriman,
      'jam_kembali': jamKembali,
      'update_by': updateBy,
      'status': status,
    };
  }
}
