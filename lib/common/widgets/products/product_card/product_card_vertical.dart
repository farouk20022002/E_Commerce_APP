import 'package:flutter/material.dart';
import 'package:fro9/common/styles/shadows.dart';
import 'package:fro9/common/widgets/icons/t_circular_icon.dart';
import 'package:fro9/common/widgets/images/t_rounded_image.dart';
import 'package:fro9/common/widgets/texts/product_price_text.dart';
import 'package:fro9/common/widgets/texts/product_title_text.dart';
import 'package:fro9/common/widgets/texts/t_brand_title_text_with_verification_icon.dart';
import 'package:fro9/features/shop/screens/product_details/product_details.dart';
import 'package:fro9/utils/constants/colors.dart';
import 'package:fro9/utils/constants/image_strings.dart';
import 'package:fro9/utils/constants/sizes.dart';
import 'package:fro9/utils/helpers/helper_functions.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

import '../../custom_shapes/containers/rounded_container.dart';

class TProductCardVertical extends StatelessWidget {
  const TProductCardVertical({super.key});
  @override
  Widget build(BuildContext context) {
    final dark = THelperFunctions.isDarkMode(context);
    return GestureDetector(
      onTap: () => Get.to(() => ProductDetails()),
      child: Container(
        width: 180,
        padding: const EdgeInsets.all(1),
        decoration: BoxDecoration(
            boxShadow: [TShadowStyle.verticalProductShadow],
            borderRadius: BorderRadius.circular(TSizes.productImageRadius),
            color: dark ? TColors.darkGrey : TColors.white),
        child: Column(
          children: [
            TRoundedContainer(
              height: 180,
              padding: const EdgeInsets.all(TSizes.sm),
              backgroundColor: dark ? TColors.dark : TColors.white,
              child: Stack(
                children: [
                  const TRoundedImage(
                    imageURl: TImages.productImage1,
                    applyImageRadius: true,
                  ),
                  Positioned(
                    top: 8,
                    left: 5,
                    child: TRoundedContainer(
                      radius: TSizes.sm,
                      width: 45,
                      height: 25,
                      backgroundColor: TColors.secondary.withOpacity(0.8),
                      padding: const EdgeInsets.symmetric(
                          horizontal: TSizes.sm, vertical: TSizes.xs),
                      child: Text(
                        '25%',
                        style: Theme.of(context)
                            .textTheme
                            .labelLarge!
                            .apply(color: TColors.black),
                      ),
                    ),
                  ),
                  const Positioned(
                    top: 0,
                    right: 0,
                    child: TCircularIcon(
                      icon: Iconsax.heart5,
                      color: Colors.red,
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: TSizes.spaceBtwItems / 2,
            ),
            const Padding(
              padding: EdgeInsets.only(left: TSizes.sm),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  TProductTitleWidget(
                    title: "Green nike air shoes",
                    smallSize: true,
                  ),
                  SizedBox(
                    height: TSizes.spaceBtwItems / 2,
                  ),
                  TBrandTitleWithVerificationIcon(
                    title: 'Nike',
                  ),
                ],
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: TSizes.sm),
                  child: TProductPriceText(
                    price: '60.6',
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: TColors.dark,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(TSizes.cardRadiusMd),
                          bottomRight:
                              Radius.circular(TSizes.productImageRadius))),
                  child: const SizedBox(
                    width: TSizes.iconLg * 1.2,
                    height: TSizes.iconLg * 1.2,
                    child: Center(
                      child: Icon(
                        Iconsax.add,
                        color: TColors.white,
                      ),
                    ),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
