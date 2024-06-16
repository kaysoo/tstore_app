import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/products_cart/add_remove.dart';
import 'package:tstore_app/common/widgets/text/product_price_text.dart';
import 'package:tstore_app/features/shop/screens/cart/components/cart_item.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class TCartItems extends StatelessWidget {
  const TCartItems({
    super.key,
    this.showaddremovebuttons = true,
  });

  final bool showaddremovebuttons;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return ListView.separated(
      shrinkWrap: true,
      separatorBuilder: (_, __) => const SizedBox(
        height: TSizes.spaceBtwSections,
      ),
      itemCount: 4,
      itemBuilder: (_, index) => Column(
        children: [
          const TCartItem(),
          if (showaddremovebuttons)
            const SizedBox(
              height: TSizes.spaceBtwItems,
            ),
          if (showaddremovebuttons)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    const SizedBox(
                      width: 70,
                    ),

                    /// add and remove buttons
                    TProductQuantityWithAddRow(dark: dark),
                  ],
                ),
                const TProductPriceText(price: "225")
              ],
            )
        ],
      ),
    );
  }
}
