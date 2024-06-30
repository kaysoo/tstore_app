import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/data/repositories/user/user_repository.dart';
import 'package:tstore_app/features/personalization/controllers/user_controller.dart';
import 'package:tstore_app/features/personalization/screens/profile/profile.dart';
import 'package:tstore_app/utils/helpers/network_manager.dart';
import 'package:tstore_app/utils/popups/full_screen_loader.dart';
import 'package:tstore_app/utils/popups/loader.dart';

class UpdateNameController extends GetxController {
  static UpdateNameController get instance => Get.find();

  final firstName = TextEditingController();
  final lastName = TextEditingController();
  final userController = UserController.instance;
  final userRepository = Get.put(UserRepository());
  GlobalKey<FormState> updateUserNameFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    initializeNames();
    super.onInit();
  }

  //fetch user record
  Future<void> initializeNames() async {
    firstName.text = userController.user.value.firstName;
    lastName.text = userController.user.value.lastName;
  }

  //update user names
  Future<void> updateUserName() async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog('We are updating your information',
          'https://lottie.host/7353556f-a444-4c02-a872-a3555273d683/1px2tjRHKI.json');

      //check internet connectivity
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //update user first and last name in the firestore
      Map<String, dynamic> name = {
        'FirstName': firstName.text.trim(),
        'LastName': lastName.text.trim()
      };
      await userRepository.updateSingleField(name);

      //update the Rx user value
      userController.user.value.firstName = firstName.text.trim();
      userController.user.value.lastName = lastName.text.trim();

      //remove loader
      TFullScreenLoader.stopLoading();

      //show success message
      TLoaders.successSnackBar(
          title: 'Congratulations',
          message: 'Your name has been updated successfully.');

      //move to previous screen
      Get.off(() => const ProfileScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }
}
