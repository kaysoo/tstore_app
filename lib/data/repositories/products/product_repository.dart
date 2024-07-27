import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:tstore_app/features/shop/models/product_model.dart';

class ProductRepository extends GetxController {
  static ProductRepository get instance => Get.find();

  // firestore instance for database interactions
  final _db = FirebaseFirestore.instance;

  //get limited featured  featured products
  Future<List<ProductModel>> getFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .limit(4)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw 'Something went wrong.Please try again. error --- $e';
    }
  }

  //get all featured products
  Future<List<ProductModel>> getAllFeaturedProducts() async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where('IsFeatured', isEqualTo: true)
          .get();
      return snapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
    } catch (e) {
      throw 'Something went wrong.Please try again. error --- $e';
    }
  }

  //get products based on brand
  Future<List<ProductModel>> fetchProductsByQuery(Query query) async {
    try {
      final querySnapshot = await query.get();
      final List<ProductModel> productList = querySnapshot.docs
          .map((doc) => ProductModel.fromQuerySnapshot(doc))
          .toList();
      return productList;
    } catch (e) {
      throw 'Something went wrong.Please try again. error --- $e';
    }
  }

  //get products based on brand
  Future<List<ProductModel>> getFavoriteProducts(
      List<String> productIds) async {
    try {
      final snapshot = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();
      return snapshot.docs
          .map((querySnapshot) => ProductModel.fromSnapshot(querySnapshot))
          .toList();
    } catch (e) {
      throw 'Something went wrong.Please try again. error --- $e';
    }
  }

  //get products based on specific brand
  Future<List<ProductModel>> getProductsForBrand(
      {required String brandID, int limit = -1}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandID)
              .get()
          : await _db
              .collection('Products')
              .where('Brand.Id', isEqualTo: brandID)
              .limit(limit)
              .get();
      final products =
          querySnapshot.docs.map((e) => ProductModel.fromSnapshot(e)).toList();
      return products;
    } catch (e) {
      throw 'Something went wrong.Please try again. error --- $e';
    }
  }

  //get products for category
  Future<List<ProductModel>> getProductsForCategory(
      {required String categoryId, int limit = 4}) async {
    try {
      final querySnapshot = limit == -1
          ? await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .get()
          : await _db
              .collection('ProductCategory')
              .where('categoryId', isEqualTo: categoryId)
              .limit(limit)
              .get();
      //extract productids from the documents
      List<String> productIds =
          querySnapshot.docs.map((e) => e['productId'] as String).toList();

      //query to get all documents where the brandid is in the list of brandids,fieldpath documentid to query documents
      final productsQuery = await _db
          .collection('Products')
          .where(FieldPath.documentId, whereIn: productIds)
          .get();

      //extract brand names or other relevant data from the documents
      List<ProductModel> products =
          productsQuery.docs.map((e) => ProductModel.fromSnapshot(e)).toList();

      return products;
    } catch (e) {
      throw 'Something went wrong.Please try again. error --- $e';
    }
  }

  //upload dummy data to the cloud firebase
  Future<void> uploadDummyData(List<ProductModel> products) async {}
}
