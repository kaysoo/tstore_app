import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tstore_app/features/shop/models/brand_model.dart';

class BrandRepository extends GetxController {
  static BrandRepository get instance => Get.find();

  //variables
  final _db = FirebaseFirestore.instance;

  //get all categories
  Future<List<BrandModel>> getAllBrands() async {
    try {
      final snapshot = await _db.collection('Brands').get();
      final result =
          snapshot.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return result;
    } catch (e) {
      throw 'Something went wrong....';
    }
  }

  //get all categories
  Future<List<BrandModel>> getBrandsForCategory(String categoryId) async {
    try {
      //query to get all documents where categoryid matches the provided categoryid
      QuerySnapshot brandCategoryQuery = await _db
          .collection('BrandCategory')
          .where('categoryId', isEqualTo: categoryId)
          .get();

      //extract brand ids from the documents
      List<String> brandIds = brandCategoryQuery.docs
          .map((doc) => doc['brandId'] as String)
          .toList();

      //query to get all documents where the brandid is in the list of brandids
      final brandQuery = await _db
          .collection('Brands')
          .where(FieldPath.documentId, whereIn: brandIds)
          .limit(2)
          .get();

      //extract brand names or other relevant data from the documents
      List<BrandModel> brands =
          brandQuery.docs.map((e) => BrandModel.fromSnapshot(e)).toList();
      return brands;
    } catch (e) {
      throw 'Something went wrong....';
    }
  }

  //get brands for category
}
