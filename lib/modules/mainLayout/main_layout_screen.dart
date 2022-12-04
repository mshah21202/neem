import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:neem/Theme/color_manager.dart';
import 'package:neem/modules/Cart/cart_cubit.dart';
import 'package:neem/modules/Home/home_screen_cubit.dart';
import 'package:neem/modules/mainLayout/main_layout_cubit.dart';
import 'package:neem/modules/mainLayout/main_layout_states.dart';

import '../../Theme/theme.dart';

class MainLayout extends StatelessWidget {
  const MainLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => MainLayoutCubit()),
        BlocProvider(create: (context) => HomeCubit()),
      ],
      child: BlocConsumer<MainLayoutCubit, MainLayoutStates>(
          listener: (context, state) {},
          builder: (context, state) {
            MainLayoutCubit cubit = MainLayoutCubit.get(context);
            return Scaffold(
              appBar: mainAppBar(context,
                  title: cubit.items[cubit.currentIndex].label.toString()),
              bottomNavigationBar: Container(
                decoration: BoxDecoration(
                    color: ColorManager.white,
                    boxShadow: cubit.currentIndex != 1
                        ? [
                            BoxShadow(
                                offset: Offset.fromDirection(-90),
                                blurRadius: 12,
                                color: Colors.black.withOpacity(0.5))
                          ]
                        : null),
                child: BottomNavigationBar(
                  items: cubit.items,
                  currentIndex: cubit.currentIndex,
                  type: BottomNavigationBarType.fixed,
                  onTap: (value) => cubit.changeCurrentIndex(value),
                  elevation: 0.0,
                  backgroundColor: ColorManager.white,
                ),
              ),
              body: cubit.screens[cubit.currentIndex],
            );
          }),
    );
  }
}
