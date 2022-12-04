// ignore_for_file: prefer_const_constructors

import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/Theme/app_size_manager.dart';
import 'package:neem/Theme/color_manager.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/models/product_model.dart';
import 'package:neem/modules/Home/drawer_cubit.dart';
import 'package:neem/modules/Home/drawer_screen.dart';
import 'package:neem/modules/Home/drawer_states.dart';
import 'package:neem/modules/Home/home_screen_cubit.dart';
import 'package:neem/modules/Home/home_screen_states.dart';
import 'package:neem/modules/LogIn/login_cubit.dart';
import 'package:neem/modules/LogIn/login_screen.dart';
import 'package:neem/modules/LogIn/login_states.dart';
import 'package:neem/modules/product/product_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => DrawerCubit(),
      child: BlocConsumer<HomeCubit, HomeStates>(
        builder: (context, state) {
          HomeCubit homeCubit = HomeCubit.get(context);
          ScrollController _controller = ScrollController();

          _controller.addListener(() {
            // print(_controller.position.extentAfter);
            if (_controller.position.extentAfter < 30 &&
                state is! LoadingHomeProducts) {
              homeCubit.loadProducts();
            }
          });
          final GlobalKey<ScaffoldState> scaffoldKey =
              GlobalKey<ScaffoldState>();
          return Scaffold(
              endDrawerEnableOpenDragGesture: false,
              key: scaffoldKey,
              endDrawer: FiltersDrawer(homeCubit: homeCubit),
              body: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: PaddingManager.p10),
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () {
                          scaffoldKey.currentState!.openEndDrawer();
                        },
                        icon: Icon(Icons.filter_alt_sharp),
                        label: Text("Filters"),
                        style: TextButton.styleFrom(
                            primary: ColorManager.white,
                            backgroundColor: ColorManager.primaryColor),
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      controller: _controller,
                      itemCount: state is LoadingHomeProducts
                          ? homeCubit.products.length + 1
                          : homeCubit.products.length,
                      itemBuilder: (context, index) {
                        List<ProductModel> products = homeCubit.products;
                        if (state is LoadingHomeProducts &&
                            index == homeCubit.products.length) {
                          return Center(child: CircularProgressIndicator());
                        } else {
                          return ListTile(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => BlocProvider.value(
                                    value: HomeCubit.get(context),
                                    child: ProductScreen(
                                        id: products[index].id, index: index),
                                  ),
                                ),
                              );
                            },
                            title: Text(products[index].name),
                            leading: Image(
                                image: NetworkImage(
                                    products[index].photoUrls.first)),
                            subtitle: Text(
                                "${products[index].description.length > 25 ? ("${products[index].description.substring(0, 25)}.....") : products[index].description} \n \$${products[index].price}"),
                            trailing: IconButton(
                                onPressed: () {
                                  homeCubit.addRemoveFavorite(index);
                                },
                                icon: products[index].favorite
                                    ? Icon(
                                        Icons.favorite,
                                        color: ColorManager.primaryColor,
                                      )
                                    : Icon(Icons.favorite_border)),
                            isThreeLine: true,
                          );
                        }
                      },
                    ),
                  ),
                ],
              ));
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
