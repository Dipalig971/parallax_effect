import 'package:flutter/material.dart';
import 'package:parallax_effect/screen/parallax_effect/view/video_card_screen.dart';

import '../modal/video_list.dart';

class ParallaxEffectScreen extends StatefulWidget {
  const ParallaxEffectScreen({super.key});

  @override
  State<ParallaxEffectScreen> createState() => _ParallaxEffectScreenState();
}

class _ParallaxEffectScreenState extends State<ParallaxEffectScreen> {
  late PageController pageController;

  int selectIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.8);
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.7,
            child: PageView.builder(
              controller: pageController,
              itemBuilder: (context, index) {
                return VideoCardScreen(
                  assetPath: videoList[index],
                  isSelected: selectIndex == index,
                );
              },
              onPageChanged: (i) => setState(() => selectIndex = i),
            ),
          ),
        ],
      ),
    );
  }
}