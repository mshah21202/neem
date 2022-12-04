// ignore_for_file: prefer_const_constructors

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/Theme/app_size_manager.dart';
import 'package:neem/Theme/color_manager.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/modules/Home/home_screen_cubit.dart';
import 'package:neem/modules/Home/home_screen_states.dart';
import 'package:neem/modules/product/product_cubit.dart';
import 'package:neem/modules/product/product_states.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({Key? key, required this.id, required this.index})
      : super(key: key);
  final int id;
  final int index;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ProductCubit(id: id),
      child: BlocConsumer<ProductCubit, ProductStates>(
        builder: (context, state) {
          ProductCubit cubit = ProductCubit.get(context);
          return Scaffold(
            appBar: AppBar(
              centerTitle: true,
              title: Text(
                id.toString(),
                style: Theme.of(context)
                    .textTheme
                    .headlineLarge!
                    .copyWith(color: ColorManager.white),
              ),
              leading: IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop(cubit.productModel!.favorite);
                },
              ),
            ),
            body: state is! LoadingProductState
                ? Column(
                    children: [
                      CarouselSlider(
                        items: cubit.productModel != null
                            ? cubit.productModel!.photoUrls
                                .map((e) => Builder(
                                      builder: ((context) {
                                        return Image.network(e);
                                      }),
                                    ))
                                .toList()
                            : [],
                        options: CarouselOptions(height: 350),
                      ),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: PaddingManager.p10),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    cubit.productModel != null
                                        ? cubit.productModel!.name
                                        : "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .headlineLarge!
                                        .copyWith(
                                            color: Colors.black, fontSize: 32),
                                  ),
                                  BlocConsumer<HomeCubit, HomeStates>(
                                      listener: (context, state) {},
                                      builder: (context, state) {
                                        HomeCubit homeCubit =
                                            HomeCubit.get(context);
                                        return IconButton(
                                            onPressed: () {
                                              cubit.productModel!.favorite =
                                                  !cubit.productModel!.favorite;
                                              homeCubit
                                                  .addRemoveFavorite(index);
                                            },
                                            icon: (cubit.productModel != null
                                                    ? cubit
                                                        .productModel!.favorite
                                                    : false)
                                                ? Icon(
                                                    Icons.favorite,
                                                    color: ColorManager
                                                        .primaryColor,
                                                  )
                                                : Icon(Icons.favorite_border));
                                      }),
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height *
                                        0.05,
                                    width:
                                        MediaQuery.of(context).size.width * 0.4,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        IconButton(
                                          onPressed: () {
                                            cubit.decrementQuantity();
                                          },
                                          icon: Icon(
                                            Icons.remove,
                                          ),
                                          color: ColorManager.primaryColor,
                                          iconSize: 32,
                                        ),
                                        Text(
                                          cubit.quantity.toString(),
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(color: Colors.black),
                                        ),
                                        IconButton(
                                          onPressed: () {
                                            cubit.incrementQuantity();
                                          },
                                          color: ColorManager.primaryColor,
                                          icon: Icon(Icons.add),
                                          iconSize: 32,
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton.icon(
                                      onPressed: () {
                                        cubit.addProductToCart();
                                      },
                                      icon: Icon(
                                        Icons.add_circle,
                                        color: ColorManager.white,
                                      ),
                                      label: Text("Add to cart",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headlineSmall!
                                              .copyWith(
                                                  color: ColorManager.white)),
                                      style: TextButton.styleFrom(
                                        backgroundColor:
                                            ColorManager.primaryColor,
                                      ))
                                ],
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.03,
                              ),
                              Text(
                                cubit.productModel != null
                                    ? cubit.productModel!.description
                                    : "",
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        color: Colors.black, fontSize: 16),
                              ),
                            ],
                          ))
                    ],
                  )
                : Center(child: CircularProgressIndicator()),
          );
        },
        listener: (BuildContext context, state) {
          if (state is AddedProductToCartState) {
            final scaffold = ScaffoldMessenger.of(context);
            scaffold.showSnackBar(
                SnackBar(content: Text("Product was added to your cart!")));
          }
        },
      ),
    );
  }
}
