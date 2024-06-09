import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/common/widgets/icon/t_circular_icon.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class TProductQuantityWithAddRow extends StatelessWidget {
  const TProductQuantityWithAddRow({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        TCircularIcon(
          dark: dark,
          icon: Iconsax.minus,
          height: 32,
          width: 32,
          size: TSizes.md,
          color: dark ? TColors.white : TColors.black,
          backgroundColor: dark ? TColors.darkerGrey : TColors.light,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Text(
          "2",
          style: Theme.of(context).textTheme.titleSmall,
        ),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        TCircularIcon(
          dark: dark,
          icon: Iconsax.add,
          height: 32,
          width: 32,
          size: TSizes.md,
          color: TColors.white,
          backgroundColor: TColors.primary,
        ),
      ],
    );
  }
}
