import 'package:flutter/material.dart';
import 'package:fro9/data/repositories/authentication_repository.dart';
import 'package:fro9/features/authentification/controllers/sign_up/sign_up_controller.dart';
import 'package:fro9/features/authentification/screens/signup/widgets/terms_conditions_checkbox.dart';
import 'package:fro9/utils/constants/image_strings.dart';
import 'package:fro9/utils/constants/sizes.dart';
import 'package:fro9/utils/constants/text_strings.dart';
import 'package:fro9/utils/helpers/network_manager.dart';
import 'package:fro9/utils/popups/fullscreen_loader.dart';
import 'package:fro9/utils/popups/tloader.dart';
import 'package:fro9/utils/validators/validation.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';

class TSignupForm extends StatelessWidget {
  const TSignupForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final showPassword = true.obs;
    // final privacyPolicy = true.obs;
    final email = TextEditingController();
    final userName = TextEditingController();
    final lastName = TextEditingController();
    final firstName = TextEditingController();
    final password = TextEditingController();
    final phoneNumber = TextEditingController();
    GlobalKey<FormState> signupFormKey = GlobalKey<FormState>();
    // Get.put(NetworkManager());
    // final controller = Get.put(SignUpController());
    return Form(
        key: signupFormKey,
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    validator: (Value) =>
                        TValidator.validateEmptyText('First Name', Value),
                    controller: firstName,
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.firstName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                ),
                const SizedBox(
                  width: TSizes.spaceBtwInputFields,
                ),
                Expanded(
                  child: TextFormField(
                    validator: (Value) =>
                        TValidator.validateEmptyText('Last Name', Value),
                    controller: lastName,
                    expands: false,
                    decoration: const InputDecoration(
                        labelText: TTexts.lastName,
                        prefixIcon: Icon(Iconsax.user)),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              controller: userName,
              validator: (Value) =>
                  TValidator.validateEmptyText('User Name', Value),
              expands: false,
              decoration: const InputDecoration(
                  labelText: TTexts.username,
                  prefixIcon: Icon(Iconsax.user_edit)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              controller: email,
              validator: (Value) => TValidator.validateEmail(Value),
              decoration: const InputDecoration(
                  labelText: TTexts.email, prefixIcon: Icon(Iconsax.direct)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            TextFormField(
              validator: (Value) => TValidator.validatePhoneNumber(Value),
              controller: phoneNumber,
              decoration: const InputDecoration(
                  labelText: TTexts.phoneNo, prefixIcon: Icon(Iconsax.call)),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            Obx(
              () => TextFormField(
                  validator: (Value) => TValidator.validatePassword(Value),
                  controller: password,
                  obscureText: showPassword.value,
                  decoration: InputDecoration(
                    labelText: TTexts.password,
                    prefixIcon: Icon(Iconsax.password_check),
                    suffixIcon: IconButton(
                        onPressed: () =>
                            showPassword.value = !showPassword.value,
                        icon: Icon(showPassword.value
                            ? Iconsax.eye_slash
                            : Iconsax.eye)),
                  )),
            ),
            const SizedBox(
              height: TSizes.spaceBtwInputFields,
            ),
            const TTermsAndConditionBox(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () async {
                    try {
                      print("Hana d5alna Nverifiw");
                      TFullScreenLoader.openLoadingDialog(
                          'We are processing your information.....',
                          TImages.verifyIllustration);

                      if (!signupFormKey.currentState!.validate()) {
                        return;
                      }
                      if (!TTermsAndConditionBox.privacyPolicy) {
                        TLoader.warningSnackBar(
                            title: "Accept Privacy Policy",
                            message:
                                "In order to create an account you must have to read and accept the policy policy and terms of use");
                      }
                      AuthenticationRepository.instance
                          .registerWithEmailAndPassword(
                              email.text.trim(), password.text.trim());
                    } catch (e) {
                      TLoader.errorSnackBar(
                          title: 'Oh Snap', message: e.toString());
                    } finally {
                      TFullScreenLoader.stopLoading();
                    }
                  },
                  child: Text("Create Account")),
            )
          ],
        ));
  }
}
