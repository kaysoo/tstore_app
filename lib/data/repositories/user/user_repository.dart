import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tstore_app/data/repositories/repositories_authentication/authentication_repository.dart';
import 'package:tstore_app/features/personalization/models/user_model.dart';

class UserRepository extends GetxController {
  static UserRepository get instance => Get.find();

  final FirebaseFirestore _db = FirebaseFirestore.instance;

  //function to save user data to firestore
  Future<void> saveNewUserRecord(UserModel user) async {
    try {
      await _db.collection("Users").doc(user.id).set(user.toJson());
    }
    // on FirebaseAuthException catch (e){
    //   throw TFirebaseException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw const TFormatException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw TPlatformException(e.code).message;
    // }
    catch (e) {
      throw 'Something went wrong, Please try again --- $e';
    }
  }

  //function to fetch user details
  Future<UserModel> fetchUserDetails() async {
    try {
      final documentSnapshot = await _db
          .collection('Users')
          .doc(AuthenticationRespository.instance.authUser?.uid)
          .get();
      if (documentSnapshot.exists) {
        return UserModel.fromSnapshot(documentSnapshot);
      } else {
        return UserModel.empty();
      }
    }
    // on FirebaseAuthException catch (e){
    //   throw TFirebaseException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw const TFormatException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw TPlatformException(e.code).message;
    // }
    catch (e) {
      throw 'Something went wrong, Please try again --- $e';
    }
  }

  // function to update user data in firestore
  Future<void> updateUserDetails(UserModel updateUser) async {
    try {
      await _db.collection("Users").doc(updateUser.id).set(updateUser.toJson());
    }
    // on FirebaseAuthException catch (e){
    //   throw TFirebaseException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw const TFormatException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw TPlatformException(e.code).message;
    // }
    catch (e) {
      throw 'Something went wrong, Please try again --- $e';
    }
  }

  //update any field in specific users collection
  Future<void> updateSingleField(Map<String, dynamic> json) async {
    try {
      await _db
          .collection("Users")
          .doc(AuthenticationRespository.instance.authUser?.uid)
          .update(json);
    }
    // on FirebaseAuthException catch (e){
    //   throw TFirebaseException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw const TFormatException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw TPlatformException(e.code).message;
    // }
    catch (e) {
      throw 'Something went wrong, Please try again --- $e';
    }
  }

  //function to remove data from firestore
  Future<void> removeUserRecord(String userID) async {
    try {
      await _db.collection("Users").doc(userID).delete();
    }
    // on FirebaseAuthException catch (e){
    //   throw TFirebaseException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw const TFormatException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw TPlatformException(e.code).message;
    // }
    catch (e) {
      throw 'Something went wrong, Please try again --- $e';
    }
  }

  //upload any image
  Future<String> uploadImage(String path, XFile image) async {
    try {
      final ref = FirebaseStorage.instance.ref(path).child(image.name);
      await ref.putFile(File(image.path));
      final url = await ref.getDownloadURL();
      return url;
    } // on FirebaseAuthException catch (e){
    //   throw TFirebaseException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw const TFormatException(e.code).message;
    // }
    // on FirebaseAuthException catch (e){
    //   throw TPlatformException(e.code).message;
    // }
    catch (e) {
      throw 'Something went wrong, Please try again --- $e';
    }
  }
}
