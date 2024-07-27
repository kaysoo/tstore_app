import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/image/t_image_rounded.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/horizontal_product_shimmer.dart';
import 'package:tstore_app/common/widgets/products_cart/product_card_horizontal.dart';
import 'package:tstore_app/common/widgets/text/section_heading.dart';
import 'package:tstore_app/features/shop/controllers/category_controller.dart';
import 'package:tstore_app/features/shop/models/category_model.dart';
import 'package:tstore_app/features/shop/screens/all_products/all_products.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class SubCategoriesScreen extends StatelessWidget {
  const SubCategoriesScreen({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final controller = CategoryController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(category.name),
        shoeBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //banner
              const TRoundedImage(
                imageUrl: TImages.promoBanner3,
                width: double.infinity,
                applyImageRadius: true,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //sub categories
              FutureBuilder(
                  future: controller.getSubCategories(category.id),
                  builder: (context, snapshot) {
                    const loader = THorizontalProductShimmer();

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

                    //record found
                    final subcategories = snapshot.data!;
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: subcategories.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (_, index) {
                          final subCategory = subcategories[index];
                          return FutureBuilder(
                              future: controller.getCategoryProducts(
                                  categoryId: subCategory.id),
                              builder: (context, snapshot) {
                                if (snapshot.connectionState ==
                                    ConnectionState.waiting) {
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
                                //record found
                                final products = snapshot.data!;

                                return Column(
                                  children: [
                                    //heading
                                    TSectionHeading(
                                      title: subCategory.name,
                                      showActionButton: true,
                                      onPressed: () =>
                                          Get.to(() => AllProductsScreen(
                                                title: subCategory.name,
                                                futureMethod: controller
                                                    .getCategoryProducts(
                                                        categoryId:
                                                            subCategory.id,
                                                        limit: -1),
                                              )),
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwItems / 2,
                                    ),

                                    SizedBox(
                                      height: 120,
                                      child: ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                                width: TSizes.spaceBtwItems,
                                              ),
                                          itemCount: products.length,
                                          scrollDirection: Axis.horizontal,
                                          itemBuilder: (context, index) =>
                                              TProductCardHorizontal(
                                                  product: products[index])),
                                    ),
                                    const SizedBox(
                                      height: TSizes.spaceBtwSections,
                                    )
                                  ],
                                );
                              });
                        });
                  })
            ],
          ),
        ),
      ),
    );
  }
}
