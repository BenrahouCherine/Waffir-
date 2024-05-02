// ignore_for_file: non_constant_identifier_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waffir/features/Profil/models/user.dart';
import 'package:waffir/features/orders/client/models/order_item.dart';

class OrderModel {
  String? uid;
  String buyer_uid;
  String seller_uid;
  String status;
  String adresse;
  String wilaya;
  String daira;
  String commune;
  String created_at;
  String updated_at;
  UserModel? buyer;
  UserModel? seller;
  List<OrderItem> orderItems;

  OrderModel({
    this.uid,
    required this.buyer_uid,
    required this.seller_uid,
    required this.status,
    required this.adresse,
    required this.wilaya,
    required this.daira,
    required this.commune,
    required this.created_at,
    required this.updated_at,
    this.buyer,
    this.seller,
    required this.orderItems,
  });

  factory OrderModel.fromQuerySnapshot(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return OrderModel(
      uid: doc.id,
      buyer_uid: data['buyer_id'] ?? '',
      seller_uid: data['seller_uid'],
      status: data['status'],
      adresse: data['adresse'] ?? '',
      wilaya: data['wilaya'],
      daira: data['daira'],
      commune: data['commune'],
      created_at: data['created_at'],
      updated_at: data['updated_at'],
      buyer: UserModel.fromJson(data['buyer']),
      seller: UserModel.fromJson(data['seller']),
      orderItems: (data['order_items'] as List<dynamic>)
          .map((orderItemJson) =>
              OrderItem.fromJson(orderItemJson as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'buyer_uid': buyer_uid,
      'seller_uid': seller_uid,
      'status': status,
      'adresse': adresse,
      'wilaya': wilaya,
      'daira': daira,
      'commune': commune,
      'created_at': created_at,
      'updated_at': updated_at,
      'buyer': buyer?.toMap(),
      'seller': seller?.toMap(),
      'order_items': orderItems.map((orderItem) => orderItem.toMap()).toList(),
    };
  }

  @override
  String toString() {
    return 'OrderModel{uid: $uid, buyer_uid: $buyer_uid, seller_uid: $seller_uid, status: $status, adresse: $adresse, wilaya: $wilaya, daira: $daira, commune: $commune, created_at: $created_at, updated_at: $updated_at, buyer: $buyer, seller: $seller, orderItems: $orderItems}';
  }
}
