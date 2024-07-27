import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/bottom_navigation.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/loaders/animation_loader.dart';
import 'package:tstore_app/features/shop/controllers/cart_controller.dart';
import 'package:tstore_app/features/shop/screens/cart/components/cart_items_listview.dart';
import 'package:tstore_app/features/shop/screens/checkout/checkout.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = CartController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Cart',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        shoeBackArrow: true,
      ),
      body: Obx(
        () {
          //nothing found widget
          final emptyWidget = TAnimationLoaderWidget(
            text: 'Whoops! Cart is empty.',
            animation:
                'https://lottie.host/9ab45713-7954-4376-9f38-b8fc4b7ed8f9/tFNBpbaoAv.json',
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const BottomNavigation()),
          );
          if (controller.cartItems.isEmpty) {
            return emptyWidget;
          } else {
            return const SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(TSizes.defaultSpace),
                child: TCartItems(),
              ),
            );
          }
        },
      ),
      bottomNavigationBar: controller.cartItems.isEmpty
          ? const SizedBox()
          : Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: ElevatedButton(
                onPressed: () => Get.to(() => const CheckoutScreen()),
                child: Obx(() =>
                    Text("Checkout \$${controller.totalCartPrice.value}")),
              ),
            ),
    );
  }
}
