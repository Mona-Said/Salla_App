import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../../shared/components/components.dart';
import '../../shared/network/local/cache_helper.dart';
import '../login/shop_login_screen.dart';

class OnboardModel {
  final String? image;
  final String? title;
  final String? body;
  OnboardModel({
    required this.image,
    required this.title,
    required this.body,
  });
}

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  List<OnboardModel> onboarding = [
    OnboardModel(
      image: 'assets/images/onboard1.png',
      title: 'Welcome To Salla',
      body: 'Shop your favorite brands with just a few taps!',
    ),
    OnboardModel(
      image: 'assets/images/onboard2.png',
      title: 'Tailored Just for You',
      body: 'Enjoy a personalized shopping experience with us',
    ),
    OnboardModel(
      image: 'assets/images/onboard3.png',
      title: 'Hassle-Free Shopping',
      body:
          'Fast delivery right to your doorstep. Your satisfaction is our priority!',
    ),
  ];

  var onboardController = PageController();

  bool isLast = false;

  void summit() {
    CacheHelper.putData(key: 'onBoarding', value: true).then((value) {
      if (value!) {
        navigateAndFinish(context, ShopLoginScreen());
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          textButton(
            text: 'SKIP',
            color: Colors.brown,
            fontSize: 17.0,
            function: summit,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const BouncingScrollPhysics(),
                controller: onboardController,
                onPageChanged: (int index) {
                  if (index == onboarding.length - 1) {
                    setState(() {
                      isLast = true;
                    });
                  } else {
                    setState(() {
                      isLast = false;
                    });
                  }
                },
                itemBuilder: (context, index) => onboardItem(onboarding[index]),
                itemCount: onboarding.length,
              ),
            ),
            const SizedBox(
              height: 40.0,
            ),
            Row(
              children: [
                SmoothPageIndicator(
                  controller: onboardController,
                  effect: const ExpandingDotsEffect(
                    dotColor: Colors.grey,
                    activeDotColor: Colors.brown,
                    dotHeight: 10.0,
                    dotWidth: 10.0,
                    spacing: 5.0,
                    expansionFactor: 3,
                  ),
                  count: onboarding.length,
                ),
                const Spacer(),
                FloatingActionButton(
                  backgroundColor: Colors.brown,
                  onPressed: () {
                    if (isLast) {
                      summit();
                    } else {
                      onboardController.nextPage(
                        duration: const Duration(
                          milliseconds: 750,
                        ),
                        curve: Curves.fastLinearToSlowEaseIn,
                      );
                    }
                  },
                  child: const Icon(
                    Icons.arrow_forward_ios,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget onboardItem(OnboardModel model) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Image(
              image: AssetImage('${model.image}'),
            ),
          ),
          const SizedBox(
            height: 40.0,
          ),
          Text(
            '${model.title}',
            style: const TextStyle(
              fontSize: 25.0,
            ),
          ),
          const SizedBox(
            height: 15.0,
          ),
          Text(
            '${model.body}',
            style: const TextStyle(
              fontSize: 16.0,
            ),
          ),
          const SizedBox(
            height: 50.0,
          ),
        ],
      );
}
