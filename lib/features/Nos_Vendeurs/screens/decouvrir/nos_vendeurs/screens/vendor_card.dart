import 'package:flutter/material.dart';
import 'package:waffir/features/Profil/models/user.dart';

class VendorCard extends StatelessWidget {
  const VendorCard({
    super.key,
    required this.vendor,
    required this.numberOfProducts,
  });

  final UserModel vendor;
  final int numberOfProducts;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(vendor.photoURL!),
        ),
        title: Text('${vendor.firstName} ${vendor.lastName}'),
        subtitle: Text('Nombre de produits: $numberOfProducts'),
      ),
    );
  }
}
