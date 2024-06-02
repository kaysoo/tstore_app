import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/common/widgets/text/brand_title_text.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/enums.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class TBrandTitlewithVerifyIcon extends StatelessWidget {
  const TBrandTitlewithVerifyIcon({
    super.key,
    required this.title,
    this.textColor,
    this.iconColor = TColors.primary,
    this.maxlines = 1,
    this.textAlign = TextAlign.center,
    this.brandTextSize = TextSizes.small,
  });

  final String title;
  final Color? textColor, iconColor;
  final int maxlines;
  final TextAlign? textAlign;
  final TextSizes brandTextSize;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        TBrandTitleText(
          title: title,
          color: textColor,
          maxlines: maxlines,
          textAlign: textAlign,
          brandTextSize: brandTextSize,
        ),
        const SizedBox(
          width: TSizes.xs,
        ),
        const Icon(
          Iconsax.verify5,
          color: TColors.primary,
          size: TSizes.iconSm,
        )
      ],
    );
  }
}
