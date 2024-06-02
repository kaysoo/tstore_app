import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class RoundedContainer extends StatelessWidget {
  const RoundedContainer(
      {super.key,
      this.width,
      this.height,
      this.radius = TSizes.cardRadiusLg,
      this.padding,
      this.margin,
      this.child,
      this.showBorder = false,
      this.backgroundColor = TColors.white,
      this.borderColor = TColors.borderPrimary});

  final double? width;
  final double? height;
  final double? radius;
  final bool showBorder;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Widget? child;
  final Color? backgroundColor;
  final Color borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius!),
          border: showBorder ? Border.all(color: borderColor) : null,
          color: backgroundColor),
      child: child,
    );
  }
}
