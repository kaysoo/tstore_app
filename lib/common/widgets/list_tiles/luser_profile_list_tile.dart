import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/common/widgets/image/t_circular_image.dart';
import 'package:tstore_app/features/personalization/controllers/user_controller.dart';
import 'package:tstore_app/features/personalization/screens/profile/profile.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';

class TUserProfileTile extends StatelessWidget {
  const TUserProfileTile({
    super.key,
    required this.dark,
  });

  final bool dark;

  @override
  Widget build(BuildContext context) {
    final controller = UserController.instance;
    return ListTile(
      leading: TCircularImage(
        image: TImages.user,
        dark: dark,
        width: 50,
        height: 50,
        padding: 0,
        // fit: BoxFit.cover,
      ),
      title: Text(
        controller.user.value.fullname,
        style: Theme.of(context)
            .textTheme
            .headlineSmall!
            .apply(color: TColors.white),
      ),
      subtitle: Text(
        controller.user.value.email,
        style:
            Theme.of(context).textTheme.bodyMedium!.apply(color: TColors.white),
      ),
      trailing: IconButton(
        onPressed: () => Get.to(() => const ProfileScreen()),
        icon: const Icon(
          Iconsax.edit,
          color: TColors.white,
        ),
      ),
    );
  }
}
