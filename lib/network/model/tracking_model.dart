class TrackingModel {
  final String id;
  final String idUser;
  final String invoice;
  final String noTracking;
  final String service;
  final String orderAt;
  final String status;

  TrackingModel({
    this.id,
    this.idUser,
    this.invoice,
    this.noTracking,
    this.service,
    this.orderAt,
    this.status,
  });

  factory TrackingModel.fromJson(Map<String, dynamic> data) {
    return TrackingModel(
      id: data['id'],
      idUser: data['id_user'],
      invoice: data['invoice'],
      noTracking: data['no_tracking'],
      service: data['service'],
      orderAt: data['order_at'],
      status: data['status'],
    );
  }
}
