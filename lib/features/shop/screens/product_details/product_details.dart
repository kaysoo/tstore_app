import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:readmore/readmore.dart';
import 'package:tstore_app/common/widgets/text/section_heading.dart';
import 'package:tstore_app/features/shop/models/product_model.dart';
import 'package:tstore_app/features/shop/screens/product_details/components/bottom_add_to_cart.dart';
import 'package:tstore_app/features/shop/screens/product_details/components/product_attributes.dart';
import 'package:tstore_app/features/shop/screens/product_details/components/product_details_image_slider.dart';
import 'package:tstore_app/features/shop/screens/product_details/components/product_meta_data.dart';
import 'package:tstore_app/features/shop/screens/product_details/components/rating_and_share.dart';
import 'package:tstore_app/features/shop/screens/product_reviews/product_reviews.dart';
import 'package:tstore_app/utils/constants/enums.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.product});

  final ProductModel product;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: TBottomAddtoCart(product: product),
      body: SingleChildScrollView(
        child: Column(
          children: [
            //product image slider
            TProductImagesSlider(product: product),

            //product detaisl
            Padding(
              padding: const EdgeInsets.only(
                  right: TSizes.defaultSpace,
                  left: TSizes.defaultSpace,
                  bottom: TSizes.defaultSpace),
              child: Column(
                children: [
                  //rating and share button
                  const TRatingandShares(),

                  //price,title,stock and brand
                  TProductMetaData(
                    product: product,
                  ),

                  //attributes
                  if (product.productType == ProductType.variable.name)
                    ProductAttributes(
                      product: product,
                    ),
                  if (product.productType == ProductType.variable.name)
                    const SizedBox(
                      height: TSizes.spaceBtwSections,
                    ),

                  //checkout button

                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                        onPressed: () {}, child: const Text("Checkout")),
                  ),
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),

                  //description
                  const TSectionHeading(title: "Description"),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  ReadMoreText(
                    product.description ?? '',
                    trimLines: 2,
                    trimMode: TrimMode.Line,
                    trimCollapsedText: " Show more",
                    trimExpandedText: " Less",
                    moreStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                    lessStyle:
                        TextStyle(fontSize: 14, fontWeight: FontWeight.w800),
                  ),
                  //reviews
                  const Divider(),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  Row(
                    children: [
                      TSectionHeading(
                        title: "Reviews(199)",
                        onPressed: () {},
                      ),
                      IconButton(
                          onPressed: () =>
                              Get.to(() => const ProductReviewScreen()),
                          icon: const Icon(
                            Iconsax.arrow_right_3,
                            size: 18,
                          ))
                    ],
                  ),

                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
