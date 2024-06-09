import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/products_cart/cart_menu_icon.dart';
import 'package:tstore_app/features/shop/screens/cart/cart.dart';
import 'package:tstore_app/utils/constants/colors.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomAppBar(
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Good day for shopping",
            style: Theme.of(context)
                .textTheme
                .labelMedium!
                .apply(color: TColors.grey),
          ),
          Text(
            "Kofi Sarfo ",
            style: Theme.of(context)
                .textTheme
                .headlineSmall!
                .apply(color: TColors.white),
          ),
        ],
      ),
      actions: [
        TCartCounterIcon(
          iconColor: TColors.white,
          onPressed: () => Get.to(() => const CartScreen()),
        )
      ],
    );
  }
}
