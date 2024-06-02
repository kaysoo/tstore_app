import 'package:flutter/cupertino.dart';
import 'package:tstore_app/utils/constants/colors.dart';

class TCircularWidget extends StatelessWidget {
  const TCircularWidget({
    super.key,
    this.width = 400,
    this.height = 400,
    this.radius = 400,
    this.padding = 0.0,
    this.margin,
    this.child,
    this.backgroundColor = TColors.white,
  });

  final double? width;
  final double? height;
  final double? radius;
  final double? padding;
  final EdgeInsets? margin;
  final Widget? child;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      margin: margin,
      padding: EdgeInsets.all(padding!),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius!), color: backgroundColor),
      child: child,
    );
  }
}
