import 'package:get/get.dart';
import 'package:tstore_app/data/repositories/brands/brands_repository.dart';
import 'package:tstore_app/data/repositories/products/product_repository.dart';
import 'package:tstore_app/features/shop/models/brand_model.dart';
import 'package:tstore_app/features/shop/models/product_model.dart';
import 'package:tstore_app/utils/popups/loader.dart';

class BrandController extends GetxController {
  static BrandController get instance => Get.find();

  final RxList<BrandModel> allBrands = <BrandModel>[].obs;
  final RxList<BrandModel> featuredBrands = <BrandModel>[].obs;
  final brandRepository = Get.put(BrandRepository());
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    getFeaturedBrands();
    super.onInit();
  }

  // load brands
  Future<void> getFeaturedBrands() async {
    try {
      isLoading.value = true;

      final brands = await brandRepository.getAllBrands();

      allBrands.assignAll(brands);

      featuredBrands.assignAll(
          allBrands.where((brand) => brand.isFeatured ?? false).take(4));
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
    } finally {
      //stop loading
      isLoading.value = false;
    }
  }

  //get brands for category
  Future<List<BrandModel>> getBrandForCategory(String categoryId) async {
    try {
      final brands = await brandRepository.getBrandsForCategory(categoryId);
      return brands;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }

  // get brand specific products from your data source
  Future<List<ProductModel>> getBrandProducts(
      {required String brandID, int limit = -1}) async {
    try {
      final products = await ProductRepository.instance
          .getProductsForBrand(brandID: brandID, limit: limit);
      return products;
    } catch (e) {
      TLoaders.errorSnackBar(title: 'Oh Snap!', message: e.toString());
      return [];
    }
  }
}
