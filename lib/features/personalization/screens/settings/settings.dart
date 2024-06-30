import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/containers/primary_header_container.dart';
import 'package:tstore_app/common/widgets/list_tiles/luser_profile_list_tile.dart';
import 'package:tstore_app/common/widgets/list_tiles/settings_menu_list_tile.dart';
import 'package:tstore_app/common/widgets/text/section_heading.dart';
import 'package:tstore_app/data/repositories/repositories_authentication/authentication_repository.dart';
import 'package:tstore_app/features/personalization/screens/address/address.dart';
import 'package:tstore_app/features/shop/screens/cart/cart.dart';
import 'package:tstore_app/features/shop/screens/order/order.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            //header
            TPrimaryHeaderContainer(
                child: Column(
              children: [
                CustomAppBar(
                  title: Text(
                    "Account",
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium!
                        .apply(color: TColors.white),
                  ),
                ),

                //user profile card
                TUserProfileTile(dark: dark),
                const SizedBox(
                  height: TSizes.spaceBtwSections,
                ),
              ],
            )),

            //body
            Padding(
              padding: const EdgeInsets.all(TSizes.defaultSpace),
              child: Column(
                children: [
                  ///account settings
                  const TSectionHeading(title: "Account Settings"),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.safe_home,
                    title: "My Addresses",
                    subtitle: "Set shopping delivery address",
                    onTap: () => Get.to(() => const UserAddressScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.shopping_cart,
                    title: "My Cart",
                    subtitle: "Add, remove products and move to checkout",
                    onTap: () => Get.to(() => const CartScreen()),
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.bag_tick,
                    title: "My Orders",
                    subtitle: "In progress and Completed Orders",
                    onTap: () => Get.to(() => const OrderScreen()),
                  ),
                  const TSettingsMenuTile(
                    icon: Iconsax.bank,
                    title: "Bank Account",
                    subtitle: "Withdraw balance to registered bank account",
                    // onTap: () {},
                  ),
                  const TSettingsMenuTile(
                    icon: Iconsax.discount_shape,
                    title: "My Coupons",
                    subtitle: "List of all the discounted coupons",
                    // onTap: () {},
                  ),
                  const TSettingsMenuTile(
                    icon: Iconsax.notification,
                    title: "Notifications",
                    subtitle: "Set any kind of notification message",
                    // onTap: () {},
                  ),
                  const TSettingsMenuTile(
                    icon: Iconsax.security_card,
                    title: "Account Privacy",
                    subtitle: "Manage data usage and connected accounts",
                    // onTap: () {},
                  ),

                  //app settings
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  const TSectionHeading(title: "App Settings"),
                  const SizedBox(
                    height: TSizes.spaceBtwItems,
                  ),
                  const TSettingsMenuTile(
                    icon: Iconsax.document_upload,
                    title: "Load Data",
                    subtitle: "Upload data to your cloud firebase",
                    // onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.location,
                    title: "Geolocation",
                    subtitle: "Set recommendations based on location",
                    trailing: Switch(value: true, onChanged: (value) {}),
                    // onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.security_user,
                    title: "Safe Mode",
                    subtitle: "Search result is safe for all ages",
                    trailing: Switch(value: false, onChanged: (value) {}),
                    // onTap: () {},
                  ),
                  TSettingsMenuTile(
                    icon: Iconsax.image,
                    title: "HD Image Quality",
                    subtitle: "Set image quality to be seen",
                    trailing: Switch(value: false, onChanged: (value) {}),
                    // onTap: () {},
                  ),

                  //logout button
                  const SizedBox(
                    height: TSizes.spaceBtwSections,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      child: const Text("Logout"),
                      onPressed: () =>
                          AuthenticationRespository.instance.logout(),
                    ),
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
