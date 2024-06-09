import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/containers/circular_container.dart';
import 'package:tstore_app/common/widgets/curved_edges/curved_widget.dart';
import 'package:tstore_app/utils/constants/colors.dart';

class TPrimaryHeaderContainer extends StatelessWidget {
  const TPrimaryHeaderContainer({
    super.key,
    required this.child,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return CurvedEdgesWidget(
      child: SizedBox(
        // height: 400,
        child: Container(
          color: TColors.primary,
          // padding: const EdgeInsets.all(0),
          child: Stack(
            children: [
              Positioned(
                top: -150,
                right: -250,
                child: TCircularWidget(
                  backgroundColor: TColors.textWhite.withOpacity(0.1),
                ),
              ),
              Positioned(
                top: 100,
                right: -300,
                child: TCircularWidget(
                  backgroundColor: TColors.textWhite.withOpacity(0.1),
                ),
              ),
              child
            ],
          ),
        ),
      ),
    );
  }
}
