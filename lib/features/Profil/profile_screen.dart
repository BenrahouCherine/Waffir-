import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:waffir/common/widgets/appbar/app_bar.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/utils/constants/colors.dart';

class Client extends StatefulWidget {
  const Client({super.key});
  @override
  State<Client> createState() => _ClientState();
}

class _ClientState extends State<Client> {
  final profileController = Get.find<ProfileController>();
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
          actions: [
            IconButton(
              onPressed: () async => await profileController.signOut(),
              icon: const Icon(Icons.logout_rounded),
            )
          ]),
      body: Obx(() {
        if (profileController.userLoading.value) {
          return const Center(
            child: CircularProgressIndicator(color: Colors.yellow),
          );
        } else {
          return ListView(
            padding: const EdgeInsets.all(10),
            children: [
              // COLUMN THAT WILL CONTAIN THE PROFILE
              Column(
                children: [
                  profileController.userLoading.value
                      ? const CircularProgressIndicator(color: Colors.yellow)
                      : CircleAvatar(
                          radius: 50,
                          backgroundImage: profileController
                                      .user.value.photoURL !=
                                  ''
                              ? NetworkImage(profileController
                                      .user.value.photoURL ??
                                  'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png')
                              : const NetworkImage(
                                      'https://www.pngitem.com/pimgs/m/146-1468479_my-profile-icon-blank-profile-picture-circle-hd.png')
                                  as ImageProvider,
                          child: Align(
                            alignment: Alignment.bottomRight,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.7),
                                shape: BoxShape.circle,
                              ),
                              child: IconButton(
                                icon: const Icon(Icons.image_rounded),
                                onPressed: () async {
                                  try {
                                    profileController.userLoading.value = true;
                                    final XFile? image =
                                        await _picker.pickImage(
                                      source: ImageSource.gallery,
                                      imageQuality: 70,
                                      maxHeight: 512,
                                      maxWidth: 512,
                                    );
                                    if (image != null) {
                                      profileController.profilePicturePath
                                          .value = image.path;
                                      profileController.userLoading.value =
                                          false;
                                    }
                                  } catch (e) {
                                    profileController.userLoading.value = false;

                                    log(e.toString());
                                  } finally {
                                    profileController.userLoading.value = false;
                                  }
                                },
                              ),
                            ),
                          ),
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
              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: ListTile(
                    leading: const Icon(Icons.edit_outlined),
                    title: const Text("Modify account"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () => profileController.modifyTaped(),
                  ),
                ),
              ),
              profileController.user.value.userNature == 'Buyer'
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Card(
                        elevation: 4,
                        shadowColor: Colors.black12,
                        child: ListTile(
                          leading: const Icon(Icons.delivery_dining_outlined),
                          title: const Text("Orders"),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => profileController.ordersTaped(),
                        ),
                      ),
                    )
                  : Container(),

              Padding(
                padding: const EdgeInsets.only(bottom: 15),
                child: Card(
                  elevation: 4,
                  shadowColor: Colors.black12,
                  child: ListTile(
                    leading: const Icon(Icons.logout_outlined),
                    title: const Text("Log out"),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () async => await profileController.signOut(),
                  ),
                ),
              ),
            ],
          );
        }
      }),
    );
  }
}
