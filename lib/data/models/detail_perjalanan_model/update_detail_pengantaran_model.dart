class UpdateDetailPengantaranModel {
  final String pengantaranID;
  final String perjalananID;
  final String nomorFaktur;
  final String updateBy;

  UpdateDetailPengantaranModel({
    required this.pengantaranID,
    required this.perjalananID,
    required this.nomorFaktur,
    required this.updateBy,
  });

  Map<String, dynamic> toJson() {
    return {
      'pengantaran_id': pengantaranID,
      'perjalanan_id': perjalananID,
      'nomor_faktur': nomorFaktur,
      'update_by': updateBy,
    };
  }
}
