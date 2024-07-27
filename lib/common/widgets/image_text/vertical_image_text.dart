import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/image/t_circular_image.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class TVerticalImageText extends StatelessWidget {
  const TVerticalImageText({
    super.key,
    required this.image,
    required this.title,
    this.textColor = TColors.white,
    this.backgroundColor,
    this.onTap,
    this.isNetworkImage = true,
  });

  final String image, title;
  final Color textColor;
  final Color? backgroundColor;
  final void Function()? onTap;
  final bool isNetworkImage;

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.only(right: TSizes.spaceBtwItems),
        child: Column(children: [
          //circular icon
          TCircularImage(
            dark: dark,
            image: image,
            isNetworkImage: isNetworkImage,
            fit: BoxFit.fitWidth,
            // padding: TSizes.sm * 1.4,
            backgroundColor: backgroundColor,
            overlayColor: dark ? TColors.light : TColors.dark,
          ),

          //text below circular icon
          const SizedBox(
            height: TSizes.spaceBtwItems / 2,
          ),
          SizedBox(
            width: 55,
            child: Text(
              title,
              style: Theme.of(context)
                  .textTheme
                  .labelMedium!
                  .apply(color: textColor),
              maxLines: 1,
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ]),
      ),
    );
  }
}
