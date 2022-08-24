import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:neem/Theme/color_manager.dart';

class PageIndicator extends StatefulWidget {
  final int count;
  int pageIndex;
  PageIndicator({Key? key, required this.count, required this.pageIndex})
      : super(key: key);

  @override
  State<PageIndicator> createState() => _PageIndicatorState();
}

class _PageIndicatorState extends State<PageIndicator> {
  // final PageController _pageController = widget.pageController;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    int count = widget.count;
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.1,
      child: ListView.builder(
        itemCount: count,
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8),
            child: SizedBox(
              width: 10,
              height: 10,
              child: Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: widget.pageIndex == index
                        ? ColorManager.primaryColor
                        : ColorManager.grey),
                width: 10,
                height: 10,
              ),
            ),
          );
        },
      ),
    );
  }
}
