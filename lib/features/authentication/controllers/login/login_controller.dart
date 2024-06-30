import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:tstore_app/data/repositories/repositories_authentication/authentication_repository.dart';
import 'package:tstore_app/features/personalization/controllers/user_controller.dart';
import 'package:tstore_app/utils/helpers/network_manager.dart';
import 'package:tstore_app/utils/popups/full_screen_loader.dart';
import 'package:tstore_app/utils/popups/loader.dart';

class LoginController extends GetxController {
  //variables
  final localStorage = GetStorage();
  final email = TextEditingController();
  final password = TextEditingController();
  GlobalKey<FormState> loginFormKey = GlobalKey<FormState>();
  final rememberMe = false.obs;
  final hidePassword = true.obs;
  final userController = Get.put(UserController());

  @override
  void onInit() {
    if (localStorage.read('REMEMBER_ME_CHECKBOX') == true) {
      email.text = localStorage.read('REMEMBER_ME_EMAIL');
      password.text = localStorage.read('REMEMBER_ME_PASSWORD');
      rememberMe.value = localStorage.read('REMEMBER_ME_CHECKBOX');
    }
    super.onInit();
  }

  //email and password sign in
  Future<void> emailAndPasswordSignIn() async {
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

      //form validation
      if (!loginFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
      }

      //save data if remember me is checked
      if (rememberMe.value) {
        localStorage.write('REMEMBER_ME_EMAIL', email.text.trim());
        localStorage.write('REMEMBER_ME_PASSWORD', password.text.trim());
        localStorage.write('REMEMBER_ME_CHECKBOX', rememberMe.value);
      }

      //login user using email and password authentication
      final userCredentials = await AuthenticationRespository.instance
          .loginWithEmailAndPassword(email.text.trim(), password.text.trim());

      //remove loader
      TFullScreenLoader.stopLoading();

      //redirect
      AuthenticationRespository.instance.screenRedirect();
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return;
    }
  }

//google sign in authentication
  Future<void> googleSignIn() async {
    try {
      // start loading
      TFullScreenLoader.openLoadingDialog('Logging you in.....',
          'https://lottie.host/7353556f-a444-4c02-a872-a3555273d683/1px2tjRHKI.json');

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }
      // TLoaders.errorSnackBar(title: 'Oh Snap', message: '');

      //google authentication
      final userCredentials =
          await AuthenticationRespository.instance.signInWithGoogle();

      //save user record
      await userController.saveUserRecord(userCredentials);

      // remove loader
      TFullScreenLoader.stopLoading();

      //redirect
      AuthenticationRespository.instance.screenRedirect();
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
      return;
    }
  }
}
