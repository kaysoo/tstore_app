import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/features/authentication/controllers/onboarding/onboarding_controller.dart';
import 'package:tstore_app/features/authentication/screens/onboarding/components/onboarding_navigation.dart';
import 'package:tstore_app/features/authentication/screens/onboarding/components/onboarding_nextbutton.dart';
import 'package:tstore_app/features/authentication/screens/onboarding/components/onboarding_page.dart';
import 'package:tstore_app/features/authentication/screens/onboarding/components/onboarding_skip_button.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/text_strings.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OnboardingController());
    return Scaffold(
      body: Stack(
        children: [
          //horizontal scrollable pages
          PageView(
            controller: controller.pageController,
            onPageChanged: controller.updatePageIndicator,
            children: const [
              OnBoarding(
                image: TImages.onBoardingImage1,
                title: TTexts.onBoardingTitle1,
                subTitle: TTexts.onBoardingSubTitle1,
              ),
              OnBoarding(
                image: TImages.onBoardingImage2,
                title: TTexts.onBoardingTitle2,
                subTitle: TTexts.onBoardingSubTitle2,
              ),
              OnBoarding(
                image: TImages.onBoardingImage3,
                title: TTexts.onBoardingTitle3,
                subTitle: TTexts.onBoardingSubTitle3,
              ),
            ],
          ),
          //skip button
          const OnBoardingSkip(),

          //dot navigation smoothPageIndicator
          const OnboardingNavigation(),

          //Circulat button
          const OnboardingNextButton(),
        ],
      ),
    );
  }
}
