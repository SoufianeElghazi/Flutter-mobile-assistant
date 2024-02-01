import 'package:flutter/material.dart';
import 'package:flutter_app/constants.dart';
import 'package:flutter_app/Onboarding/onboarding_items.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter_app/Screens/Welcome/welcome_screen.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final controller = OnboardingItems();
  final pageController = PageController();

  bool isLastPage = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: isLastPage ? getStarted() : Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [

            // Skip Button
            TextButton(
              onPressed: () => pageController.jumpToPage(controller.items.length - 1),
              child: const Text("Skip"),
            ),

            // Indicator
            SmoothPageIndicator(
              controller: pageController,
              count: controller.items.length,
              onDotClicked: (index) => pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
              effect: const WormEffect(
                dotHeight: 12,
                dotWidth: 12,
                activeDotColor: kPrimaryColor,
              ),
            ),

            // Next Button
            TextButton(
              onPressed: () => pageController.nextPage(
                  duration: const Duration(milliseconds: 600), curve: Curves.easeIn),
              child: const Text("Next"),
            ),
          ],
        ),
      ),
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 15),
        child: PageView.builder(
          onPageChanged: (index) => setState(() => isLastPage = controller.items.length - 1 == index),
          itemCount: controller.items.length,
          controller: pageController,
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(controller.items[index].image),
                const SizedBox(height: 15),
                Text(
                  controller.items[index].title,
                  style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 15),
                Text(
                  controller.items[index].descriptions,
                  style: const TextStyle(color: Colors.grey, fontSize: 17),
                  textAlign: TextAlign.center,
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  // Get started button
  Widget getStarted() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        color: kPrimaryColor,
      ),
      width: MediaQuery.of(context).size.width * .9,
      height: 55,
      child: TextButton(
        onPressed: () async {
          final prefs = await SharedPreferences.getInstance();
          prefs.setBool("onboarding", true);

          // After we press get started button, navigate to WelcomeScreen
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const WelcomeScreen()),
          );
        },
        child: const Text("Get started", style: TextStyle(color: Colors.white)),
      ),
    );
  }

}
