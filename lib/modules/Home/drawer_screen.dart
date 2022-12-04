// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/Theme/app_size_manager.dart';
import 'package:neem/modules/Home/drawer_cubit.dart';
import 'package:neem/modules/Home/drawer_states.dart';
import 'package:neem/modules/Home/home_screen_cubit.dart';

class FiltersDrawer extends StatelessWidget {
  const FiltersDrawer({
    Key? key,
    required this.homeCubit,
  }) : super(key: key);

  final HomeCubit homeCubit;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<DrawerCubit, DrawerStates>(
        listener: (context, state) {},
        builder: (context, state) {
          DrawerCubit drawerCubit = DrawerCubit.get(context);
          if (state is InitialDrawerState) {
            drawerCubit.category = homeCubit.category;
            drawerCubit.maxPrice = homeCubit.maxPrice.toDouble();
            drawerCubit.minPrice = homeCubit.minPrice.toDouble();
            drawerCubit.orderBy = homeCubit.orderBy;
          }
          return Drawer(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: PaddingManager.p10, vertical: PaddingManager.p10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.max,
                children: [
                  Text(
                    "Category",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    height: SizeManager.s6,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    value: drawerCubit.category,
                    items: drawerCubit.categories.map((e) {
                      return DropdownMenuItem<String>(
                        value: e,
                        child: Text(e),
                      );
                    }).toList(),
                    onChanged: (value) {
                      drawerCubit.changeCategoryValue(value ?? "");
                    },
                  ),
                  SizedBox(
                    height: SizeManager.s15,
                  ),
                  Text(
                    "Price Range",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    height: SizeManager.s15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("\$${drawerCubit.minPrice.toInt()}"),
                      Text("\$${drawerCubit.maxPrice.toInt()}"),
                    ],
                  ),
                  SizedBox(
                    height: SizeManager.s15,
                  ),
                  RangeSlider(
                    onChanged: (value) {
                      drawerCubit.changePriceRangeValues(
                          value.start, value.end);
                    },
                    values:
                        RangeValues(drawerCubit.minPrice, drawerCubit.maxPrice),
                    min: 0,
                    max: 999,
                  ),
                  SizedBox(
                    height: SizeManager.s15,
                  ),
                  Text(
                    "Order By",
                    style: Theme.of(context).textTheme.labelLarge,
                  ),
                  SizedBox(
                    height: SizeManager.s15,
                  ),
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(border: OutlineInputBorder()),
                    value: drawerCubit.orderBy,
                    items: [
                      DropdownMenuItem(value: "new", child: Text("Newest")),
                      DropdownMenuItem(value: "old", child: Text("Oldest")),
                      DropdownMenuItem(
                          value: "high", child: Text("Highest Price")),
                      DropdownMenuItem(
                          value: "low", child: Text("Lowest Price")),
                    ],
                    onChanged: (value) {
                      drawerCubit.changeOrderByValue(value ?? "");
                    },
                  ),
                  Expanded(
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: TextButton.icon(
                        onPressed: () {
                          // homeCubit.category = drawerCubit.category;
                          // homeCubit.maxPrice = drawerCubit.maxPrice.toInt();
                          // homeCubit.minPrice = drawerCubit.minPrice.toInt();
                          // homeCubit.orderBy = drawerCubit.orderBy;
                          homeCubit.loadProducts(
                              reset: true,
                              category: drawerCubit.category,
                              maxPrice: drawerCubit.maxPrice.toInt(),
                              minPrice: drawerCubit.minPrice.toInt(),
                              orderBy: drawerCubit.orderBy);
                        },
                        icon: Icon(Icons.check),
                        label: Text("Apply"),
                      ),
                    ),
                  )
                ],
              ),
            ),
          );
        });
  }
}
