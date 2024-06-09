import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/products_cart/rating_stars.dart';
import 'package:tstore_app/features/shop/screens/product_reviews/components/rating_progress_indicator.dart';
import 'package:tstore_app/features/shop/screens/product_reviews/components/user_review_card.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class ProductReviewScreen extends StatelessWidget {
  const ProductReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appbar
      appBar: const CustomAppBar(
        title: Text("Reviews and Ratings"),
        shoeBackArrow: true,
      ),

      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                  "Ratings and reviews are verified and are from people who use the same type of device that you use."),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              //overall product ratings
              const TOverallProductRating(),
              const TRatingBarIndicator(
                rating: 4.0,
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems / 2,
              ),
              Text(
                "12,145",
                style: Theme.of(context).textTheme.bodySmall,
              ),
              const SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              // user Reviews list
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
              const UserReviewCard(),
            ],
          ),
        ),
      ),
    );
  }
}
