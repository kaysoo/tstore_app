import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/common/widgets/icon/t_circular_icon.dart';
import 'package:tstore_app/features/shop/controllers/product/favourite_controller.dart';
import 'package:tstore_app/utils/constants/colors.dart';

class TFavouriteIcon extends StatelessWidget {
  const TFavouriteIcon({
    super.key,
    required this.dark,
    required this.productID,
  });

  final bool dark;
  final String productID;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FavouriteController());
    return Obx(
      () => TCircularIcon(
        onPressed: () => controller.toggleFavoriteProduct(productID),
        dark: dark,
        icon:
            controller.isFavourite(productID) ? Iconsax.heart5 : Iconsax.heart,
        color: controller.isFavourite(productID) ? TColors.error : null,
      ),
    );
  }
}
