import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/layout/grid_layout.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/shimmer_loader.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class TVerticalProductShimmer extends StatelessWidget {
  const TVerticalProductShimmer({super.key, this.itemCount = 4});

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return TGridLayout(
        itemCount: itemCount,
        itemBuilder: (_, __) => const SizedBox(
              width: 180,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //image
                  TShimmerLoader(width: 180, height: 180),
                  SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),

                  //text
                  TShimmerLoader(width: 160, height: 15),
                  SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  TShimmerLoader(width: 110, height: 15),
                ],
              ),
            ));
  }
}
