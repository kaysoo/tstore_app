import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/brand/t_brand_card.dart';
import 'package:tstore_app/common/widgets/products_cart/sortable_products.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class BrandProducts extends StatelessWidget {
  const BrandProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: const CustomAppBar(
        title: Text('Nike'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //brand detail
              TBrandCard(
                  dark: dark,
                  image: TImages.clothIcon,
                  textDescription: 'Available in all colors',
                  title: 'Nike',
                  showBorder: true),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),
              const TSortableProducts()
            ],
          ),
        ),
      ),
    );
  }
}
