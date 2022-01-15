class OrderDeliveryDetailModel {
  final String idOrders;
  final String image;
  final String invoice;
  final String idProduct;
  final String name;
  final String quantity;
  final String price;

  OrderDeliveryDetailModel({
    this.idOrders,
    this.image,
    this.invoice,
    this.idProduct,
    this.name,
    this.quantity,
    this.price,
  });

  factory OrderDeliveryDetailModel.fromJson(Map<String, dynamic> data) {
    return OrderDeliveryDetailModel(
      idOrders: data['id_orders'],
      image: data['image'],
      invoice: data['invoice'],
      idProduct: data['id_product'],
      name: data['nameProduct'],
      quantity: data['quantity'],
      price: data['price'],
    );
  }
}
