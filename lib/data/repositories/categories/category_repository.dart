import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tstore_app/features/shop/models/category_model.dart';

class CategoryRepository extends GetxController {
  static CategoryRepository get instance => Get.find();

  //variables
  final _db = FirebaseFirestore.instance;

  // get all categories
  Future<List<CategoryModel>> getAllCategories() async {
    try {
      final snapshot = await _db.collection('Categories').get();
      final list = snapshot.docs
          .map((document) => CategoryModel.fromSnapshot(document))
          .toList();
      return list;
    } catch (e) {
      throw 'Something went wrong -- $e';
    }
  }

  //get sub categories
  Future<List<CategoryModel>> getSubCategories(String categoryId) async {
    try {
      final snapshot = await _db
          .collection('Categories')
          .where('ParentId', isEqualTo: categoryId)
          .get();
      final result =
          snapshot.docs.map((e) => CategoryModel.fromSnapshot(e)).toList();
      return result;
    } catch (e) {
      throw 'Something went wrong. Please try again. --- error : $e';
    }
  }

  // upload categories to the cloud firebase
  // Future<void> uploadDummyData(List<CategoryModel> categories) async{
  //   try{
  //     //upload all categories along their images
  //     final storage = Get.put(TFirebaseStorageService());

  //     //loop through each category
  //     for(var category in categories){
  //       //get imagedata link from local assets
  //       final file  = await storage.getImageDataFromAssets(category.image);

  //       //upload image and get its url
  //       final url = await storage.uploadImageData('Categories',file,category.name);

  //       //assign url to category image attribute
  //        category.image = url;

  //        //store category in firestore
  //        await _db.collection('Categories').doc(category.id).set(category.toJson());
  //     }
  //   }catch(e){
  //     throw 'Something went wrong. Please try again. --- error : $e';
  //   }
  // }
}
