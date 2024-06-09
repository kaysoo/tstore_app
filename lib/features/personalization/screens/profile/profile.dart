import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/image/t_circular_image.dart';
import 'package:tstore_app/common/widgets/text/section_heading.dart';
import 'package:tstore_app/features/personalization/screens/profile/components/profile_menu.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      appBar: CustomAppBar(
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
                    TCircularImage(
                      dark: dark,
                      image: TImages.user,
                      width: 80,
                      height: 80,
                    ),
                    TextButton(
                        onPressed: () {},
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
                value: "Coding with kayso",
                onPressed: () {},
              ),
              TProfileMenu(
                title: "Username",
                value: "kayso",
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
                value: "kayso22",
                onPressed: () {},
                icon: Iconsax.copy,
              ),
              TProfileMenu(
                title: "E-mail",
                value: "kayso22@gmail.com",
                onPressed: () {},
              ),
              TProfileMenu(
                title: "Phone Number",
                value: "+233 54 079 7528",
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
                  onPressed: () {},
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
