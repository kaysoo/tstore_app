import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/brand/t_brand_showcase.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/ListTileShimmer.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/boxShimmer.dart';
import 'package:tstore_app/features/shop/controllers/brand_controller.dart';
import 'package:tstore_app/features/shop/models/category_model.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class CategoryBrands extends StatelessWidget {
  const CategoryBrands({super.key, required this.category});

  final CategoryModel category;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = BrandController.instance;
    return FutureBuilder(
        future: controller.getBrandForCategory(category.id),
        builder: (context, snapshot) {
          //handle loader and no data  or error message
          const loader = Column(
            children: [
              TListTileShimmer(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TBoxShimmer(),
              SizedBox(
                height: TSizes.spaceBtwItems,
              )
            ],
          );

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
          final brands = snapshot.data!;

          return ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: brands.length,
              itemBuilder: (_, index) {
                final brand = brands[index];
                return FutureBuilder(
                    future: controller.getBrandProducts(
                        brandID: brand.id, limit: 3),
                    builder: (context, snapshot) {
                      //handle loader and no data  or error message
                      const loader = Column(
                        children: [
                          TListTileShimmer(),
                          SizedBox(
                            height: TSizes.spaceBtwItems,
                          ),
                          TBoxShimmer(),
                          SizedBox(
                            height: TSizes.spaceBtwItems,
                          )
                        ],
                      );

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

                      return TBrandProductShowCase(
                        brand: brand,
                        dark: dark,
                        images: products.map((e) => e.thumbnail).toList(),
                      );
                    });
              });
        });
  }
}
