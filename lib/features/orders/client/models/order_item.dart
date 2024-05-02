// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waffir/features/addProduct/model/product.dart';

class OrderItem {
  String? uid;
  String order_uid;
  String product_uid;
  String quantity;
  int prix_total;
  String created_at;
  String updated_at;
  ProductModel product;

  OrderItem({
    this.uid,
    required this.order_uid,
    required this.product_uid,
    required this.quantity,
    required this.prix_total,
    required this.created_at,
    required this.updated_at,
    required this.product,
  });

  factory OrderItem.fromQuerySnapshot(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return OrderItem(
      uid: doc.id,
      order_uid: data['order_uid'],
      product_uid: data['product_uid'],
      quantity: data['quantity'],
      prix_total: data['prix_total'],
      created_at: data['created_at'],
      updated_at: data['updated_at'],
      product: ProductModel.fromQuerySnapshot(data['product']),
    );
  }
  // from json

  factory OrderItem.fromJson(Map<String, dynamic> json) {
    return OrderItem(
        order_uid: json['order_uid'],
        product_uid: json['product_uid'],
        quantity: json['quantity'],
        prix_total: json['prix_total'],
        created_at: json['created_at'],
        updated_at: json['updated_at'],
        product: ProductModel.fromJson(json['product']));
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'order_uid': order_uid,
      'product_uid': product_uid,
      'quantity': quantity,
      'prix_total': prix_total,
      'created_at': created_at,
      'updated_at': updated_at,
      'product': product.toMap(),
    };
  }
}
