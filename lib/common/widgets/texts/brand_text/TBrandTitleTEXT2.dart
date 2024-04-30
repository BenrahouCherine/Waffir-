import 'package:flutter/material.dart';
import 'package:waffir/common/widgets/texts/brand_text/TBrandTitleText.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/enums.dart';
import 'package:waffir/utils/constants/sizes.dart';

class TBrandTitleTextw extends StatelessWidget {
  const TBrandTitleTextw({
    super.key,
    required this.title,  this.maxlines=1, required this.textColor, this.iconColor=TColors.primary, this.textAlign=TextAlign.left ,  this.brandTextSizes=TextSizes.small

  });
final String title ;
final int maxlines ; 
final Color? textColor , iconColor ; 
final TextAlign? textAlign ; 
final TextSizes brandTextSizes;
  @override
  Widget build(BuildContext context) {
    return Row(
    mainAxisSize: MainAxisSize.min,
     children: [
      Flexible(
        child: TBrandTitleText(
           title: title ,
           color:textColor,
           maxlines: maxlines , 
           textAlign: textAlign , 
           brandTextSizes:brandTextSizes , 
          

        )
        
        
        
        
        ),
       
    
       const SizedBox(width: TSizes.xs),
       
     ],
    );
  }
}

