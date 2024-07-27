import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/common/widgets/image_text/vertical_image_text.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/category_shimmer.dart';
import 'package:tstore_app/common/widgets/text/section_heading.dart';
import 'package:tstore_app/features/shop/controllers/category_controller.dart';
import 'package:tstore_app/features/shop/screens/sub_category/sub_categories.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class THomeCategories extends StatelessWidget {
  const THomeCategories({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final categoryController = Get.put(CategoryController());

    return Padding(
      padding: const EdgeInsets.only(left: TSizes.defaultSpace),
      child: Column(
        children: [
          const TSectionHeading(
            title: "Product Categories",
            textColor: Colors.white,
          ),
          const SizedBox(
            height: TSizes.spaceBtwItems,
          ),
          Obx(
            () {
              if (categoryController.isLoading.value) {
                return const TCategoryShimmer(
                  itemCount: 6,
                );

                // return SizedBox(
                //   height: 80,
                //   child: ListView.builder(
                //       shrinkWrap: true,
                //       itemCount: 8,
                //       scrollDirection: Axis.horizontal,
                //       itemBuilder: (_, index) {
                //         return const TCategoryShimmer();
                //       }),
                // );
              }

              if (categoryController.featuredCategories.isEmpty) {
                return Center(
                  child: Text(
                    'No Data Found!',
                    style: Theme.of(context)
                        .textTheme
                        .bodyMedium!
                        .apply(color: Colors.white),
                  ),
                );
              }
              return SizedBox(
                height: 80,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: categoryController.featuredCategories.length,
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (_, index) {
                      final category =
                          categoryController.featuredCategories[index];
                      return TVerticalImageText(
                        title: category.name,
                        image: category.image,
                        onTap: () => Get.to(
                            () => SubCategoriesScreen(category: category)),
                      );
                    }),
              );
            },
          ),
        ],
      ),
    );
  }
}
