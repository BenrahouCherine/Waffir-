import 'package:flutter/material.dart';

import 'package:waffir/utils/constants/enums.dart';

class TBrandTitleText extends StatelessWidget {
  const TBrandTitleText({super.key, 
  this.color, 
  required this.title, 
   this.maxlines = 1, 
  this.textAlign=TextAlign.left, 
   this.brandTextSizes = TextSizes.small});
 
final Color? color ; 
final String title ;
final int maxlines ;
final TextAlign? textAlign ; 
final TextSizes brandTextSizes ; 


  @override
  Widget build(BuildContext context) {
    return Text(
      title , 
      textAlign: textAlign,
      maxLines: maxlines,
      overflow: TextOverflow.ellipsis,

      style: brandTextSizes == TextSizes.small
      ? Theme.of(context).textTheme.labelMedium!.apply(color: color)
      :brandTextSizes == TextSizes.medium
      ? Theme.of(context).textTheme.bodyLarge!.apply(color: color)
      : brandTextSizes== TextSizes.large
      ? Theme.of(context).textTheme.titleLarge!.apply(color: color)
      :Theme.of(context).textTheme.bodyMedium!.apply(color: color),

      
    );
  }
}