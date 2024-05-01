import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String? uid;
  String sellerUid;
  String category;
  String name;
  String description;
  String market;
  String img;
  int price;
  String quantity;

  ProductModel({
    this.uid,
    required this.sellerUid,
    required this.name,
    required this.category,
    required this.description,
    required this.market,
    required this.img,
    required this.price,
    required this.quantity,
  });

  factory ProductModel.fromQuerySnapshot(QueryDocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return ProductModel(
      uid: doc.id,
      sellerUid: data['seller_uid'],
      category: data['category'],
      name: data['name'],
      description: data['description'],
      market: data['market'],
      img: data['img'],
      price: int.parse(data['price']),
      quantity: data['quantity'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'seller_uid': sellerUid,
      'category': category,
      'name': name,
      'description': description,
      'market': market,
      'img': img,
      'price': price.toString(),
      'quantity': quantity,
    };
  }

  @override
  String toString() {
    return 'ProductModel(uid: $uid, sellerUid: $sellerUid, category: $category, description: $description, market: $market, img: $img, price: $price, quantity: $quantity)';
  }
}
