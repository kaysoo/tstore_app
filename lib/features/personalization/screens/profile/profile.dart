import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/image/t_circular_image.dart';
import 'package:tstore_app/common/widgets/loaders/shimmer_loader.dart';
import 'package:tstore_app/common/widgets/text/section_heading.dart';
import 'package:tstore_app/features/personalization/controllers/user_controller.dart';
import 'package:tstore_app/features/personalization/screens/profile/components/profile_menu.dart';
import 'package:tstore_app/features/personalization/screens/profile/components/re_authenticate_user_form.dart';
import 'package:tstore_app/features/personalization/screens/profile/components/update_profile_details.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    final controller = UserController.instance;
    return Scaffold(
      appBar: const CustomAppBar(
        shoeBackArrow: true,
        title: Text("Profile"),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              //profile picture
              SizedBox(
                width: double.infinity,
                child: Column(
                  children: [
                    Obx(
                      () {
                        final networkImage =
                            controller.user.value.profilePicture;
                        final image = networkImage.isNotEmpty
                            ? networkImage
                            : TImages.user;
                        return controller.imageUploading.value
                            ? const TShimmerLoader(
                                width: 80,
                                height: 80,
                                radius: 80,
                              )
                            : TCircularImage(
                                dark: dark,
                                image: image,
                                width: 80,
                                height: 80,
                                isNetworkImage: networkImage.isNotEmpty,
                              );
                      },
                    ),
                    TextButton(
                        onPressed: () => controller.UploadUserProfilePicture(),
                        child: const Text("Change Profile Picture"))
                  ],
                ),
              ),

              //details
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const TSectionHeading(title: "Profile Information"),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TProfileMenu(
                title: "Name",
                value: controller.user.value.fullname,
                onPressed: () => Get.to(() => const UpdateProfileDetails()),
              ),
              TProfileMenu(
                title: "Username",
                value: controller.user.value.userName,
                onPressed: () {},
              ),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              //heading personal info
              const TSectionHeading(title: "Personal Information"),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),
              TProfileMenu(
                title: "User ID",
                value: controller.user.value.id,
                onPressed: () {},
                icon: Iconsax.copy,
              ),
              TProfileMenu(
                title: "E-mail",
                value: controller.user.value.email,
                onPressed: () {},
              ),
              TProfileMenu(
                title: "Phone Number",
                value: controller.user.value.phoneNumber,
                onPressed: () {},
              ),
              TProfileMenu(
                title: "Gender",
                value: "Male",
                onPressed: () {},
              ),
              TProfileMenu(
                title: "Date of Birth",
                value: "10-Oct-1994",
                onPressed: () {},
              ),
              const Divider(),
              const SizedBox(
                height: TSizes.spaceBtwItems,
              ),

              Center(
                child: TextButton(
                  onPressed: () => controller.deleteAccountWarningPopup(),
                  child: const Text(
                    "Close Account",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
