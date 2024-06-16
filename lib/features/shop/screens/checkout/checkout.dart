import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tstore_app/bottom_navigation.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/containers/rounded_container.dart';
import 'package:tstore_app/common/widgets/products_cart/coupon_widget.dart';
import 'package:tstore_app/common/widgets/success_screen/success_screen.dart';
import 'package:tstore_app/features/shop/screens/cart/components/cart_items_listview.dart';
import 'package:tstore_app/features/shop/screens/checkout/components/billing_address_section.dart';
import 'package:tstore_app/features/shop/screens/checkout/components/billing_amount_section.dart';
import 'package:tstore_app/features/shop/screens/checkout/components/billing_payment_section.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: Text(
          'Order Review',
          style: Theme.of(context).textTheme.headlineSmall,
        ),
        shoeBackArrow: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(TSizes.defaultSpace),
          child: Column(
            children: [
              /// items in the cart
              TCartItems(
                showaddremovebuttons: false,
              ),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //coupon textfield
              TCouponCode(),
              SizedBox(
                height: TSizes.spaceBtwSections,
              ),

              //billing section
              RoundedContainer(
                padding: EdgeInsets.all(TSizes.md),
                showBorder: true,
                backgroundColor: dark ? TColors.black : TColors.white,
                child: Column(
                  children: [
                    //pricing
                    TBillingAmountSection(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    //divider
                    const Divider(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    //payment methods
                    TBillingPaymentSection(),
                    const SizedBox(
                      height: TSizes.spaceBtwItems,
                    ),
                    //Address
                    TBillingAddressSection()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(TSizes.defaultSpace),
        child: ElevatedButton(
          onPressed: () => Get.to(
            () => SuccessScreen(
                image: TImages.paymentSuccess,
                title: 'Payment Success',
                subtitle: 'Your item will be shipped soon',
                onPressed: () => Get.offAll(
                      () => const BottomNavigation(),
                    )),
          ),
          child: const Text("Checkout \$225.0"),
        ),
      ),
    );
  }
}
