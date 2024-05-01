import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:waffir/common/widgets/appbar/app_bar.dart';
import 'package:waffir/utils/constants/colors.dart';

import '../authentification/screens/login/login.dart';
import 'ModifyUserScreen.dart';

class ProfileCompletionCard {
  final String title;
  final String buttonText;
  final IconData icon;
  ProfileCompletionCard({
    required this.title,
    required this.buttonText,
    required this.icon,
  });
}

class GeolocalisationScreen extends StatelessWidget {
  const GeolocalisationScreen({super.key});
//Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white))

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primary,
      appBar: TAppBar(
          title: Text('Tracking',
              style: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .apply(color: TColors.white)),
          actions: const [
            IconButton(
              onPressed: _signOut,
              icon: Icon(Icons.logout_rounded),
            )
          ]),
    );
  }
}

class CustomListTile {
  final IconData icon;
  final String title;
  final Future function;
  CustomListTile({
    required this.icon,
    required this.title,
    required this.function,
  });
}

List<CustomListTile> customListTiles = [
  CustomListTile(
    icon: Icons.location_on_outlined,
    title: "Location",
    function: _LocationTaped(),
  ),
  CustomListTile(
    title: "Notifications",
    icon: CupertinoIcons.bell,
    function: _ModifyTaped(),
  ),
  CustomListTile(
    title: "Logout",
    icon: CupertinoIcons.arrow_right_arrow_left,
    function: _signOut(),
  ),
];

_LocationTaped() {
  Get.to(() => const GeolocalisationScreen());
}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
  Get.offAll(() => LoginScreen());
}

_logout() {
  FirebaseAuth.instance.signOut();
  Get.offAll(() => LoginScreen());
}

_ModifyTaped() {
  Get.to(() => const ModifyUserScreen());
}
