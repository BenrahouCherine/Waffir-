import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/features/Profil/profile_controller.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/image_strings.dart';
import 'package:waffir/utils/constants/sizes.dart';
import 'package:waffir/utils/constants/text_strings.dart';
import 'package:waffir/model/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waffir/model/firebase_firestore.dart';
import 'package:get/get.dart';

import '../authentification/screens/logindart/login.dart';

class ModifyUserScreen extends StatefulWidget {
  const ModifyUserScreen({Key? key}) : super(key: key);

  @override


  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<ModifyUserScreen> {
  String groupValue="Seller";
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _firstController = TextEditingController();
  final TextEditingController _lastController = TextEditingController();
  final TextEditingController _userController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final FirebaseAuthService _auth=FirebaseAuthService();


  @override
  void dispose() {
    _firstController.dispose();
    _lastController.dispose();
    _userController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    ProfileController profileController=Get.find();
    _userController.text = profileController.userFetched.toString();
    _lastController.text = profileController.userFetchedLast.toString();
    _firstController.text = profileController.userFetchedFirst.toString();
    _phoneController.text = profileController.phone.toString();

    return Scaffold(
        backgroundColor: TColors.primary,
        appBar: AppBar(),
        body: SingleChildScrollView(

          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(

                  "Modify user",

                  style: Theme.of(context).textTheme.headlineMedium,
                ),
                const SizedBox(height: 38,),
                Form(
                  child: Column(
                    children: [
                      const SizedBox(height: 24),
                      TextFormField(
                        //expands: false,
                        controller: _firstController,
                        expands: false,
                        decoration: const InputDecoration(

                          prefixIcon: Icon(Iconsax.user,color:TColors.secondary),
                        ),
                      ),

                      const SizedBox(height: 24),
                      TextFormField(
                        expands: false,
                        controller: _lastController,
                        decoration: const InputDecoration(

                          prefixIcon: Icon(Iconsax.user,color:TColors.secondary),
                        ),

                      ),
                      const SizedBox(height: 24),
                      TextFormField(
                        //expands: false,
                        controller: _userController,
                        readOnly: true,
                        decoration:  InputDecoration(
                        //  labelText: usernameFetched,
                         // labelText: TTexts.username,
                          prefixIcon: Icon(Iconsax.user_edit ,color: TColors.secondary),
                        ),),

                      const SizedBox(height: 24),
                      TextFormField(
                        expands: false,
                        controller: _phoneController,
                        decoration: const InputDecoration(

                          prefixIcon: Icon(Iconsax.call,color: TColors.secondary),
                        ),),




                      const SizedBox(height: 58),


                      SizedBox(width: double.infinity , child:ElevatedButton(onPressed: () { _modify(); }
                        ,
                        child: const Text('Modify user'),
                      ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 28,),


                const SizedBox(height: 14),

                ],

            ),
          ),)
    );


  }

  Future _modify() async {
    String user=  FirebaseAuth.instance.currentUser!.uid;
    String firstname=_firstController.text;
    String lastname=_lastController.text;
    String username=_userController.text;
    String phone=_phoneController.text;

    if (user != null ){
      Map<String,dynamic>userDetail= { 'uid':user
        ,
        'firstname': firstname,
        'lastname': lastname,
        'phone': phone,
      };
      print('entry request of');
      CollectionReference collectionReference=FirebaseFirestore.instance.collection('userDetail');
      print('mid request of');
      print(firstname);
      print(username);
      print(phone);
      collectionReference.doc(username).update(userDetail).then((value) => print('succesfully modify'),onError: (e)=>print("error type $e"));
      print('back request of');
      print(collectionReference);
      print(userDetail);
      _showDialogAlert(context);

    } else {
      Fluttertoast.showToast(msg: "Some error happend");
      //var future = Get.to(()=> const VerifyEmailScreen();
    }
  }

  void _showDialogAlert(BuildContext Context){
    showDialog(
        context: context,
        builder: (BuildContext){
          return AlertDialog(
            backgroundColor: Colors.amberAccent,
            title: const Text('Modify State Alert'),
            content: const Text('Your profile has been updated, you need to log in'),
            actions: <Widget>[
              TextButton(onPressed:() {
                FirebaseAuth.instance.signOut();
              Get.offAll(LoginScreen());
              }, child: const Text(TTexts.tContinue))
            ],
          );
        });
  }

}
