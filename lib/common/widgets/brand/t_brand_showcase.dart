import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/brand/t_brand_card.dart';
import 'package:tstore_app/common/widgets/containers/rounded_container.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class TBrandProductShowCase extends StatelessWidget {
  const TBrandProductShowCase({
    super.key,
    required this.dark,
    required this.images,
  });

  final bool dark;
  final List<String> images;

  @override
  Widget build(BuildContext context) {
    return RoundedContainer(
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
              image: TImages.shoeIcon,
              textDescription: 'Best sneakers available',
              title: "Nike"),
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
    );
  }

  Widget brandTopProductImageWidget(String image, context) {
    return Expanded(
        child: RoundedContainer(
      // height: 100,
      backgroundColor: dark ? TColors.darkGrey : TColors.light,
      margin: const EdgeInsets.only(right: TSizes.sm),
      padding: const EdgeInsets.only(right: TSizes.sm),
      child: Image(
        image: AssetImage(image),
        fit: BoxFit.contain,
      ),
    ));
  }
}
