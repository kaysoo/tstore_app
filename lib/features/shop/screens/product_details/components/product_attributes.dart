import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/chip/choices_chip.dart';
import 'package:tstore_app/common/widgets/containers/rounded_container.dart';
import 'package:tstore_app/common/widgets/text/product_price_text.dart';
import 'package:tstore_app/common/widgets/text/product_title_text.dart';
import 'package:tstore_app/common/widgets/text/section_heading.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Column(
      children: [
        ///selected attribute pricing and description
        RoundedContainer(
          padding: EdgeInsets.all(TSizes.md),
          backgroundColor: dark ? TColors.darkGrey : TColors.grey,
          child: Column(
            children: [
              //title, price and stock status
              Row(
                children: [
                  const TSectionHeading(title: "Variation"),
                  const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          const ProductText(
                            title: "Price : ",
                            smallSize: true,
                          ),

                          //actual price
                          Text(
                            "\$25",
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .apply(decoration: TextDecoration.lineThrough),
                          ),

                          const SizedBox(
                            width: TSizes.spaceBtwItems,
                          ),

                          //sale price
                          const TProductPriceText(price: '20'),
                        ],
                      ),

                      ///stock
                      Row(
                        children: [
                          const ProductText(
                            title: "Stock : ",
                            smallSize: true,
                          ),
                          Text(
                            "In Stock",
                            style: Theme.of(context).textTheme.titleMedium,
                          )
                        ],
                      )
                    ],
                  ),
                ],
              ),

              /// variation description
              const ProductText(
                title:
                    "This is the Description of the Product and it can go upto max 4 lines.",
                smallSize: true,
                maxLines: 4,
              )
            ],
          ),
        ),
        const SizedBox(
          height: TSizes.spaceBtwItems,
        ),

        //attributes
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: "Colors"),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(
                  selected: false,
                  text: "Green",
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  selected: true,
                  text: "Blue",
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  selected: false,
                  text: "Yellow",
                  onSelected: (value) {},
                ),
              ],
            )
          ],
        ),

        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const TSectionHeading(title: "Size"),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            Wrap(
              spacing: 8,
              children: [
                TChoiceChip(
                  selected: false,
                  text: "EU 39",
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  selected: true,
                  text: "EU 41",
                  onSelected: (value) {},
                ),
                TChoiceChip(
                  selected: false,
                  text: "EU 44",
                  onSelected: (value) {},
                ),
              ],
            )
          ],
        )
      ],
    );
  }
}
