import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/containers/rounded_container.dart';
import 'package:tstore_app/common/widgets/image/t_circular_image.dart';
import 'package:tstore_app/common/widgets/text/brand_title_text_with_verifyicon.dart';
import 'package:tstore_app/common/widgets/text/product_price_text.dart';
import 'package:tstore_app/common/widgets/text/product_title_text.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/enums.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

import '../../../../../utils/constants/sizes.dart';

class TProductMetaData extends StatelessWidget {
  const TProductMetaData({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            //sale tag
            RoundedContainer(
              radius: TSizes.sm,
              backgroundColor: TColors.secondary.withOpacity(0.8),
              padding: const EdgeInsets.symmetric(
                  horizontal: TSizes.sm, vertical: TSizes.xs),
              child: Text(
                '25%',
                style: Theme.of(context)
                    .textTheme
                    .labelLarge!
                    .apply(color: TColors.black),
              ),
            ),

            //price
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              '\$250',
              style: Theme.of(context)
                  .textTheme
                  .titleSmall!
                  .apply(decoration: TextDecoration.lineThrough),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            TProductPriceText(
              price: '\$175',
              isLarge: true,
            ),
          ],
        ),

        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),
        //title
        const ProductText(title: 'Yellow Nike SB Low'),
        const SizedBox(
          height: TSizes.spaceBtwItems / 1.5,
        ),

        //Stock status
        Row(
          children: [
            const ProductText(title: 'Status'),
            const SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Text(
              "In Stock",
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 1.5,
            ),
          ],
        ),

        //brand
        Row(
          children: [
            TCircularImage(
              dark: dark,
              image: TImages.shoeIcon,
              width: 32,
              height: 32,
              overlayColor: dark ? TColors.white : TColors.black,
            ),
            const TBrandTitlewithVerifyIcon(
              title: 'Nike',
              brandTextSize: TextSizes.medium,
            ),
          ],
        )
      ],
    );
  }
}
