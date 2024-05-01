// ignore_for_file: must_be_immutable

import 'package:waffir/features/addProduct/model/product.dart';

class CartItem {
  final ProductModel product;
  int quantity;

  CartItem({required this.product, required this.quantity});
}
