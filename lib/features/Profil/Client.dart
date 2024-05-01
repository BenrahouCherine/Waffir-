import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';
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

class Client extends StatefulWidget {
  const Client({super.key});
  @override
  State<Client> createState() => _ClientState();
}

class _ClientState extends State<Client> {
  ProfileController profileController = Get.find();
  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: TColors.primary,
      appBar: TAppBar(
          title: Text('Profil',
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
      body: Obx(() {
        return ListView(
          padding: const EdgeInsets.all(10),
          children: [
            // COLUMN THAT WILL CONTAIN THE PROFILE
            Column(
              children: [
                profileController.userLoading.value
                    ? Shimmer.fromColors(
                        baseColor: Colors.grey[300]!,
                        highlightColor: Colors.grey[100]!,
                        child: const CircleAvatar(
                            radius: 50,
                            backgroundImage: NetworkImage(
                                'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png')))
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage: profileController
                                    .user.value.photoURL !=
                                ''
                            ? NetworkImage(
                                profileController.user.value.photoURL!)
                            : const NetworkImage(
                                    'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png')
                                as ImageProvider,
                        child: Align(
                            alignment: Alignment.bottomRight,
                            child: IconButton(
                              icon: const Icon(Icons.image_rounded),
                              onPressed: () async {
                                final XFile? image = await _picker.pickImage(
                                    source: ImageSource.gallery);
                                if (image != null) {
                                  profileController.profilePicture.value =
                                      XFile(image.path);
                                  await profileController.setProfilePic();
                                }
                              },
                            )),
                      ),
                const SizedBox(height: 40),
                Text(
                  'Welcome ${profileController.user.value.firstName} ${profileController.user.value.lastName}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 40),
                Text(
                  'Account type: ${profileController.user.value.userNature}',
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 40),
            const SizedBox(height: 75),
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Card(
                elevation: 4,
                shadowColor: Colors.black12,
                child: ListTile(
                  leading: Icon(Icons.location_on_outlined),
                  title: Text("Modify account"),
                  trailing: Icon(Icons.chevron_right),
                  onTap: _ModifyTaped,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Card(
                elevation: 4,
                shadowColor: Colors.black12,
                child: ListTile(
                  leading: Icon(Icons.location_on_outlined),
                  title: Text("Location"),
                  trailing: Icon(Icons.chevron_right),
                  onTap: _LocationTaped,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(bottom: 15),
              child: Card(
                elevation: 4,
                shadowColor: Colors.black12,
                child: ListTile(
                  leading: Icon(Icons.location_on_outlined),
                  title: Text("Log out"),
                  trailing: Icon(Icons.chevron_right),
                  onTap: _logout,
                ),
              ),
            ),
            // List.generate(
            //     customListTiles.length,
            //         (index) {
            //       final tile = customListTiles[index];
            //       return Padding(
            //         padding: const EdgeInsets.only(bottom: 15),
            //         child: Card(
            //           elevation: 4,
            //           shadowColor: Colors.black12,
            //           child: ListTile(
            //             leading: Icon(tile.icon),
            //             title: Text(tile.title),
            //             trailing: const Icon(Icons.chevron_right),
            //             onTap: tile.function,
            //           ),
            //         ),
            //       );
            //     },
            //   ),
            // const SizedBox(height: 35),
          ],
        );
      }),
    );
  }
}

class CustomListTile {
  final IconData icon;
  final String title;
  final function;
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
