import 'package:cloud_firestore/cloud_firestore.dart';

class BrandModel {
  String id;
  String name;
  String image;
  bool? isFeatured;
  int? productsCount;

  BrandModel(
      {required this.id,
      required this.image,
      required this.name,
      this.isFeatured,
      this.productsCount});

  //empty helper function
  static BrandModel empty() => BrandModel(id: '', image: '', name: '');

  //convert to json for storage in firebase
  toJson() {
    return {
      "Id": id,
      "Name": name,
      "Image": image,
      "ProductsCount": productsCount,
      "IsFeatured": isFeatured
    };
  }

  //map json oriented document snapshot from firebase usermodel
  factory BrandModel.fromJson(Map<String, dynamic> document) {
    final data = document;
    if (data.isEmpty) {
      return BrandModel.empty();
    }
    return BrandModel(
        id: data['Id'] ?? '',
        image: data["Image"] ?? '',
        name: data["Name"] ?? '',
        productsCount: data["ProductsCount"] ?? '',
        isFeatured: data["IsFeatured"] ?? '');
  }

  //map json oriented document snapshot from firebase to model
  factory BrandModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    if (document.data() == null) {
      return BrandModel.empty();
    }
    final data = document.data()!;
    return BrandModel(
        id: document.id,
        image: data['Image'] ?? '',
        name: data['Name'] ?? '',
        isFeatured: data['IsFeatured'] ?? false,
        productsCount: data['ProductCount'] ?? '');
  }
}
