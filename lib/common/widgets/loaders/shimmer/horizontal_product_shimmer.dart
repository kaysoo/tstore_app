import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/shimmer_loader.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class THorizontalProductShimmer extends StatelessWidget {
  const THorizontalProductShimmer({super.key, this.itemCount = 4});
  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: TSizes.spaceBtwSections),
      height: 120,
      child: ListView.separated(
          itemCount: itemCount,
          separatorBuilder: (context, index) => const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
          itemBuilder: (_, __) => const Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  //image
                  TShimmerLoader(width: 120, height: 120),
                  SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),

                  //text
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      TShimmerLoader(width: 160, height: 15),
                      SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      TShimmerLoader(width: 110, height: 15),
                      SizedBox(
                        height: TSizes.spaceBtwItems / 2,
                      ),
                      TShimmerLoader(width: 80, height: 15),
                      Spacer(),
                    ],
                  )
                ],
              )),
    );
  }
}
