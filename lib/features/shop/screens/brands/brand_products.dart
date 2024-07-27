import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/brand/t_brand_card.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/vertical_product_shimmer.dart';
import 'package:tstore_app/common/widgets/products_cart/sortable_products.dart';
import 'package:tstore_app/features/shop/controllers/brand_controller.dart';
import 'package:tstore_app/features/shop/models/brand_model.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key, required this.brand});

  final BrandModel brand;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = BrandController.instance;
    return Scaffold(
      appBar: CustomAppBar(
        title: Text(brand.name),
        shoeBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //brand detail
              TBrandCard(
                  dark: dark,
                  image: brand.image,
                  textDescription: '${brand.productsCount} products',
                  title: brand.name,
                  showBorder: true),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              FutureBuilder(
                  future: controller.getBrandProducts(brandID: brand.id),
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

                    return TSortableProducts(
                      products: products,
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }
}
