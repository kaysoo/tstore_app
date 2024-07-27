import 'dart:convert';

import 'package:get/get.dart';
import 'package:tstore_app/data/repositories/products/product_repository.dart';
import 'package:tstore_app/features/shop/models/product_model.dart';
import 'package:tstore_app/utils/local_storage/storage_utility.dart';
import 'package:tstore_app/utils/popups/loader.dart';

class FavouriteController extends GetxController {
  static FavouriteController get instance => Get.find();

  //variables
  final favorites = <String, bool>{}.obs;

  @override
  void onInit() {
    super.onInit();
    initFavorites();
  }

  //method to initialize favourites by reading from storage
  Future<void> initFavorites() async {
    final json = TLocalStorage.instance().readData('favorites');
    if (json != null) {
      final storedFavorites = jsonDecode(json) as Map<String, dynamic>;
      favorites.assignAll(
          storedFavorites.map((key, value) => MapEntry(key, value as bool)));
    }
  }

  bool isFavourite(String productID) {
    return favorites[productID] ?? false;
  }

  //toggle favorite product in localstorage
  void toggleFavoriteProduct(String productID) {
    if (!favorites.containsKey(productID)) {
      favorites[productID] = true;
      saveFavoriteToStorage();
      TLoaders.customToast(message: 'Product has been added to the WishList.');
    } else {
      TLocalStorage.instance().removeData(productID);
      favorites.remove(productID);
      saveFavoriteToStorage();
      favorites.refresh();
      TLoaders.customToast(
          message: 'Product has been removed from the WishList.');
    }
  }

  void saveFavoriteToStorage() {
    final encodedFavorites = json.encode(favorites);
    TLocalStorage.instance().saveDate('favorites', encodedFavorites);
  }

  //get the products from firebase
  Future<List<ProductModel>> favoriteProducts() async {
    return await ProductRepository.instance
        .getFavoriteProducts(favorites.keys.toList());
  }
}
