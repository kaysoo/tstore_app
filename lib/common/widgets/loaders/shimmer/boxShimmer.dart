import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/shimmer_loader.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class TBoxShimmer extends StatelessWidget {
  const TBoxShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        Row(
          children: [
            Expanded(child: TShimmerLoader(width: 150, height: 110)),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Expanded(child: TShimmerLoader(width: 150, height: 110)),
            SizedBox(
              width: TSizes.spaceBtwItems,
            ),
            Expanded(child: TShimmerLoader(width: 150, height: 110)),
            SizedBox(
              width: TSizes.spaceBtwItems,
            )
          ],
        )
      ],
    );
  }
}
