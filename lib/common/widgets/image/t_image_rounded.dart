import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer/shimmer_loader.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class TRoundedImage extends StatelessWidget {
  const TRoundedImage({
    super.key,
    this.width,
    this.height,
    required this.imageUrl,
    this.applyImageRadius = false,
    this.border,
    this.backgroundcolor,
    this.fit = BoxFit.contain,
    this.padding,
    this.isNetworkImage = false,
    this.onPressed,
    this.borderRadius = TSizes.md,
  });

  final double? width, height, borderRadius;
  final String imageUrl;
  final bool applyImageRadius;
  final BoxBorder? border;
  final Color? backgroundcolor;
  final BoxFit? fit;
  final EdgeInsetsGeometry? padding;
  final bool isNetworkImage;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: width,
        height: height,
        padding: padding,
        decoration: BoxDecoration(
          border: border,
          color: backgroundcolor,
          borderRadius: BorderRadius.circular(borderRadius!),
        ),
        child: ClipRRect(
            borderRadius: applyImageRadius
                ? BorderRadius.circular(borderRadius!)
                : BorderRadius.zero,
            child: isNetworkImage
                ? CachedNetworkImage(
                    imageUrl: imageUrl,
                    fit: fit,
                    // color: overlayColor,
                    progressIndicatorBuilder: (context, url, progress) =>
                        const TShimmerLoader(
                      width: double.infinity,
                      height: 190,
                      radius: 10,
                    ),
                    errorWidget: (context, url, error) =>
                        const Icon(Icons.error),
                  )
                : Image(image: AssetImage(imageUrl) as ImageProvider)

            //  Image(
            //   image: isNetworkImage
            //       ? NetworkImage(imageUrl)

            //       // CachedNetworkImage(
            //       //   imageUrl: image,
            //       //   fit: fit,
            //       //   color: overlayColor,
            //       //   progressIndicatorBuilder: (context, url, progress) =>
            //       //       const TShimmerLoader(
            //       //     width: 55,
            //       //     height: 55,
            //       //     radius: 55,
            //       //   ),
            //       //   errorWidget: (context, url, error) => const Icon(Icons.error),
            //       // )
            //       : AssetImage(imageUrl) as ImageProvider,
            //   fit: fit,
            //   // color: TColors.black,
            // ),
            ),
      ),
    );
  }
}
