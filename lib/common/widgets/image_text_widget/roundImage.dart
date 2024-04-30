import 'package:flutter/material.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/sizes.dart';

class RoundImage extends StatelessWidget {
  const RoundImage({
    super.key, this.width , this.height, required this.imagurl,  this.applyImageRadius=true, this.border,  this.backgroundColor =TColors.light, this.fit=BoxFit.fill, this.padding,  this.isNetworkingImage=false, this.onPressed,  this.borderRadius =TSizes.md,
  });
  final double? width, height ;
  final String imagurl;
  final bool applyImageRadius ;
  final BoxBorder ? border;
  final Color backgroundColor ;
  final BoxFit? fit ;
  final EdgeInsetsGeometry? padding ;
  final bool isNetworkingImage ; 
  final VoidCallback? onPressed ;
  final double borderRadius ;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
       onTap : onPressed, 
      child: Container(
        width: width,
        height: height ,
        padding : padding ,

      decoration: BoxDecoration(
        border: border ,
        color : backgroundColor , 
      borderRadius: BorderRadius.circular(borderRadius)),
      
      child: ClipRRect( borderRadius:applyImageRadius?  BorderRadius.circular(borderRadius): BorderRadius.zero,
      child:  Image(fit: fit , image: isNetworkingImage?NetworkImage(imagurl):  AssetImage(imagurl)as ImageProvider,))
      
      ),
    );
  }
}
