import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/containers/primary_header_container.dart';
import 'package:tstore_app/common/widgets/containers/search_container.dart';
import 'package:tstore_app/common/widgets/layout/grid_layout.dart';
import 'package:tstore_app/common/widgets/products_cart/product_card_vertical.dart';
import 'package:tstore_app/common/widgets/text/section_heading.dart';
import 'package:tstore_app/features/shop/screens/home/components/home_appbar.dart';
import 'package:tstore_app/features/shop/screens/home/components/home_categories.dart';
import 'package:tstore_app/features/shop/screens/home/components/home_slider.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                THomeCategories()
              ],
            ),
          ),

          //body
          Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  const TPromoSlider(
                    banners: [
                      TImages.promoBanner2,
                      TImages.promoBanner3,
                      TImages.promoBanner1
                    ],
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  TSectionHeading(
                    title: "Popular Products",
                    onPressed: () {},
                    showActionButton: true,
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TGridLayout(
                    itemCount: 10,
                    itemBuilder: (_, index) => const TProductCardVertical(),
                  ),
                ],
              ))
        ],
      ),
    ));
  }
}
