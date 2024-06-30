import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/brand/t_brand_showcase.dart';
import 'package:tstore_app/common/widgets/layout/grid_layout.dart';
import 'package:tstore_app/common/widgets/products_cart/product_card_vertical.dart';
import 'package:tstore_app/common/widgets/text/section_heading.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                //brands
                TBrandProductShowCase(
                  dark: dark,
                  images: const [
                    TImages.imageproduct1,
                    TImages.imageproduct2,
                    TImages.imageproduct1
                  ],
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                //products
                TSectionHeading(
                  title: "You might like",
                  onPressed: () {},
                  showActionButton: true,
                ),
                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                TGridLayout(
                    itemCount: 4,
                    itemBuilder: (_, index) => const TProductCardVertical()),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            ),
          ),
        ]);
  }
}
