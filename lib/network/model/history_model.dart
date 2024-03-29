class HistoryOrderModel {
  final String invoice;
  final String idOrder;
  final String idUser;
  final String orderAt;
  final String status;
  final List<HistoryOrderDetailModel> detail;

  HistoryOrderModel({
    this.invoice,
    this.idOrder,
    this.idUser,
    this.orderAt,
    this.status,
    this.detail,
  });

  factory HistoryOrderModel.fromJson(Map<String, dynamic> dataOrder) {
    var list = dataOrder['detail'] as List;
    List<HistoryOrderDetailModel> dataListDetail =
        list.map((e) => HistoryOrderDetailModel.fromJson(e)).toList();
    return HistoryOrderModel(
      invoice: dataOrder['invoice'],
      idOrder: dataOrder['id_orders'],
      idUser: dataOrder['id_user'],
      orderAt: dataOrder['order_at'],
      status: dataOrder['status'],
      detail: dataListDetail,
    );
  }
}

class HistoryOrderDetailModel {
  final String idOrders;
  final String invoice;
  final String idProduct;
  final String nameProduct;
  final String quantity;
  final String price;

  HistoryOrderDetailModel({
    this.idOrders,
    this.invoice,
    this.idProduct,
    this.nameProduct,
    this.quantity,
    this.price,
  });

  factory HistoryOrderDetailModel.fromJson(Map<String, dynamic> data) {
    return HistoryOrderDetailModel(
      idOrders: data['idOrders'],
      invoice: data['invoice'],
      idProduct: data['idProduct'],
      nameProduct: data['nameProduct'],
      quantity: data['quantity'],
      price: data['price'],
    );
  }
}
