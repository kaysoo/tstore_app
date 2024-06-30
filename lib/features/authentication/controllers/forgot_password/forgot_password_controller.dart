import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tstore_app/data/repositories/repositories_authentication/authentication_repository.dart';
import 'package:tstore_app/features/authentication/screens/password/reset_password.dart';
import 'package:tstore_app/utils/helpers/network_manager.dart';
import 'package:tstore_app/utils/popups/full_screen_loader.dart';
import 'package:tstore_app/utils/popups/loader.dart';

class ForgotPasswordController extends GetxController {
  static ForgotPasswordController get instance => Get.find();

  //variables
  final email = TextEditingController();
  GlobalKey<FormState> forgotPasswordFormKey = GlobalKey<FormState>();

  //send reset password email
  sendPasswordResetEmail() async {
    try {
      //start loader
      TFullScreenLoader.openLoadingDialog('We are processing your request',
          'https://lottie.host/7353556f-a444-4c02-a872-a3555273d683/1px2tjRHKI.json');

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //validate form
      if (!forgotPasswordFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRespository.instance
          .sendPasswordResetEmail(email.text.trim());

      //remove loader
      TFullScreenLoader.stopLoading();

      //show success screen
      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Reset password link has been sent to your email.'.tr);

      //redirect
      Get.to(() => ResetPassword(
            email: email.text.trim(),
          ));
    } catch (e) {
      //remove loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  resendPasswordResetEmail(String email) async {
    try {
      //start loader
      TFullScreenLoader.openLoadingDialog('We are processing your request',
          'https://lottie.host/7353556f-a444-4c02-a872-a3555273d683/1px2tjRHKI.json');

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      await AuthenticationRespository.instance.sendPasswordResetEmail(email);

      //remove loader
      TFullScreenLoader.stopLoading();

      //show success screen
      TLoaders.successSnackBar(
          title: 'Email Sent',
          message: 'Reset password link has been sent to your email.'.tr);
    } catch (e) {
      //remove loader
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
