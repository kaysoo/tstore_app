import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:tstore_app/bottom_navigation.dart';
import 'package:tstore_app/data/repositories/user/user_repository.dart';
import 'package:tstore_app/features/authentication/screens/login/login.dart';
import 'package:tstore_app/features/authentication/screens/onboarding/onboarding.dart';
import 'package:tstore_app/features/authentication/screens/signup/verify_email.dart';
import 'package:tstore_app/utils/exceptions/firebase_auth_exceptions.dart';
import 'package:tstore_app/utils/popups/loader.dart';

class AuthenticationRespository extends GetxController {
  static AuthenticationRespository get instance => Get.find();

  //variables
  final deviceStorage = GetStorage();
  final _auth = FirebaseAuth.instance;

  //get authenticated user data
  User? get authUser => _auth.currentUser;

  //called from main.dart on app launch
  @override
  void onReady() {
    FlutterNativeSplash.remove();
    screenRedirect();
  }

  //function to show relevant screen
  screenRedirect() async {
    final user = _auth.currentUser;
    if (user != null) {
      if (user.emailVerified) {
        Get.offAll(() => const BottomNavigation());
      } else {
        Get.offAll(() => VerifyEmailScreen(
              email: _auth.currentUser?.email,
            ));
      }
    } else {
      //local storage
      deviceStorage.writeIfNull('isFirstTime', true);
      deviceStorage.read('isFirstTime') != true
          ? Get.offAll(() => const LoginScreen())
          : Get.offAll(() => const OnboardingScreen());
    }
  }

  //------------email and password sign in-----------------//

  //email authentication--------sign in
  Future<UserCredential> loginWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    }
    // on FirebaseAuthException catch (e){
    //   throw TFirebaseException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw const TFormalException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw TPlatformException(e.code).message;
    // }
    catch (e) {
      throw 'Something went wrong. Please try again --- $e';
    }
  }

  //email authentication ------------register
  Future<UserCredential> registerWithEmailAndPassword(
      String email, String password) async {
    try {
      return await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
    }
    //  on FirebaseAuthException catch (e) {
    //   throw TFirebaseAuthException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw TFirebaseException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw const TFormalException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw TPlatformException(e.code).message;
    // }
    catch (e) {
      throw 'Something went wrong. Please try again --- $e';
    }
  }

  //email authentication ------------reauthenticate user

  //email authentication ------------mail verification
  Future<void> sendEmailVerification() async {
    try {
      await _auth.currentUser?.sendEmailVerification();
    }
    //  on FirebaseAuthException catch (e) {
    //   throw TFirebaseAuthException(e.code).message;
    // }
    catch (e) {
      throw 'Something went wrong. Please try again --- $e';
    }
  }

  //email authentication ------------forgot password
  Future<void> sendPasswordResetEmail(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    }
    // on FirebaseAuthException catch (e){
    //   throw TFirebaseException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw const TFormalException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw TPlatformException(e.code).message;
    // }
    catch (e) {
      throw 'Something went wrong. Please try again --- $e';
    }
  }

  /*--------------social sign in---------*/

  //google authentication----google
  Future<UserCredential?> signInWithGoogle() async {
    try {
      //Trigger authentication flow -----pop up with google accounts
      final GoogleSignInAccount? userAccount = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await userAccount?.authentication;

      //create new credential
      final credentials = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

      //once signed in, return the userCredential
      return await _auth.signInWithCredential(credentials);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    }
    // on FirebaseAuthException catch (e){
    //   throw TFirebaseException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw const TFormalException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw TPlatformException(e.code).message;
    // }
    catch (e) {
      throw 'Something went wrong. Please try again ---$e';
    }
  }

  //google authentication----facebook

  //logout user -------valid for any authentication
  Future<void> logout() async {
    try {
      await GoogleSignIn().signOut();
      await FirebaseAuth.instance.signOut();
      Get.offAll(() => const LoginScreen());
    } catch (e) {
      throw 'Someting went wrong. Please try again, error: $e';
    }
  }

  //re authenticate user
  Future<void> reAuthenticatewithEmailandPassword(
      String email, String password) async {
    try {
      //create credential
      AuthCredential credential =
          EmailAuthProvider.credential(email: email, password: password);

      //re-authenticate
      await _auth.currentUser!.reauthenticateWithCredential(credential);
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    }
    // on FirebaseAuthException catch (e){
    //   throw TFirebaseException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw const TFormalException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw TPlatformException(e.code).message;
    // }
    catch (e) {
      throw 'Something went wrong. Please try again ---$e';
    }
  }

  //delete user -------remove user auth and firestore account
  Future<void> deleteAccount() async {
    try {
      await UserRepository.instance.removeUserRecord(_auth.currentUser!.uid);
      await _auth.currentUser?.delete();
    } on FirebaseAuthException catch (e) {
      throw TFirebaseAuthException(e.code).message;
    }
    // on FirebaseAuthException catch (e){
    //   throw TFirebaseException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw const TFormalException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw TPlatformException(e.code).message;
    // }
    catch (e) {
      throw 'Something went wrong. Please try again --- $e';
    }
  }
}
