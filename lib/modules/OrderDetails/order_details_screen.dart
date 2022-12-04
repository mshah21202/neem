// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neem/Theme/app_size_manager.dart';
import 'package:neem/Theme/color_manager.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/models/order_model.dart';
import 'package:neem/modules/mainLayout/main_layout_screen.dart';

class OrderDetails extends StatelessWidget {
  const OrderDetails({Key? key, required this.orderModel}) : super(key: key);

  final OrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    var products = orderModel.products;
    return Scaffold(
      appBar: mainAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(PaddingManager.p10),
        child: Column(
          children: [
            Text(
              "OrderID: ${orderModel.id}",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: ColorManager.black),
            ),
            Text(
              "Order State: ${orderModel.orderState.toString()}",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: ColorManager.black),
            ),
            Text(
              "Order Total: \$${orderModel.total.toStringAsFixed(2)}",
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(color: ColorManager.black),
            ),
            Expanded(
              child: ListView.builder(
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(
                          "x${orderModel.quantities[index].toString()} ${products[index].name}"),
                      leading: Image(
                          image: NetworkImage(products[index].photoUrls.first)),
                      subtitle: Text(
                          "${products[index].description.length > 25 ? ("${products[index].description.substring(0, 25)}.....") : products[index].description} \n \$${products[index].price}"),
                      isThreeLine: true,
                    );
                  }),
            ),
            TextButton(
              onPressed: () {
                if (!Navigator.canPop(context)) {
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (_) => MainLayout()));
                } else {
                  Navigator.of(context).pop();
                }
              },
              style: mainButtonStyle(),
              child: Text(
                "Done",
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: ColorManager.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
