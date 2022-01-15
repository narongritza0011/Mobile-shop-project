import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medhealth/main_page.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/pref_profile_model.dart';
import 'package:medhealth/network/model/product_model.dart';
import 'package:medhealth/theme.dart';
import 'package:medhealth/widget/button_primary.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class DetailProduct extends StatefulWidget {
  final ProductModel productModel;
  DetailProduct(this.productModel);
  @override
  _DetailProductState createState() => _DetailProductState();
}

class _DetailProductState extends State<DetailProduct> {
  final priceFormat = NumberFormat("#,##0", "EN_US");

  String userID;
  getPref() async {
    SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
    setState(() {
      userID = sharedPreferences.getString(PrefProfile.idUser);
    });
  }

  addToCart() async {
    var urlAddToCart = Uri.parse(BASEURL.addToCart);
    final response = await http.post(urlAddToCart, body: {
      "id_user": userID,
      "id_product": widget.productModel.idProduct,
    });
    final data = jsonDecode(response.body);
    int value = data['value'];
    String message = data['message'];
    if (value == 1) {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                content: Text(
                  message,
                  style: TextStyle(color: Colors.green),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MainPages()),
                          (route) => false);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 100,
                      color: Colors.green,
                      child: Text(
                        "ตกลง",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ));
      setState(() {});
    } else {
      showDialog(
          barrierDismissible: false,
          context: context,
          builder: (context) => AlertDialog(
                content: Text(
                  message,
                  style: TextStyle(color: Colors.yellow[900]),
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (context) => MainPages()),
                          (route) => false);
                    },
                    child: Container(
                      alignment: Alignment.center,
                      height: 30,
                      width: 100,
                      color: Colors.green,
                      child: Text(
                        "ตกลง",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ));

      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getPref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(24, 24, 24, 0),
                height: 70,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_rounded,
                          size: 32,
                          color: greenColor,
                        ),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        "รายละเอียดสินค้า",
                        style: regulerTextStyle.copyWith(fontSize: 25),
                      )
                    ])),
            SizedBox(
              height: 24,
            ),
            Container(
              height: 200,
              color: whiteColor,
              child: Image.network(widget.productModel.imageProduct),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.productModel.nameProduct,
                    style: regulerTextStyle.copyWith(fontSize: 20),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text(
                    widget.productModel.description,
                    style: regulerTextStyle.copyWith(
                        fontSize: 14, color: greyBoldColor),
                    textAlign: TextAlign.justify,
                  ),
                  SizedBox(
                    height: 64,
                  ),
                  Row(
                    children: [
                      Spacer(),
                      Text(
                        "ราคา ",
                        style: boldTextStyle.copyWith(
                          fontSize: 20,
                        ),
                      ),
                      Text(
                        priceFormat.format(
                          int.parse(widget.productModel.price),
                        ),
                        style: boldTextStyle.copyWith(
                            fontSize: 20, color: greenColor),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width,
                    child: ButtonPrimary(
                      ontap: () {
                        addToCart();
                      },
                      text: "ใส่ตระกร้า",
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
