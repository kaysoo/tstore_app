import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/bottom_navigation.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/icon/t_circular_icon.dart';
import 'package:tstore_app/common/widgets/layout/grid_layout.dart';
import 'package:tstore_app/common/widgets/loaders/animation_loader.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/vertical_product_shimmer.dart';
import 'package:tstore_app/common/widgets/products_cart/product_card_vertical.dart';
import 'package:tstore_app/features/shop/controllers/product/favourite_controller.dart';
import 'package:tstore_app/features/shop/models/product_model.dart';
import 'package:tstore_app/features/shop/screens/home/home.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class WishList extends StatelessWidget {
  const WishList({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = FavouriteController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
        title:
            Text("WishList", style: Theme.of(context).textTheme.headlineMedium),
        actions: [
          TCircularIcon(
            dark: dark,
            icon: Iconsax.add,
            onPressed: () => Get.to(const HomeScreen()),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              Obx(
                () => FutureBuilder(
                    future: controller.favoriteProducts(),
                    builder: (context, snapshot) {
                      const loader = TVerticalProductShimmer(
                        itemCount: 6,
                      );
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return loader;
                      }

                      if (!snapshot.hasData ||
                          snapshot.data == null ||
                          snapshot.data!.isEmpty) {
                        return Center(
                          child: TAnimationLoaderWidget(
                            text: 'Whoops! Wishlist is Empty...',
                            animation:
                                'https://lottie.host/fb910bff-5cd0-4e28-842f-3de892766ed2/0a5yHEBnpg.json',
                            showAction: true,
                            actionText: 'Let\'s add some',
                            onActionPressed: () =>
                                Get.off(() => const BottomNavigation()),
                          ),
                          // child: Text('No Data Found...'),
                        );
                      }

                      if (snapshot.hasError) {
                        return const Center(
                          child: Text('Something went wrong...'),
                        );
                      }
                      return TGridLayout(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (_, index) => TProductCardVertical(
                                product: snapshot.data![index],
                              ));
                    }),
              )
            ],
          ),
        ),
      ),
    );
  }
}
