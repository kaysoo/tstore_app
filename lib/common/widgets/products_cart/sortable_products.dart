import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tstore_app/common/widgets/layout/grid_layout.dart';
import 'package:tstore_app/common/widgets/products_cart/product_card_vertical.dart';
import 'package:tstore_app/features/shop/controllers/product/all_products_controller.dart';
import 'package:tstore_app/features/shop/models/product_model.dart';
import 'package:tstore_app/utils/constants/sizes.dart';

class TSortableProducts extends StatelessWidget {
  const TSortableProducts({
    super.key,
    required this.products,
  });

  final List<ProductModel> products;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(AllProductsController());
    controller.assingProducts(products);
    return Column(
      children: [
        //dropdown
        DropdownButtonFormField(
            decoration: const InputDecoration(prefixIcon: Icon(Iconsax.sort)),
            items: [
              'Name',
              'Higher Price',
              'Lower Price',
              'Sale',
              // 'Newest',
              // 'Popularity'
            ]
                .map((item) => DropdownMenuItem(value: item, child: Text(item)))
                .toList(),
            value: controller.selectedSortOption.value,
            onChanged: (value) {
              controller.sortProducts(value!);
            }),
        const SizedBox(
          height: TSizes.spaceBtwSections,
        ),

        //products
        Obx(
          () => TGridLayout(
              itemCount: controller.products.length,
              itemBuilder: (_, index) => TProductCardVertical(
                    product: controller.products[index],
                  )),
        )
      ],
    );
  }
}
