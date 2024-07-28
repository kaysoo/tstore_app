import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/bottom_navigation.dart';
import 'package:tstore_app/common/widgets/containers/rounded_container.dart';
import 'package:tstore_app/common/widgets/loaders/animation_loader.dart';
import 'package:tstore_app/features/shop/controllers/product/order_controller.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class TBorderListItems extends StatelessWidget {
  const TBorderListItems({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(OrderController());
    final dark = THelperFunctions.isDarkMode(context);
    return FutureBuilder(
        future: controller.fetchUserOrders(),
        builder: (context, snapshot) {
          final emptyWidget = TAnimationLoaderWidget(
            text: 'Whoops No Orders Yet!!!',
            animation:
                'https://lottie.host/9ab45713-7954-4376-9f38-b8fc4b7ed8f9/tFNBpbaoAv.json',
            showAction: true,
            actionText: 'Let\'s fill it',
            onActionPressed: () => Get.off(() => const BottomNavigation()),
          );

          // check if data exists
          if (snapshot.connectionState == ConnectionState.waiting) {
            return emptyWidget;
          }

          if (!snapshot.hasData ||
              snapshot.data == null ||
              snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No Data Found...'),
            );
          }

          if (snapshot.hasError) {
            return const Center(
              child: Text('Something went wrong...'),
            );
          }

          //products found
          final orders = snapshot.data!;
          return ListView.separated(
              shrinkWrap: true,
              itemCount: orders.length,
              separatorBuilder: (_, __) => const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
              itemBuilder: (_, index) {
                final order = orders[index];
                return RoundedContainer(
                  padding: const EdgeInsets.all(TSizes.md),
                  showBorder: true,
                  backgroundColor: dark ? TColors.dark : TColors.light,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        children: [
                          //icon
                          const Icon(Iconsax.ship),
                          const SizedBox(
                            width: TSizes.spaceBtwItems / 2,
                          ),

                          // status and date
                          Expanded(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  order.orderStatusText,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(
                                          color: TColors.primary,
                                          fontWeightDelta: 1),
                                ),
                                Text(
                                  order.formattedOrderDate,
                                  style:
                                      Theme.of(context).textTheme.headlineSmall,
                                )
                              ],
                            ),
                          ),
                          IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Iconsax.arrow_right_34,
                                size: TSizes.iconSm,
                              ))
                        ],
                      ),

                      const SizedBox(
                        height: TSizes.spaceBtwItems,
                      ),

                      //row 2
                      Row(
                        children: [
                          Expanded(
                            child: Row(
                              children: [
                                //icon
                                const Icon(Iconsax.tag),
                                const SizedBox(
                                  width: TSizes.spaceBtwItems / 2,
                                ),

                                // status and date
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Order',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium),
                                      Text(
                                        order.id,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Row(
                              children: [
                                //icon
                                const Icon(Iconsax.calendar),
                                const SizedBox(
                                  width: TSizes.spaceBtwItems / 2,
                                ),

                                // status and date
                                Expanded(
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text('Shipping Date',
                                          style: Theme.of(context)
                                              .textTheme
                                              .labelMedium),
                                      Text(
                                        order.formattedDeliveryDate,
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium,
                                      )
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              });
        });
  }
}
