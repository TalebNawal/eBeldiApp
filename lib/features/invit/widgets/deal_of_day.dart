import 'package:ebeldi/common/widgets/loader.dart';
import 'package:ebeldi/features/product_details/screens/product_details_screen_Inv.dart';
import 'package:ebeldi/models/product.dart';
import 'package:flutter/material.dart';

import '../services/home_services_inv.dart';

class DealOfDay extends StatefulWidget {
  const DealOfDay({Key? key}) : super(key: key);

  @override
  State<DealOfDay> createState() => _DealOfDayState();
}

class _DealOfDayState extends State<DealOfDay> {
  List<Product>? productList;
  List<Product>? productList2;
  final HomeServicesInv homeServices = HomeServicesInv();
  Product? product;

  @override
  void initState() {
    super.initState();
    fetchCategoryProducts();
    fetchCategoryProducts2();
  }

  fetchCategoryProducts() async {
    productList = await homeServices.fetchCategoryProducts(
      context: context,
      category: 'Miel',
    );
    setState(() {});
  }

  fetchCategoryProducts2() async {
    productList2 = await homeServices.fetchCategoryProducts(
      context: context,
      category: 'Huiles',
    );
    setState(() {});
  }

  void navigateToDetailScreen() {
    Navigator.pushNamed(
      context,
      ProductDetailScreenInv.routeName,
      arguments: product,
    );
  }

  @override
  Widget build(BuildContext context) {
    return productList2 == null
        ? const Loader()
        : GestureDetector(
            //onTap: navigateToDetailScreen,
            child: Column(
              children: [
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 10, top: 15),
                  /*child: const Text(
                        'Suggestion pour vous',
                        style: TextStyle(fontSize: 20),
                      ),*/
                ),
                Image.network(
                  productList2![1].images[0],
                  height: 235,
                  fit: BoxFit.fitHeight,
                ),
                Image.network(
                  productList2![3].images[0],
                  height: 235,
                  fit: BoxFit.fitHeight,
                ),
                /*Container(
                      padding: const EdgeInsets.only(left: 15),
                      alignment: Alignment.topLeft,
                      child: const Text(
                        '100 Dhs',
                        style: TextStyle(fontSize: 18),
                      ),
                    ),*/
                Container(
                  alignment: Alignment.topLeft,
                  padding: const EdgeInsets.only(left: 15, top: 5, right: 40),
                  child: const Text(
                    'plus',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: productList2![2]
                        .images
                        .map(
                          (e) => Image.network(
                            e,
                            fit: BoxFit.fitWidth,
                            width: 100,
                            height: 100,
                          ),
                        )
                        .toList(),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(
                    vertical: 15,
                  ).copyWith(left: 15),
                  alignment: Alignment.topLeft,
                  /*child: Text(
                        'Voir tous',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                        ),
                      ),*/
                ),
              ],
            ),
          );
  }
}