// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/Theme/color_manager.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/models/product_model.dart';
import 'package:neem/modules/Home/home_screen_cubit.dart';
import 'package:neem/modules/Home/home_screen_states.dart';
import 'package:neem/modules/LogIn/login_cubit.dart';
import 'package:neem/modules/LogIn/login_screen.dart';
import 'package:neem/modules/LogIn/login_states.dart';
import 'package:neem/modules/favorite/favorite_cubit.dart';
import 'package:neem/modules/favorite/favorite_states.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../product/product_screen.dart';

class FavoriteScreen extends StatelessWidget {
  const FavoriteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => FavoriteCubit(),
      child: BlocConsumer<FavoriteCubit, FavoriteStates>(
        builder: (context, state) {
          FavoriteCubit cubit = FavoriteCubit.get(context);
          ScrollController _controller = ScrollController();

          _controller.addListener(() {
            // print(_controller.position.extentAfter);
            if (_controller.position.extentAfter < 30 &&
                state is! LoadingFavoritesState) {
              cubit.loadProducts({});
            }
          });
          return Scaffold(
              body: ListView.builder(
            controller: _controller,
            itemCount: state is LoadingFavoritesState
                ? cubit.products.length + 1
                : cubit.products.length,
            itemBuilder: (context, index) {
              List<ProductModel> products = cubit.products;
              if (state is LoadingFavoritesState &&
                  index == cubit.products.length) {
                return Center(child: CircularProgressIndicator());
              } else {
                return ListTile(
                  onTap: () async {
                    bool delete = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => BlocProvider.value(
                            value: HomeCubit.get(context),
                            child: ProductScreen(
                                id: products[index].id, index: index)),
                      ),
                    );
                    if (!delete) {
                      cubit.localDelete(index);
                    }
                  },
                  title: Text(products[index].name),
                  leading: Image(
                      image: NetworkImage(products[index].photoUrls.first)),
                  subtitle: Text(
                      "${products[index].description.length > 25 ? ("${products[index].description.substring(0, 25)}.....") : products[index].description} \n \$${products[index].price}"),
                  trailing: BlocConsumer<HomeCubit, HomeStates>(
                      listener: ((context, state) {}),
                      builder: (context, state) {
                        HomeCubit homeCubit = HomeCubit.get(context);
                        return IconButton(
                            onPressed: () {
                              int i = homeCubit.products.indexWhere((element) {
                                return products[index] == element;
                              });
                              homeCubit.addRemoveFavorite(i);
                              cubit.localDelete(index);
                            },
                            icon: products[index].favorite
                                ? Icon(
                                    Icons.favorite,
                                    color: ColorManager.primaryColor,
                                  )
                                : Icon(Icons.favorite_border));
                      }),
                  isThreeLine: true,
                );
              }
            },
          ));
        },
        listener: (BuildContext context, Object? state) {},
      ),
    );
  }
}
