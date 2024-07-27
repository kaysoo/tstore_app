import 'package:get/get.dart';
import 'package:tstore_app/features/shop/controllers/cart_controller.dart';
import 'package:tstore_app/features/shop/controllers/product/images_controller.dart';
import 'package:tstore_app/features/shop/models/product_model.dart';
import 'package:tstore_app/features/shop/models/product_variations_model.dart';

class VariationController extends GetxController {
  static VariationController get instance => Get.find();

  //variables
  RxMap selectedAttributes = {}.obs;
  RxString variationStockStatus = ''.obs;
  Rx<ProductVariationModel> selectedVariation =
      ProductVariationModel.empty().obs;

  //select attribute and variation
  void onAttributeSelected(
      ProductModel product, attributeName, attributeValue) {
    //when attribute is selected, first add that attribute to the selectedAttributes
    final selectedAttributes =
        Map<String, dynamic>.from(this.selectedAttributes);
    selectedAttributes[attributeName] = attributeValue;

    final selectedVariation = product.productVariations!.firstWhere(
      (variation) =>
          _isSameAttributeValue(variation.attributeValues, selectedAttributes),
      orElse: () => ProductVariationModel.empty(),
    );

    //show selected variation image s a main image
    if (selectedVariation.image.isNotEmpty) {
      ImagesController.instance.selectedProductImage.value =
          selectedVariation.image;
    }

    if (selectedVariation.id.isNotEmpty) {
      final cartController = CartController.instance;
      cartController.productQuantityInCart.value = cartController
          .getVariationQuantityInCart(product.id, selectedVariation.id);
    }

    //assign selected variation
    this.selectedVariation.value = selectedVariation;

    //update selected product variation status
    getProductVariationStockStatus();
  }

  //check if selected attributes match any variation attributes
  bool _isSameAttributeValue(Map<String, dynamic> variationAttributes,
      Map<String, dynamic> selectedAttributes) {
    //if selected attributes  contains 3 attributes adn current variation contains 2 then return.
    if (variationAttributes.length != selectedAttributes.length) return false;

    //if any of the attributes is different then return. eg. [Green, Large] x [Green , Small]
    for (final key in variationAttributes.keys) {
      //attributes[key] = value which could be [Green, Small, Cotton] etc.
      if (variationAttributes[key] != selectedAttributes[key]) return false;
    }

    return true;
  }

  //check attribute availability / stock in variation
  Set<String?> getAttributesAvailabilityInVariation(
      List<ProductVariationModel> variations, String attributeName) {
    //pass the variations to check which attributes are available in stock
    final availableVariationAttributeValues = variations
        .where((variation) =>
            //check empty / out of stock attributes
            variation.attributeValues[attributeName] != null &&
            variation.attributeValues[attributeName]!.isNotEmpty &&
            variation.stock > 0)
        //fetch all non empty attributes of variations
        .map((variation) => variation.attributeValues[attributeName])
        .toSet();

    return availableVariationAttributeValues;
  }

  String getVariationPrice() {
    return (selectedVariation.value.salePrice > 0
            ? selectedVariation.value.salePrice
            : selectedVariation.value.price)
        .toString();
  }

  //check product variation stock status
  void getProductVariationStockStatus() {
    variationStockStatus.value =
        selectedVariation.value.stock > 0 ? 'In Stock' : 'Out of Stock';
  }

  //reset selected attributes when switching products
  void resetSelectedAttributes() {
    selectedAttributes.clear();
    variationStockStatus.value = '';
    selectedVariation.value = ProductVariationModel.empty();
  }
}
