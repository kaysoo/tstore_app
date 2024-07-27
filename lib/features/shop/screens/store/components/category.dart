import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tstore_app/common/widgets/brand/t_brand_showcase.dart';
import 'package:tstore_app/common/widgets/layout/grid_layout.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/vertical_product_shimmer.dart';
import 'package:tstore_app/common/widgets/products_cart/product_card_vertical.dart';
import 'package:tstore_app/common/widgets/text/section_heading.dart';
import 'package:tstore_app/features/shop/controllers/category_controller.dart';
import 'package:tstore_app/features/shop/controllers/product/product_controller.dart';
import 'package:tstore_app/features/shop/models/category_model.dart';
import 'package:tstore_app/features/shop/models/product_model.dart';
import 'package:tstore_app/features/shop/screens/all_products/all_products.dart';
import 'package:tstore_app/features/shop/screens/store/components/category_brands.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class TCategoryTab extends StatelessWidget {
  const TCategoryTab({
    super.key,
    required this.dark,
    required this.category,
  });

  final bool dark;
  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              children: [
                //brands
                CategoryBrands(
                  category: category,
                ),

                const SizedBox(
                  height: TSizes.spaceBtwItems,
                ),

                //products
                FutureBuilder(
                    future:
                        controller.getCategoryProducts(categoryId: category.id),
                    builder: (context, snapshot) {
                      //check the state of the futurebuilder snapshot
                      const loader = TVerticalProductShimmer();
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return loader;
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
                      final products = snapshot.data!;

                      return Column(
                        children: [
                          TSectionHeading(
                            title: "You might like",
                            onPressed: () => Get.to(() => AllProductsScreen(
                                  title: category.name,
                                  futureMethod: controller.getCategoryProducts(
                                      categoryId: category.id, limit: -1),
                                )),
                            showActionButton: true,
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          TGridLayout(
                              itemCount: products.length,
                              itemBuilder: (_, index) => TProductCardVertical(
                                    product: products[index],
                                  )),
                        ],
                      );
                    }),

                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            ),
          ),
        ]);
  }
}
