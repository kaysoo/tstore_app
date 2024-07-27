import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/brand/t_brand_card.dart';
import 'package:tstore_app/common/widgets/layout/grid_layout.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/brand_shimmer.dart';
import 'package:tstore_app/common/widgets/text/section_heading.dart';
import 'package:tstore_app/features/shop/controllers/brand_controller.dart';
import 'package:tstore_app/features/shop/screens/brands/brand_products.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class AllBrandsScreen extends StatelessWidget {
  const AllBrandsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final brandController = BrandController.instance;
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const CustomAppBar(
        shoeBackArrow: true,
        title: Text('Brand'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //heading
              const TSectionHeading(
                title: 'Brands',
                showActionButton: false,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              //brands
              Obx(
                () {
                  if (brandController.isLoading.value) {
                    return const TBrandShimmer();
                  }

                  if (brandController.allBrands.isEmpty) {
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
                      itemCount: brandController.allBrands.length,
                      mainAxisExtent: 80,
                      itemBuilder: (context, index) {
                        final brand = brandController.allBrands[index];
                        return TBrandCard(
                          dark: dark,
                          image: brand.image,
                          textDescription: ' ${brand.productsCount} products',
                          title: brand.name,
                          showBorder: true,
                          onTap: () => Get.to(() => BrandProducts(
                                brand: brand,
                              )),
                        );
                      });
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
