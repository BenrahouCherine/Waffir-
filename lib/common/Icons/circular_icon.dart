import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/sizes.dart';

class CircularIcon extends StatelessWidget {
  const CircularIcon({
    super.key, this.width, this.height, this.size = TSizes.lg, required this.icon, this.color, this.backgroundColor=Colors.white, this.onPressed,
  });
final double ? width, height , size ;
final IconData icon ; 
final Color? color ;
final Color? backgroundColor ;
final VoidCallback? onPressed ;
  

  @override
  Widget build(BuildContext context) {
    return Container(
    width: width ,
    height: height ,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(100), 
      color: backgroundColor,
    
    ),
    child: IconButton(onPressed: onPressed , icon :  Icon(icon , color: color,size: size,) )
    );
  }
}

