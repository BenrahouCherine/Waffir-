import 'package:flutter/material.dart';
import 'package:waffir/utils/constants/colors.dart';

class ProductTitleText extends StatelessWidget {
  const ProductTitleText({
    super.key, required this.title,  this.smallSize = false ,  this.maxLines = 2 , this.textAlign = TextAlign.left,
  });
   final String title ;
   final bool smallSize ;
   final int maxLines ; 
   final TextAlign? textAlign ; 
  @override
  Widget build(BuildContext context) {
    return Text(
     title ,
      style: smallSize? Theme.of(context).textTheme.labelLarge!.apply(color: TColors.black) : Theme.of(context).textTheme.titleSmall!.apply(color: TColors.black),

      overflow: TextOverflow.ellipsis,
      maxLines: maxLines,
      textAlign: textAlign,
      
      );
  }
}