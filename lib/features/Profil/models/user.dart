import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String uid;
  String username;
  String firstName;
  String lastName;
  String userNature;
  String phone;
  String? photoURL;

  UserModel({
    required this.uid,
    required this.userNature,
    required this.username,
    required this.lastName,
    required this.phone,
    this.photoURL,
    required this.firstName,
  });

  factory UserModel.fromQueryDocumentSnapshot(QueryDocumentSnapshot snapshot) {
    return UserModel(
        uid: snapshot['uid'],
        username: snapshot['username'],
        firstName: snapshot['firstname'],
        lastName: snapshot['lastname'],
        userNature: snapshot['userNature'],
        phone: snapshot['phone'],
        photoURL: snapshot['photo_URL'] ??
            "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80");
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'username': username,
      'firstname': firstName,
      'lastname': lastName,
      'userNature': userNature,
      'phone': phone,
      'photo_URL': photoURL ??
          "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80"
    };
  }

  @override
  String toString() {
    return 'UserModel{uid: $uid, username: $username, firstName: $firstName, lastName: $lastName, userNature: $userNature, phone: $phone, photoURL: $photoURL}';
  }
}
