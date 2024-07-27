import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/curved_edges/curved_widget.dart';
import 'package:tstore_app/common/widgets/icon/t_circular_icon.dart';
import 'package:tstore_app/common/widgets/image/t_image_rounded.dart';
import 'package:tstore_app/common/widgets/products_cart/favourite_icon.dart';
import 'package:tstore_app/features/shop/controllers/product/images_controller.dart';
import 'package:tstore_app/features/shop/models/product_model.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class TProductImagesSlider extends StatelessWidget {
  const TProductImagesSlider({
    super.key,
    required this.product,
  });

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(ImagesController());
    final images = controller.getAllProductImages(product);

    return CurvedEdgesWidget(
      child: Container(
        color: dark ? TColors.darkGrey : TColors.light,
        child: Stack(
          children: [
            SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                  child: Center(child: Obx(() {
                    return GestureDetector(
                      onTap: () => controller.showEnlargedImage(
                          controller.selectedProductImage.value),
                      child: CachedNetworkImage(
                        imageUrl: controller.selectedProductImage.value,
                        progressIndicatorBuilder: (_, __, downloadProgress) =>
                            CircularProgressIndicator(
                          value: downloadProgress.progress,
                          color: TColors.primary,
                        ),
                      ),
                    );
                  })),
                )),

            ///image slider
            Positioned(
              right: 0,
              bottom: 20,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: images.length,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  itemBuilder: (_, index) => Obx(
                    () {
                      final imageSelected =
                          controller.selectedProductImage.value ==
                              images[index];
                      return TRoundedImage(
                        onPressed: () => controller.selectedProductImage.value =
                            images[index],
                        imageUrl: images[index],
                        width: 80,
                        isNetworkImage: true,
                        backgroundcolor: dark ? TColors.dark : TColors.white,
                        border: Border.all(
                            color: imageSelected
                                ? TColors.primary
                                : Colors.transparent),
                        padding: EdgeInsets.all(TSizes.sm),
                      );
                    },
                  ),
                ),
              ),
            ),
            //appbar icons
            CustomAppBar(
              shoeBackArrow: true,
              actions: [
                TFavouriteIcon(
                  dark: dark,
                  productID: product.id,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
