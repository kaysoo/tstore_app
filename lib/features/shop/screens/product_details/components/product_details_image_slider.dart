import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/curved_edges/curved_widget.dart';
import 'package:tstore_app/common/widgets/icon/t_circular_icon.dart';
import 'package:tstore_app/common/widgets/image/t_image_rounded.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class TProductImagesSlider extends StatelessWidget {
  const TProductImagesSlider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return CurvedEdgesWidget(
      child: Container(
        color: dark ? TColors.darkGrey : TColors.light,
        child: Stack(
          children: [
            SizedBox(
                height: 400,
                child: Padding(
                  padding: const EdgeInsets.all(TSizes.productImageRadius * 2),
                  child: Center(
                      child: Image(image: AssetImage(TImages.imageproduct2))),
                )),

            ///image slider
            Positioned(
              right: 0,
              bottom: 20,
              left: TSizes.defaultSpace,
              child: SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: 8,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: AlwaysScrollableScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(
                    width: TSizes.spaceBtwItems,
                  ),
                  itemBuilder: (_, index) => TRoundedImage(
                    imageUrl: TImages.imageproduct1,
                    width: 80,
                    backgroundcolor: dark ? TColors.dark : TColors.white,
                    border: Border.all(color: TColors.primary),
                    padding: EdgeInsets.all(TSizes.sm),
                  ),
                ),
              ),
            ),
            //appbar icons
            CustomAppBar(
              shoeBackArrow: true,
              actions: [
                TCircularIcon(
                  dark: dark,
                  icon: Iconsax.heart5,
                  color: Colors.red,
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
