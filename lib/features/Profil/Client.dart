import 'dart:html';
import 'dart:io'as io;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waffir/common/widgets/appbar/app_bar.dart';

import 'package:waffir/features/Profil/profile_controller.dart';

import 'package:waffir/utils/constants/colors.dart';

import '../authentification/screens/logindart/login.dart';
import 'Geolocalisation.dart';
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

class client extends StatefulWidget {

  const client({super.key});
//Theme.of(context).textTheme.headlineMedium!.apply(color: TColors.white))
  @override
  State<client> createState() => _ClientState();
}

class _ClientState extends State<client> {

  ProfileController profileController = Get.find();
  final ImagePicker _picker = ImagePicker();
  XFile? _profilePicture;

  @override
  Widget build(BuildContext context) {
    return   Scaffold(
      backgroundColor: TColors.primary,

      appBar: TAppBar(
          title:  Text('Profil',
              style: Theme.of(context).textTheme.headlineMedium!.apply(color:TColors.white)),
          actions: [
            IconButton(
              onPressed:  _signOut,
              icon: const Icon(Icons.logout_rounded),
            )
          ]

        /**actions:[
            puceNotif(onPressed: () {}, iconColor: TColors.white, )

            ]**/),
      body: GetBuilder(
        init: profileController,
        builder: (context) {
          return ListView(
            padding: const EdgeInsets.all(10),
            children: [
              // COLUMN THAT WILL CONTAIN THE PROFILE
              Column(
                children:  [

                  CircleAvatar(
                    radius: 50,
                    backgroundImage: NetworkImage(
                      "https://images.unsplash.com/photo-1554151228-14d9def656e4?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=386&q=80",
                    ),

                    child:
                    Align(
                        alignment: Alignment.bottomRight,
                    child: IconButton(
                      icon: Icon(Icons.image_rounded), onPressed: ()
                    async {
                      final XFile? image = await _picker.pickImage(
                          source: ImageSource.gallery);
                      if (image != null) {
                        setState(() {
                          _profilePicture = image;
                          profileController.profilePicture.value =
                          _profilePicture!;
                        });
                      }
                      },)
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Welcome ${profileController.userFetchedFirst} ${profileController.userFetchedLast}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 40),
                  Text(
                    'Account type: ${profileController.userNature}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),

          const SizedBox(height: 40),
              const SizedBox(height: 75),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: ListTile(
                    leading: Icon(Icons.location_on_outlined),
                    title: Text("Modify account"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _ModifyTaped,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: ListTile(
                    leading: Icon(Icons.location_on_outlined),
                    title: Text("Location"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _LocationTaped,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: ListTile(
                    leading: Icon(Icons.location_on_outlined),
                    title: Text("Log out"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: _logout,
                  ),
                ),
              ),
              /**...List.generate(
                customListTiles.length,
                    (index) {
                  final tile = customListTiles[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 15),
                    child: Card(
                      elevation: 4,
                      shadowColor: Colors.black12,
                      child: ListTile(
                        leading: Icon(tile.icon),
                        title: Text(tile.title),
                        trailing: const Icon(Icons.chevron_right),
                        onTap: tile.function,
                      ),
                    ),
                  );
                },
              ),**/
              const SizedBox(height: 35),

            ],
          );
        }
      ),

    );
  }

}
class CustomListTile {
  final IconData icon;
  final String title;
  final  function;
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

_LocationTaped()  {
  Get.to(GeolocalisationScreen());

}

Future<void> _signOut() async {
  await FirebaseAuth.instance.signOut();
  Get.offAll(LoginScreen());
}
 _logout()  {
   FirebaseAuth.instance.signOut();
  Get.offAll(LoginScreen());
}

 _ModifyTaped()  {
Get.to(ModifyUserScreen());
 }
