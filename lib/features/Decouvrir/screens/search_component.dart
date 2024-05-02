import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/utils/constants/sizes.dart';

class SearchComponent extends StatelessWidget {
  const SearchComponent({
    super.key,
    this.icon = Iconsax.search_normal,
    this.onChanged,
    this.padding = const EdgeInsets.symmetric(horizontal: TSizes.defaultSpace),
  });

  final IconData? icon;
  final ValueChanged<String>? onChanged;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: TextField(
        style: const TextStyle(color: Colors.black),
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: Icon(
            Iconsax.search_normal,
            size: 30,
            color: Theme.of(context).primaryColor,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[600]!, width: 1.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[600]!, width: 1.0),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[600]!, width: 1.0),
          ),
          hintText: 'Rechercher',
          hintStyle: TextStyle(color: Colors.grey[600]!),
        ),
      ),
    );
  }
}
