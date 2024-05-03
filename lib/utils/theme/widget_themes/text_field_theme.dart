import 'package:flutter/material.dart';
import 'package:waffir/utils/constants/colors.dart';

import '../../constants/sizes.dart';

class TTextFormFieldTheme {
  TTextFormFieldTheme._();

  static InputDecorationTheme lightInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 3,
    prefixIconColor: const Color.fromARGB(255, 255, 255, 255),
    suffixIconColor: const Color.fromARGB(255, 255, 255, 255),
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle().copyWith(
        fontSize: TSizes.fontSizeMd,
        color: const Color.fromARGB(255, 255, 255, 255)),
    hintStyle: const TextStyle().copyWith(
        fontSize: TSizes.fontSizeSm,
        color: const Color.fromARGB(255, 255, 255, 255)),
    errorStyle: const TextStyle()
        .copyWith(fontStyle: FontStyle.normal, color: Colors.red[400]),
    floatingLabelStyle: const TextStyle().copyWith(
        color: const Color.fromARGB(255, 255, 255, 255).withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide:
          const BorderSide(width: 1, color: Color.fromARGB(255, 255, 253, 253)),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide:
          const BorderSide(width: 1, color: Color.fromARGB(255, 255, 255, 255)),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide:
          const BorderSide(width: 1, color: Color.fromARGB(255, 255, 255, 255)),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: TColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: TColors.warning),
    ),
  );

  static InputDecorationTheme darkInputDecorationTheme = InputDecorationTheme(
    errorMaxLines: 2,
    prefixIconColor: TColors.darkGrey,
    suffixIconColor: TColors.darkGrey,
    // constraints: const BoxConstraints.expand(height: TSizes.inputFieldHeight),
    labelStyle: const TextStyle()
        .copyWith(fontSize: TSizes.fontSizeMd, color: TColors.white),
    hintStyle: const TextStyle()
        .copyWith(fontSize: TSizes.fontSizeSm, color: TColors.white),
    floatingLabelStyle:
        const TextStyle().copyWith(color: TColors.white.withOpacity(0.8)),
    border: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: TColors.darkGrey),
    ),
    enabledBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: TColors.darkGrey),
    ),
    focusedBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: TColors.white),
    ),
    errorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 1, color: TColors.warning),
    ),
    focusedErrorBorder: const OutlineInputBorder().copyWith(
      borderRadius: BorderRadius.circular(TSizes.inputFieldRadius),
      borderSide: const BorderSide(width: 2, color: TColors.warning),
    ),
  );
}
