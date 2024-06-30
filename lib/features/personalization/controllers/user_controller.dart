import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tstore_app/data/repositories/repositories_authentication/authentication_repository.dart';
import 'package:tstore_app/data/repositories/user/user_repository.dart';
import 'package:tstore_app/features/authentication/screens/login/login.dart';
import 'package:tstore_app/features/personalization/models/user_model.dart';
import 'package:tstore_app/features/personalization/screens/profile/components/re_authenticate_user_form.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/network_manager.dart';
import 'package:tstore_app/utils/popups/full_screen_loader.dart';
import 'package:tstore_app/utils/popups/loader.dart';

class UserController extends GetxController {
  static UserController get instance => Get.find();

  final userRepository = Get.put(UserRepository());
  Rx<UserModel> user = UserModel.empty().obs;
  final profileLoading = false.obs;

  final hidePassword = false.obs;
  final imageUploading = false.obs;
  final verifyEmail = TextEditingController();
  final verifyPassword = TextEditingController();
  GlobalKey<FormState> reAuthFormKey = GlobalKey<FormState>();

  @override
  void onInit() {
    super.onInit();
    fetchUserRecord();
  }

  //fetch user record
  Future<void> fetchUserRecord() async {
    try {
      profileLoading.value = true;
      final user = await userRepository.fetchUserDetails();
      this.user(user);
    } catch (e) {
      user(UserModel.empty());
    } finally {
      profileLoading.value = false;
    }
  }

  //save user record from any registration provider
  Future<void> saveUserRecord(UserCredential? userCredentials) async {
    try {
      //refresh user record
      await fetchUserRecord();
      if (user.value.id.isEmpty) {
        if (userCredentials != null) {
          //convert name to first and last name
          final nameParts =
              UserModel.nameParts(userCredentials.user!.displayName ?? '');
          final username = UserModel.generateUsername(
              userCredentials.user!.displayName ?? '');

          //map data
          final user = UserModel(
              id: userCredentials.user!.uid,
              firstName: nameParts[0],
              lastName:
                  nameParts.length > 1 ? nameParts.sublist(1).join('') : '',
              userName: username,
              email: userCredentials.user!.email ?? '',
              phoneNumber: userCredentials.user!.phoneNumber ?? '',
              profilePicture: userCredentials.user!.photoURL ?? '');

          //save user data
          await userRepository.saveNewUserRecord(user);
        }
      }
    } catch (e) {
      TLoaders.warningSnackBar(
          title: 'Data not saved',
          message:
              'Something went wrong while saving your information. You can re-save your data in your Profile');
    }
  }

  //delete account warning
  void deleteAccountWarningPopup() {
    Get.defaultDialog(
        contentPadding: const EdgeInsets.all(TSizes.md),
        title: 'Delete Account',
        middleText:
            'Are you sure you want to delete your account permanently? This action is not reversible and all of your data will be removed permanently.',
        confirm: ElevatedButton(
            onPressed: () async => deleteUserAccount(),
            style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                side: const BorderSide(color: Colors.red)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: TSizes.lg),
              child: Text('Delete'),
            )),
        cancel: OutlinedButton(
            onPressed: () => Navigator.of(Get.overlayContext!).pop(),
            child: const Text('Cancel')));
  }

  //delete user account
  void deleteUserAccount() async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog('Processing...',
          'https://lottie.host/7353556f-a444-4c02-a872-a3555273d683/1px2tjRHKI.json');

      //first re-authenticate user
      final auth = AuthenticationRespository.instance;
      final provider =
          auth.authUser!.providerData.map((e) => e.providerId).first;
      if (provider.isNotEmpty) {
        //re verify auth email
        if (provider == 'google.com') {
          await auth.signInWithGoogle();
          await auth.deleteAccount();
          TFullScreenLoader.stopLoading();
          Get.offAll(() => const LoginScreen());
        } else if (provider == 'password') {
          TFullScreenLoader.stopLoading();
          Get.to(() => const ReAuthenticatLoginForm());
        }
      }
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.warningSnackBar(title: 'On Snap', message: e.toString());
    }
  }

  //reauthenticate before deleting
  Future<void> reAuthenticateEmailandPasswordUser() async {
    try {
      //start loading
      TFullScreenLoader.openLoadingDialog('Processing...',
          'https://lottie.host/7353556f-a444-4c02-a872-a3555273d683/1px2tjRHKI.json');

      //check internet
      final isConnected = await NetworkManager.instance.isConnected();
      if (!isConnected) {
        TFullScreenLoader.stopLoading();
        return;
      }

      //auth form
      if (!reAuthFormKey.currentState!.validate()) {
        TFullScreenLoader.stopLoading();
      }

      await AuthenticationRespository.instance
          .reAuthenticatewithEmailandPassword(
              verifyEmail.text.trim(), verifyPassword.text.trim());
      await AuthenticationRespository.instance.deleteAccount();
      TFullScreenLoader.stopLoading();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      TFullScreenLoader.stopLoading();
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    }
  }

  //upload profile picture
  UploadUserProfilePicture() async {
    try {
      final image = await ImagePicker().pickImage(
          source: ImageSource.gallery,
          imageQuality: 70,
          maxHeight: 512,
          maxWidth: 512);
      if (image != null) {
        imageUploading.value = true;
        final imageurl =
            await userRepository.uploadImage('Users/Images/Profile/', image);

        //update user image record
        Map<String, dynamic> json = {'ProfilePicture': imageurl};
        await userRepository.updateSingleField(json);

        user.value.profilePicture = imageurl;
        user.refresh();

        TLoaders.successSnackBar(
            title: 'Congratulations',
            message: 'Profile picture updated successfully.');
      }
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap', message: e.toString());
    } finally {
      imageUploading.value = false;
    }
  }
}
