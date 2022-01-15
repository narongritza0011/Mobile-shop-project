class DeliveryHistoryOrderModel {
  final String invoice;
  final String idOrder;
  final String idUser;
  final String orderAt;
  final String status;
  final List<DeliveryHistoryOrderDetailModel> detail;

  DeliveryHistoryOrderModel({
    this.invoice,
    this.idOrder,
    this.idUser,
    this.orderAt,
    this.status,
    this.detail,
  });

  factory DeliveryHistoryOrderModel.fromJson(Map<String, dynamic> dataOrder) {
    var list = dataOrder['detail'] as List;
    List<DeliveryHistoryOrderDetailModel> dataListDetail =
        list.map((e) => DeliveryHistoryOrderDetailModel.fromJson(e)).toList();
    return DeliveryHistoryOrderModel(
      invoice: dataOrder['invoice'],
      idOrder: dataOrder['id_orders'],
      idUser: dataOrder['id_user'],
      orderAt: dataOrder['order_at'],
      status: dataOrder['status'],
      detail: dataListDetail,
    );
  }
}

class DeliveryHistoryOrderDetailModel {
  final String idOrders;
  final String invoice;
  final String idProduct;
  final String nameProduct;
  final String quantity;
  final String price;

  DeliveryHistoryOrderDetailModel({
    this.idOrders,
    this.invoice,
    this.idProduct,
    this.nameProduct,
    this.quantity,
    this.price,
  });

  factory DeliveryHistoryOrderDetailModel.fromJson(Map<String, dynamic> data) {
    return DeliveryHistoryOrderDetailModel(
      idOrders: data['idOrders'],
      invoice: data['invoice'],
      idProduct: data['idProduct'],
      nameProduct: data['nameProduct'],
      quantity: data['quantity'],
      price: data['price'],
    );
  }
}
