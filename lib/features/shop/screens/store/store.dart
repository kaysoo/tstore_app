import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/appbar/tapbar.dart';
import 'package:tstore_app/common/widgets/brand/t_brand_card.dart';
import 'package:tstore_app/common/widgets/containers/search_container.dart';
import 'package:tstore_app/common/widgets/layout/grid_layout.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/brand_shimmer.dart';
import 'package:tstore_app/common/widgets/products_cart/cart_menu_icon.dart';
import 'package:tstore_app/common/widgets/text/section_heading.dart';
import 'package:tstore_app/features/shop/controllers/brand_controller.dart';
import 'package:tstore_app/features/shop/controllers/category_controller.dart';
import 'package:tstore_app/features/shop/screens/brands/all_brands.dart';
import 'package:tstore_app/features/shop/screens/brands/brand_products.dart';
import 'package:tstore_app/features/shop/screens/store/components/category.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class TStore extends StatelessWidget {
  const TStore({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = Get.put(BrandController());
    final categories = CategoryController.instance.featuredCategories;
    final dark = THelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            "Store",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(iconColor: dark ? TColors.white : TColors.dark)
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: dark ? TColors.black : TColors.white,
                  expandedHeight: 440,
                  flexibleSpace: Padding(
                    padding: const EdgeInsets.all(TSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        //search bar
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        const TSearchContainer(
                          text: 'Search in Store',
                          shoeBackground: false,
                          padding: EdgeInsets.zero,
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),

                        //featured brands
                        TSectionHeading(
                            title: 'Featured Brands',
                            showActionButton: true,
                            onPressed: () =>
                                Get.to(() => const AllBrandsScreen())),
                        const SizedBox(
                          height: TSizes.spaceBtwItems / 1.5,
                        ),

                        //grid layout
                        Obx(() {
                          if (brandController.isLoading.value) {
                            return const TBrandShimmer();
                          }

                          if (brandController.featuredBrands.isEmpty) {
                            return Center(
                              child: Text(
                                'No Data Found...',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .apply(color: Colors.white),
                              ),
                            );
                          }

                          return TGridLayout(
                              itemCount: brandController.featuredBrands.length,
                              mainAxisExtent: 80,
                              itemBuilder: (_, index) {
                                final brand =
                                    brandController.featuredBrands[index];

                                return TBrandCard(
                                  showBorder: true,
                                  dark: dark,
                                  title: brand.name,
                                  textDescription:
                                      "${brand.productsCount ?? 0} pieces in stock currently",
                                  image: brand.image,
                                  onTap: () => Get.to(() => BrandProducts(
                                        brand: brand,
                                      )),
                                );
                              });
                        })
                      ],
                    ),
                  ),

                  //tabs
                  bottom: TTabBar(
                    tabs: categories
                        .map((category) => Tab(child: Text(category.name)))
                        .toList(),
                  ))
            ];
          },
          body: TabBarView(
              children: categories
                  .map((category) => TCategoryTab(
                        dark: dark,
                        category: category,
                      ))
                  .toList()),
        ),
      ),
    );
  }
}
