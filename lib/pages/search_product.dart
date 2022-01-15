import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:medhealth/network/api/url_api.dart';
import 'package:medhealth/network/model/product_model.dart';
import 'package:medhealth/pages/detail_product.dart';
import 'package:medhealth/theme.dart';
import 'package:http/http.dart' as http;
import 'package:medhealth/widget/card_product.dart';
import 'package:medhealth/widget/widget_ilustration.dart';

class SearchProduct extends StatefulWidget {
  @override
  _SearchProductState createState() => _SearchProductState();
}

class _SearchProductState extends State<SearchProduct> {
  TextEditingController searchControllor = TextEditingController();
  List<ProductModel> listProduct = [];
  List<ProductModel> listSearchProduct = [];
  getProduct() async {
    listProduct.clear();
    var urlProduct = Uri.parse(BASEURL.getProduct);
    final response = await http.get(urlProduct);
    if (response.statusCode == 200) {
      setState(() {
        final data = jsonDecode(response.body);
        for (Map product in data) {
          listProduct.add(ProductModel.fromJson(product));
        }
      });
    }
  }

  searchProduct(String text) {
    listSearchProduct.clear();
    if (text.isEmpty) {
      setState(() {});
    } else {
      listProduct.forEach((element) {
        if (element.nameProduct.toLowerCase().contains(text)) {
          listSearchProduct.add(element);
        }
      });
      setState(() {});
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getProduct();
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
                      color: blackColor,
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 5),
                    width: MediaQuery.of(context).size.width - 100,
                    height: 55,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.brown,
                    ),
                    child: TextField(
                      autofocus: true,
                      onChanged: searchProduct,
                      controller: searchControllor,
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: whiteColor,
                        ),
                        hintText: "ค้นหาสินค้า",
                        hintStyle: regulerTextStyle.copyWith(
                          color: whiteColor,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            searchControllor.text.isEmpty || listSearchProduct.length == 0
                ? Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 80),
                    child: WidgetIlustration(
                      title: "ไม่มีสินค้าที่ต้องการ",
                      image: "assets/no_data_ilustration.png",
                      subtitle1: "กรุณาพิมพ์ชื่อสินค้าที่คุณต้องการ",
                      subtitle2: "สินค้าจะเเสดงที่นี่...",
                    ),
                  )
                : Container(
                    padding: EdgeInsets.all(24),
                    child: GridView.builder(
                        physics: ClampingScrollPhysics(),
                        itemCount: listSearchProduct.length,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 16,
                            mainAxisSpacing: 16),
                        itemBuilder: (context, i) {
                          final y = listSearchProduct[i];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => DetailProduct(y)));
                            },
                            child: CardProduct(
                              nameProduct: y.nameProduct,
                              imageProduct: y.imageProduct,
                              price: y.price,
                            ),
                          );
                        }),
                  ),
          ],
        ),
      ),
    );
  }
}
