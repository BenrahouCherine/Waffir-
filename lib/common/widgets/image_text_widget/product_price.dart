import 'package:flutter/material.dart';

class ProductPrice extends StatelessWidget {
  const ProductPrice({
    super.key,  this.currencySign=' da', required this.price,  this.maxLines = 1,  this.isLarge = false,  this.lineThrough=false,
  });
final String currencySign , price ;
final int maxLines;
final bool isLarge ;
final bool lineThrough ;

  @override
  Widget build(BuildContext context) {
    return Text(
     price + currencySign ,
      maxLines:maxLines,
      overflow: TextOverflow.ellipsis ,
      style: isLarge ? Theme.of(context).textTheme.headlineMedium!.apply(color: Colors.black ,decoration:  lineThrough? TextDecoration.lineThrough : null)
      :Theme.of(context).textTheme.titleLarge!.apply(color: Colors.black ,decoration: lineThrough? TextDecoration.lineThrough : null)
    ,
    );
  }
}