import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neem/Theme/app_size_manager.dart';
import 'package:neem/Theme/color_manager.dart';
import 'package:neem/Theme/string.dart';
import 'package:neem/Theme/theme.dart';
import 'package:neem/modules/LogIn/login_screen.dart';
import 'package:neem/modules/OnBoarding/page_indicator.dart';
import 'package:neem/modules/OnBoarding/pages_list.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int index = 0;
  PageController _pageController = PageController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: mainAppBar(context),
      body: Padding(
        padding: const EdgeInsets.all(PaddingManager.p5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.5,
              child: PageView(
                onPageChanged: (i) {
                  setState(() {
                    index = i;
                  });
                },
                controller: _pageController,
                children: pages,
              ),
            ),
            Text(
              StringManager.onBoardingStrings[index],
              style: Theme.of(context).textTheme.titleLarge,
              textAlign: TextAlign.center,
            ),
            PageIndicator(count: pages.length, pageIndex: index),
            TextButton(
              onPressed: () {
                if (index != pages.length - 1)
                  _pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease);
                else
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => LogInScreen(),
                    ),
                  );
              },
              child: Text(
                index != pages.length - 1 ? "Next" : "Get Started",
                style: Theme.of(context)
                    .textTheme
                    .titleLarge!
                    .copyWith(color: ColorManager.white),
              ),
              style: mainButtonStyle(),
            ),
            (index != pages.length - 1)
                ? TextButton(
                    onPressed: () {
                      _pageController.animateToPage(pages.length - 1,
                          duration: Duration(milliseconds: 500),
                          curve: Curves.ease);
                    },
                    child: Text(
                      "Skip",
                      style: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(color: ColorManager.primaryColor),
                    ),
                    style: secondaryButtonStyle(),
                  )
                : Center()
          ],
        ),
      ),
    );
  }
}
