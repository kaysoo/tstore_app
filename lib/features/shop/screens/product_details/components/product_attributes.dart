import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/common/widgets/chip/choices_chip.dart';
import 'package:tstore_app/common/widgets/containers/rounded_container.dart';
import 'package:tstore_app/common/widgets/text/product_price_text.dart';
import 'package:tstore_app/common/widgets/text/product_title_text.dart';
import 'package:tstore_app/common/widgets/text/section_heading.dart';
import 'package:tstore_app/features/shop/controllers/product/variation_controller.dart';
import 'package:tstore_app/features/shop/models/product_model.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class ProductAttributes extends StatelessWidget {
  const ProductAttributes({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = Get.put(VariationController());
    return Obx(
      () => Column(
        children: [
          ///selected attribute pricing and description
          //display variation price and stock when some variation is selected
          // if (controller.selectedVariation.value.id.isNotEmpty)
          RoundedContainer(
            padding: const EdgeInsets.all(TSizes.md),
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
                            if (controller.selectedVariation.value.salePrice >
                                0)
                              Text(
                                "\$${controller.selectedVariation.value.price}",
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .apply(
                                        decoration: TextDecoration.lineThrough),
                              ),

                            const SizedBox(
                              width: TSizes.spaceBtwItems,
                            ),

                            //sale price
                            TProductPriceText(
                                price: controller.getVariationPrice()),
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
                              controller.variationStockStatus.value,
                              style: Theme.of(context).textTheme.titleMedium,
                            )
                          ],
                        )
                      ],
                    ),
                  ],
                ),

                /// variation description
                ProductText(
                  title: controller.selectedVariation.value.description ?? '',
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
            children: product.productAttributes!
                .map(
                  (attribute) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TSectionHeading(title: attribute.name ?? ''),
                      const SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      Obx(
                        () => Wrap(
                          spacing: 8,
                          children: attribute.values!.map(
                            (value) {
                              final isSelected = controller
                                      .selectedAttributes[attribute.name] ==
                                  value;
                              final available = controller
                                  .getAttributesAvailabilityInVariation(
                                      product.productVariations!,
                                      attribute.name!)
                                  .contains(value);
                              return TChoiceChip(
                                selected: isSelected,
                                text: value,
                                onSelected: available
                                    ? (selected) {
                                        if (selected && available) {
                                          controller.onAttributeSelected(
                                              product,
                                              attribute.name ?? '',
                                              value);
                                        }
                                      }
                                    : null,
                              );
                            },
                          ).toList(),
                        ),
                      )
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
