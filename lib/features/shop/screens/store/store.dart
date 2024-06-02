import 'package:flutter/material.dart';
import 'package:tstore_app/common/widgets/appbar/appbar.dart';
import 'package:tstore_app/common/widgets/appbar/tapbar.dart';
import 'package:tstore_app/common/widgets/brand/t_brand_card.dart';
import 'package:tstore_app/common/widgets/containers/search_container.dart';
import 'package:tstore_app/common/widgets/layout/grid_layout.dart';
import 'package:tstore_app/common/widgets/products_cart/cart_menu_icon.dart';
import 'package:tstore_app/common/widgets/text/section_heading.dart';
import 'package:tstore_app/features/shop/screens/store/components/category.dart';
import 'package:tstore_app/utils/constants/colors.dart';
import 'package:tstore_app/utils/constants/image_strings.dart';
import 'package:tstore_app/utils/constants/sizes.dart';
import 'package:tstore_app/utils/helpers/helper_functions.dart';

class TStore extends StatelessWidget {
  const TStore({super.key});

  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return DefaultTabController(
      length: 5,
      child: Scaffold(
        appBar: CustomAppBar(
          title: Text(
            "Store",
            style: Theme.of(context).textTheme.headlineMedium,
          ),
          actions: [
            TCartCounterIcon(
                onPressed: () {},
                iconColor: dark ? TColors.white : TColors.dark)
          ],
        ),
        body: NestedScrollView(
          headerSliverBuilder: (_, innerBoxIsScrolled) {
            return [
              SliverAppBar(
                  automaticallyImplyLeading: false,
                  pinned: true,
                  floating: true,
                  backgroundColor: dark ? TColors.black : TColors.white,
                  expandedHeight: 440,
                  flexibleSpace: Padding(
                    padding: EdgeInsets.all(TSizes.defaultSpace),
                    child: ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: [
                        //search bar
                        const SizedBox(
                          height: TSizes.spaceBtwItems,
                        ),
                        const TSearchContainer(
                          text: 'Search in Store',
                          shoeBackground: false,
                          padding: EdgeInsets.zero,
                        ),
                        const SizedBox(
                          height: TSizes.spaceBtwSections,
                        ),

                        //featured brands
                        TSectionHeading(
                            title: 'Featured Brands',
                            showActionButton: true,
                            onPressed: () {}),
                        const SizedBox(
                          height: TSizes.spaceBtwItems / 1.5,
                        ),

                        //grid layout
                        TGridLayout(
                            itemCount: 4,
                            mainAxisExtent: 80,
                            itemBuilder: (_, index) {
                              return TBrandCard(
                                showBorder: true,
                                dark: dark,
                                title: 'Nike',
                                textDescription: "25 pieces in stock currently",
                                image: TImages.shoeIcon,
                              );
                            })
                      ],
                    ),
                  ),

                  //tabs
                  bottom: const TTabBar(
                    tabs: [
                      Tab(
                        child: Text("Sports"),
                      ),
                      Tab(
                        child: Text("Furniture"),
                      ),
                      Tab(
                        child: Text("Electronics"),
                      ),
                      Tab(
                        child: Text("Clothes"),
                      ),
                      Tab(
                        child: Text("Cosmetics"),
                      ),
                    ],
                  ))
            ];
          },
          body: TabBarView(children: [
            TCategoryTab(
              dark: dark,
            ),
            TCategoryTab(
              dark: dark,
            ),
            TCategoryTab(
              dark: dark,
            ),
            TCategoryTab(
              dark: dark,
            ),
            TCategoryTab(dark: dark),
          ]),
        ),
      ),
    );
  }
}
