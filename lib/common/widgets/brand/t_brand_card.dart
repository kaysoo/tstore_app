import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/containers/rounded_container.dart';
import 'package:tstore_app/common/widgets/image/t_circular_image.dart';
import 'package:tstore_app/common/widgets/text/brand_title_text_with_verifyicon.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/enums.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class TBrandCard extends StatelessWidget {
  const TBrandCard({
    super.key,
    required this.dark,
    this.isNetworkImage = false,
    required this.image,
    required this.textDescription,
    required this.title,
    required this.showBorder,
    this.onTap,
  });

  final bool dark;
  final bool showBorder;
  final bool isNetworkImage;
  final String image, textDescription, title;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: RoundedContainer(
        padding: EdgeInsets.all(TSizes.sm),
        showBorder: showBorder,
        backgroundColor: Colors.transparent,
        child: Row(
          children: [
            //icon
            Flexible(
              child: TCircularImage(
                dark: dark,
                isNetworkImage: isNetworkImage,
                image: image,
                backgroundColor: Colors.transparent,
                overlayColor: dark ? TColors.white : TColors.black,
              ),
            ),
            const SizedBox(
              width: TSizes.spaceBtwItems / 2,
            ),
            //text
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TBrandTitlewithVerifyIcon(
                    title: title,
                    brandTextSize: TextSizes.large,
                  ),
                  Text(
                    textDescription,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
