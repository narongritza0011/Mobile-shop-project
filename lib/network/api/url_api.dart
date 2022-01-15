class BASEURL {
  static String ipAddress = "100.100.101.208";
  //100.100.101.208 สำหรับโฮสบนเครื่องตัวเอง
  //b27b-1-20-149-88.ngrok.io สำหรับออนไลน์ เเค่ 2 ชม. พิม ngrok http 80
  // https://1448-1-20-149-88.ngrok.io สำหรับออนไลน์ ตลอด พิม ngrok http 80
  static String apiRegister = "http://$ipAddress/medhealth_db/register_api.php";
  static String apiLogin = "http://$ipAddress/medhealth_db/Login_api.php";
  static String categoryWithProduct =
      "http://$ipAddress/medhealth_db/get_product_with_category.php";
  static String getProduct = "http://$ipAddress/medhealth_db/get_product.php";
  static String addToCart = "http://$ipAddress/medhealth_db/add_to_cart.php";
  static String getProductCart =
      "http://$ipAddress/medhealth_db/get_cart.php?userID=";
  static String updateQuantityProductCart =
      "http://$ipAddress/medhealth_db/update_quantity.php";
  static String totalPriceCart =
      "http://$ipAddress/medhealth_db/get_total_price.php?userID=";
  static String getTotalCart =
      "http://$ipAddress/medhealth_db/total_cart.php?userID=";
  static String checkout = "http://$ipAddress/medhealth_db/checkout.php";

  static String historyOrder =
      "http://$ipAddress/medhealth_db/get_history.php?id_user=";

  static String historyOrderDetail =
      "http://$ipAddress/medhealth_db/get_history_single.php?id_order=";

  static String aboutContact =
      "http://$ipAddress/medhealth_db/get_pay_bank.php";

  static String editProfile =
      "http://$ipAddress/medhealth_db/editUserWhereId.php";

  static String getTracking =
      "http://$ipAddress/medhealth_db/get_tracking.php?id_user=";

  static String checkoutDelivery =
      "http://$ipAddress/medhealth_db/checkout_delivery.php";

  static String deliveryHistoryOrder =
      "http://$ipAddress/medhealth_db/get_delivery_history.php?id_user=";
  static String deliveryHistoryOrderDetail =
      "http://$ipAddress/medhealth_db/get_delivery_history_detail.php?id_order=";
}
