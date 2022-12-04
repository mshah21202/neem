// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/modules/Cart/cart_screen.dart';
import 'package:neem/modules/Home/home_screen.dart';
import 'package:neem/modules/favorite/favorite_screen.dart';
import 'package:neem/modules/mainLayout/main_layout_states.dart';
import 'package:neem/modules/settings/settings_screen.dart';

class MainLayoutCubit extends Cubit<MainLayoutStates> {
  MainLayoutCubit() : super(InitialMainLayoutState());

  static MainLayoutCubit get(BuildContext context) => BlocProvider.of(context);

  List<BottomNavigationBarItem> items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
    BottomNavigationBarItem(icon: Icon(Icons.category), label: "Cart"),
    BottomNavigationBarItem(icon: Icon(Icons.favorite), label: "Favorite"),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: "Settings"),
  ];

  int cartCount = 0;

  List<Widget> screens = [
    HomeScreen(),
    CartScreen(),
    FavoriteScreen(),
    SettingsScreen()
  ];

  int currentIndex = 0;

  void changeCurrentIndex(int index) {
    currentIndex = index;
    emit(IndexChangedState());
  }
}
