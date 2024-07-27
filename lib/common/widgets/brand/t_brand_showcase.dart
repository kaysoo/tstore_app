import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/common/widgets/brand/t_brand_card.dart';
import 'package:tstore_app/common/widgets/containers/rounded_container.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/shimmer_loader.dart';
import 'package:tstore_app/features/shop/models/brand_model.dart';
import 'package:tstore_app/features/shop/screens/brands/brand_products.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class TBrandProductShowCase extends StatelessWidget {
  const TBrandProductShowCase({
    super.key,
    required this.dark,
    required this.images,
    required this.brand,
  });

  final bool dark;
  final BrandModel brand;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.to(() => BrandProducts(brand: brand)),
      child: RoundedContainer(
        padding: const EdgeInsets.all(TSizes.md),
        showBorder: true,
        borderColor: TColors.darkGrey,
        backgroundColor: Colors.transparent,
        margin: const EdgeInsets.only(bottom: TSizes.spaceBtwItems),
        child: Column(
          children: [
            TBrandCard(
                showBorder: false,
                dark: dark,
                image: brand.image,
                textDescription: '${brand.productsCount} products',
                title: brand.name),
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),

            //brand product images
            //brand images
            Row(
                children: images
                    .map((image) => brandTopProductImageWidget(image, context))
                    .toList())
          ],
        ),
      ),
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
        child: RoundedContainer(
      // height: 100,
      backgroundColor: dark ? TColors.darkGrey : TColors.light,
      margin: const EdgeInsets.only(right: TSizes.sm),
      padding: const EdgeInsets.only(right: TSizes.sm),
      child: CachedNetworkImage(
        fit: BoxFit.contain,
        imageUrl: image,
        progressIndicatorBuilder: (context, url, progress) =>
            const TShimmerLoader(width: 100, height: 100),
        errorWidget: (context, url, error) => const Icon(Icons.error),
      ),
    ));
  }
}
