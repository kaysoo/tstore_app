import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/features/authentication/controllers/signup/signup_controller.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class TermsAndConditions extends StatelessWidget {
  const TermsAndConditions({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = SignUpController.instance;

    return Row(
      children: [
        SizedBox(
            width: 24,
            height: 24,
            child: Obx(() => Checkbox(
                value: controller.privacyPolicy.value,
                onChanged: (value) => controller.privacyPolicy.value =
                    !controller.privacyPolicy.value))),
        const SizedBox(
          width: TSizes.spaceBtwItems,
        ),
        Text.rich(TextSpan(children: [
          TextSpan(
              text: "I agree to ",
              style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: "Privacy Policy",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? TColors.white : TColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? TColors.white : TColors.primary)),
          TextSpan(text: " and ", style: Theme.of(context).textTheme.bodySmall),
          TextSpan(
              text: "Terms of use ",
              style: Theme.of(context).textTheme.bodyMedium!.apply(
                  color: dark ? TColors.white : TColors.primary,
                  decoration: TextDecoration.underline,
                  decorationColor: dark ? TColors.white : TColors.primary)),
        ]))
      ],
    );
  }
}
