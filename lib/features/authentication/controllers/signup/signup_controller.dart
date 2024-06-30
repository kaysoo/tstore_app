import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/data/repositories/repositories_authentication/authentication_repository.dart';
import 'package:tstore_app/data/repositories/user/user_repository.dart';
import 'package:tstore_app/features/authentication/screens/signup/verify_email.dart';
import 'package:tstore_app/features/personalization/models/user_model.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/helpers/network_manager.dart';
import 'package:tstore_app/utils/popups/full_screen_loader.dart';
import 'package:tstore_app/utils/popups/loader.dart';

class SignUpController extends GetxController {
  static SignUpController get instance => Get.find();

  //variables
  final privacyPolicy = false.obs;
  final hidePassword = true.obs;
  final email = TextEditingController();
  final lastName = TextEditingController();
  final userName = TextEditingController();
  final firstName = TextEditingController();
  final password = TextEditingController();
  final phoneNumber = TextEditingController();
  GlobalKey<FormState> signupFormKey =
      GlobalKey<FormState>(); //form key for form validation

  //signup
  void signup() async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog('We are processing your information',
          'https://lottie.host/7353556f-a444-4c02-a872-a3555273d683/1px2tjRHKI.json');

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //form  valdation
      if (signupFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //privacy policy check
      if (!privacyPolicy.value) {
        TLoaders.warningSnackBar(
            title: 'Accept Privacy Policy',
            message:
                'In order to create an account, you must read and accept the Privacy Policy & Terms of use');
        TFullScreenLoader.stopLoading();
        return;
      }

      //register user in the firebase auth and save user data in firebase
      final userCredential = await AuthenticationRespository.instance
          .registerWithEmailAndPassword(
              email.text.trim(), password.text.trim());

      //save authenticated user data in the firebase firestore
      final newUser = UserModel(
          id: userCredential.user!.uid,
          firstName: firstName.text.trim(),
          lastName: lastName.text.trim(),
          userName: userName.text.trim(),
          email: email.text.trim(),
          phoneNumber: phoneNumber.text.trim(),
          profilePicture: '');

      final userRepository = Get.put(UserRepository());

      await userRepository.saveNewUserRecord(newUser);

      // //remove loader
      TFullScreenLoader.stopLoading();

      //show success message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message:
              'Your account has been created successfully! Verify email to continue.');

      //direct to verify email screen
      Get.to(() => VerifyEmailScreen(
            email: email.text.trim(),
          ));
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return;
      //show some generic error to the user
    }
    //  finally {
    //   //remove loader
    //   TFullScreenLoader.stopLoading();
    // }
  }
}
