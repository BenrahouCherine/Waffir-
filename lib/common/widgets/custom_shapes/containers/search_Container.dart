import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/utils/constants/sizes.dart';

class SearchContainer extends StatelessWidget {
  const SearchContainer({
    super.key,
    this.icon = Iconsax.search_normal,
    this.showBackground = false,
    this.showBorder = true,
    this.onChanged,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final IconData? icon;
  final bool showBackground, showBorder;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Iconsax.search_normal,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
          border: InputBorder.none,
          hintText: 'Rechercher',
        ),
      ),
    );
  }
}
