class AboutModel {
  final String id;
  final String imageQR;
  final String nameBank;
  final String bankNumber;
  final String fullName;
  final String lineId;

  AboutModel({
    this.id,
    this.imageQR,
    this.nameBank,
    this.bankNumber,
    this.fullName,
    this.lineId,
  });

  factory AboutModel.fromJson(Map<String, dynamic> data) {
    return AboutModel(
      id: data['id'],
      imageQR: data['image_qr'],
      nameBank: data['name_bank'],
      bankNumber: data['bank_number'],
      fullName: data['full_name'],
      lineId: data['line_id'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['image_qr'] = this.imageQR;
    data['name_bank'] = this.nameBank;
    data['bank_number'] = this.bankNumber;
    data['full_name'] = this.fullName;
    data['line_id'] = this.lineId;
    return data;
  }
}
