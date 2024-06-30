import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:tstore_app/common/widgets/success_screen/success_screen.dart';
import 'package:tstore_app/data/repositories/repositories_authentication/authentication_repository.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/popups/loader.dart';

class VerifyEmailController extends GetxController {
  static VerifyEmailController get instance => Get.find();

  @override
  void onInit() {
    sendEmailVerification();
    setTimerForAutoRedirect();
    super.onInit();
  }

  //send email verification link
  sendEmailVerification() async {
    try {
      await AuthenticationRespository.instance.sendEmailVerification();
      TLoaders.successSnackBar(
          title: 'Email sent',
          message: 'Please check your inbox and verify your email.');
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh snap', message: e.toString());
    }
  }

  //timer to automatically redirect on Email verification
  setTimerForAutoRedirect() {
    Timer.periodic(const Duration(seconds: 1), (timer) async {
      await FirebaseAuth.instance.currentUser?.reload();
      final user = FirebaseAuth.instance.currentUser;
      if (user?.emailVerified ?? false) {
        timer.cancel();
        Get.off(() => SuccessScreen(
              image: TImages.successIcon,
              title: 'Your Account has been created successfully.',
              subtitle: 'Get ready',
              onPressed: () =>
                  AuthenticationRespository.instance.screenRedirect(),
            ));
      }
    });
  }

  //manually check if email verified
  checkEmailVerificationStatus() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null && currentUser.emailVerified) {
      Get.off(() => SuccessScreen(
            image: TImages.successIcon,
            title: 'Your Account has been created successfully.',
            subtitle: 'Get ready',
            onPressed: () =>
                AuthenticationRespository.instance.screenRedirect(),
          ));
    }
  }
}
