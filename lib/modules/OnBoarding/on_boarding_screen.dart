import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:neem/modules/OnBoarding/page_indicator.dart';
import 'package:neem/modules/OnBoarding/pages_list.dart';

class OnBoardingScreen extends StatefulWidget {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: PageView(
              onPageChanged: (i) {
                setState(() {
                  index = i;
                });
              },
              // controller: _pageController,
              children: pages,
            ),
          ),
          PageIndicator(count: pages.length, pageIndex: index)
        ],
      ),
    );
  }
}
