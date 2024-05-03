import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class UserModel {
  LatLng? location;
  String uid;
  String username;
  String firstName;
  String lastName;
  String userNature;
  String phone;
  String? photoURL;
  int? productsCount;

  UserModel({
    this.location,
    this.productsCount,
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
      location: snapshot['location'] == null
          ? null
          : LatLng(snapshot['location']['latitude'],
              snapshot['location']['longitude']),
      uid: snapshot['uid'],
      username: snapshot['username'],
      firstName: snapshot['firstname'],
      lastName: snapshot['lastname'],
      userNature: snapshot['userNature'],
      phone: snapshot['phone'],
      photoURL: snapshot['photo_URL']?.toString() == null
          ? "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80"
          : snapshot['photo_URL'],
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
        location: json['location'] == null
            ? null
            : LatLng(
                json['location']['latitude'], json['location']['longitude']),
        uid: json['uid'],
        username: json['username'],
        firstName: json['firstname'],
        lastName: json['lastname'],
        userNature: json['userNature'],
        phone: json['phone'],
        photoURL: json['photo_URL'] ??
            "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80");
  }

  Map<String, dynamic> toMap() {
    return {
      'location': location == null
          ? null
          : {
              'latitude': location!.latitude,
              'longitude': location!.longitude,
            },
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
    return 'UserModel{location: ${location.toString()}, uid: $uid, username: $username, firstName: $firstName, lastName: $lastName, userNature: $userNature, phone: $phone, photoURL: $photoURL}';
  }
}
