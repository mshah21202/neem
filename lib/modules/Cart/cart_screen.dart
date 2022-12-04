// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/Theme/app_size_manager.dart';
import 'package:neem/Theme/color_manager.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/models/product_model.dart';
import 'package:neem/modules/Cart/cart_cubit.dart';
import 'package:neem/modules/Cart/cart_states.dart';
import 'package:neem/modules/OrderDetails/order_details_screen.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: BlocConsumer<CartCubit, CartStates>(
        builder: (context, state) {
          CartCubit cubit = CartCubit.get(context);
          return Scaffold(
            body: Stack(
              children: [
                Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        // controller: _controller,
                        itemCount: state is! LoadingCartProductsState
                            ? cubit.cartProducts.length
                            : 1,
                        itemBuilder: (context, index) {
                          List<ProductModel> products = cubit.cartProducts;
                          if (state is LoadingCartProductsState) {
                            return Center(child: CircularProgressIndicator());
                          } else {
                            return ListTile(
                              title: Text(products[index].name),
                              leading: Image(
                                  image: NetworkImage(
                                      products[index].photoUrls.first)),
                              subtitle: Text("\$${products[index].price}"),
                              trailing: SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.05,
                                width: MediaQuery.of(context).size.width * 0.3,
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        cubit.decrementQuantity(index);
                                      },
                                      icon: Icon(
                                        Icons.remove,
                                      ),
                                      color: ColorManager.primaryColor,
                                      iconSize: 32,
                                    ),
                                    Text(
                                      cubit.quantities[index].toString(),
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineSmall!
                                          .copyWith(color: Colors.black),
                                    ),
                                    IconButton(
                                      onPressed: () {
                                        cubit.incrementQuantity(index);
                                      },
                                      color: ColorManager.primaryColor,
                                      icon: Icon(Icons.add),
                                      iconSize: 32,
                                    ),
                                  ],
                                ),
                              ),
                              isThreeLine: true,
                            );
                          }
                        },
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        height: MediaQuery.of(context).size.height * 0.1,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                  offset: Offset.fromDirection(-90),
                                  blurRadius: 12,
                                  color: Colors.black.withOpacity(0.5))
                            ],
                            border: Border(
                              top: BorderSide(color: ColorManager.grey),
                            ),
                            color: ColorManager.white),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: PaddingManager.p10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                  "Total: \$${cubit.subTotal.toStringAsFixed(2)}",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold)),
                              TextButton(
                                onPressed: () {
                                  cubit.createOrder();
                                },
                                style: TextButton.styleFrom(
                                  backgroundColor: ColorManager.primaryColor,
                                ),
                                child: Text(
                                  "Check-Out",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headlineLarge!
                                      .copyWith(color: ColorManager.white),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                state is CreatingOrderState
                    ? Align(
                        alignment: Alignment.center,
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
                          color: Colors.black.withOpacity(0.7),
                        ),
                      )
                    : Center(),
                state is CreatingOrderState
                    ? Align(
                        alignment: Alignment.center,
                        child: CircularProgressIndicator(),
                      )
                    : Center()
              ],
            ),
          );
        },
        listener: (BuildContext context, state) {
          CartCubit cubit = CartCubit.get(context);
          if (state is ConfirmDeleteProduct) {
            showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    title: Text("Are you sure?"),
                    actions: [
                      TextButton(
                        onPressed: () {
                          cubit.deleteProduct(cubit.workingIndex);
                          Navigator.of(context).pop();
                        },
                        child: Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: Text("Cancel"),
                      ),
                    ],
                  );
                });
          }

          if (state is CreatedOrderState) {
            final scaffold = ScaffoldMessenger.of(context);
            scaffold.showSnackBar(SnackBar(content: Text("Order placed!")));
            Navigator.of(context)
                .pushReplacement(MaterialPageRoute(builder: (_) {
              return OrderDetails(orderModel: cubit.result!);
            }));
          }
        },
      ),
    );
  }
}
