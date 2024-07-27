import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/shimmer_loader.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class TCategoryShimmer extends StatelessWidget {
  const TCategoryShimmer({
    super.key,
    this.itemCount = 6,
  });

  final int itemCount;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 80,
      child: ListView.separated(
          shrinkWrap: true,
          separatorBuilder: (_, __) => const SizedBox(
                width: TSizes.spaceBtwItems,
              ),
          itemCount: itemCount,
          itemBuilder: (_, __) {
            return const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                //image
                TShimmerLoader(
                  width: 55,
                  height: 55,
                  radius: 55,
                ),
                SizedBox(
                  height: TSizes.spaceBtwItems / 2,
                ),

                //text
                TShimmerLoader(width: 55, height: 8),
              ],
            );
          }),
    );
  }
}
