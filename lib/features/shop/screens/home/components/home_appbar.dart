import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer_loader.dart';
import 'package:tstore_app/common/widgets/products_cart/cart_menu_icon.dart';
import 'package:tstore_app/features/personalization/controllers/user_controller.dart';
import 'package:tstore_app/features/shop/screens/cart/cart.dart';
import 'package:tstore_app/utils/constants/colors.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UserController());
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
          Obx(
            () {
              if (controller.profileLoading.value) {
                return const TShimmerLoader(
                  width: 80,
                  height: 15,
                );
              } else {
                return Text(
                  controller.user.value.fullname,
                  style: Theme.of(context)
                      .textTheme
                      .headlineSmall!
                      .apply(color: TColors.white),
                );
              }
            },
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
