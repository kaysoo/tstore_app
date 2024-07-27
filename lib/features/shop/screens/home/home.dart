import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/common/widgets/containers/primary_header_container.dart';
import 'package:tstore_app/common/widgets/containers/search_container.dart';
import 'package:tstore_app/common/widgets/layout/grid_layout.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/vertical_product_shimmer.dart';
import 'package:tstore_app/common/widgets/products_cart/product_card_vertical.dart';
import 'package:tstore_app/common/widgets/text/section_heading.dart';
import 'package:tstore_app/features/shop/controllers/product/product_controller.dart';
import 'package:tstore_app/features/shop/screens/all_products/all_products.dart';
import 'package:tstore_app/features/shop/screens/home/components/home_appbar.dart';
import 'package:tstore_app/features/shop/screens/home/components/home_categories.dart';
import 'package:tstore_app/features/shop/screens/home/components/home_slider.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(ProductController());
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        children: [
          const TPrimaryHeaderContainer(
            child: Column(
              children: [
                //appbar
                HomeAppBar(),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                //searchbar
                TSearchContainer(
                  text: "Search in Store",
                ),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),

                //categories
                THomeCategories(),
                SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            ),
          ),

          //body
          Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TPromoSlider(),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  TSectionHeading(
                    title: "Popular Products",
                    onPressed: () => Get.to(() => AllProductsScreen(
                          title: 'Popular Products',
                          // query: FirebaseFirestore.instance
                          //     .collection('Products')
                          //     .where('IsFeatured', isEqualTo: true)
                          //     .limit(6),
                          futureMethod: controller.fetchAllFeaturedProducts(),
                        )),
                    showActionButton: true,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  // SizedBox(
                  //   // height: TSizes.md,
                  //   width: double.infinity,
                  //   child: ElevatedButton(
                  //       onPressed: () => controller.sendFeaturedProducts(),
                  //       child: const Text('Upload data')),
                  // ),
                  // const SizedBox(
                  //   height: TSizes.spaceBtwItems,
                  // ),
                  Obx(
                    () {
                      if (controller.isLoading.value) {
                        return const TVerticalProductShimmer();
                      } else if (controller.featuredProducts.isEmpty) {
                        return Center(
                          child: Text(
                            'No Data Found!!',
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        );
                      } else {
                        return TGridLayout(
                          itemCount: controller.featuredProducts.length,
                          itemBuilder: (_, index) => TProductCardVertical(
                            product: controller.featuredProducts[index],
                          ),
                        );
                      }
                    },
                  ),
                ],
              ))
        ],
      ),
    ));
  }
}
