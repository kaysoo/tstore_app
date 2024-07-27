import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/common/widgets/products_cart/add_remove.dart';
import 'package:tstore_app/common/widgets/text/product_price_text.dart';
import 'package:tstore_app/features/shop/controllers/cart_controller.dart';
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
    final controller = CartController.instance;
    final dark = THelperFunctions.isDarkMode(context);

    return Obx(
      () => ListView.separated(
        shrinkWrap: true,
        separatorBuilder: (_, __) => const SizedBox(
          height: TSizes.spaceBtwSections,
        ),
        itemCount: controller.cartItems.length,
        itemBuilder: (_, index) => Obx(
          () {
            final item = controller.cartItems[index];
            return Column(
              children: [
                TCartItem(
                  cartItem: item,
                ),
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
                          TProductQuantityWithAddRow(
                            dark: dark,
                            quantity: item.quantity,
                            add: () => controller.addOneToCart(item),
                            remove: () => controller.removeOneFromCart(item),
                          ),
                        ],
                      ),
                      TProductPriceText(
                          price:
                              (item.price * item.quantity).toStringAsFixed(2))
                    ],
                  )
              ],
            );
          },
        ),
      ),
    );
  }
}
