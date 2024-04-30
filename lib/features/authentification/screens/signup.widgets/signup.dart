import 'dart:js_interop';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:iconsax/iconsax.dart';
import 'package:waffir/utils/constants/colors.dart';
import 'package:waffir/utils/constants/image_strings.dart';
import 'package:waffir/utils/constants/sizes.dart';
import 'package:waffir/utils/constants/text_strings.dart';
import 'verify_email.dart';
import 'package:waffir/model/firebase_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:waffir/model/firebase_firestore.dart';



class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override


  _CreateAccountState createState() => _CreateAccountState();
}

class _CreateAccountState extends State<SignupScreen> {
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
                
                TTexts.signupTitle,
         
                style: Theme.of(context).textTheme.headlineMedium,
              ),
              const SizedBox(height: 28,),
              Form(
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            expands: false,
                            controller: _firstController,
                            decoration: const InputDecoration(
                              labelText: TTexts.firstName,
                              prefixIcon: Icon(Iconsax.user,color:TColors.secondary),
                            ),
                          ),
                        ),
                        const SizedBox(width: TSizes.spaceBtwInputFields,),
                        Expanded(
                          
                          child: TextFormField(
                            expands: false,
                            controller: _lastController,
                            decoration: const InputDecoration(
                              labelText: TTexts.lastName,
                              prefixIcon: Icon(Iconsax.user,color:TColors.secondary),
                            ),
                          ),
                        ),//TextFormField(),
                      ],
                    ),
                    const SizedBox(height: 14),
                    TextFormField(
                            //expands: false,
                      controller: _userController,
                            decoration: const InputDecoration(
                              labelText: TTexts.username,
                              prefixIcon: Icon(Iconsax.user_edit ,color: TColors.secondary),
                            ),),
                                                const SizedBox(height: 14),
                            TextFormField(
                           // expands: false,
                              controller: _emailController,
                              decoration: const InputDecoration(
                              labelText: TTexts.email,
                                prefixIcon: Icon(Iconsax.direct,color: TColors.secondary),
                            ),),
                             const SizedBox(height: 14),
                            TextFormField(
                            expands: false,
                              controller: _phoneController,
                            decoration: const InputDecoration(
                              labelText: TTexts.phoneNo,
                              prefixIcon: Icon(Iconsax.call,color: TColors.secondary),
                            ),),
                             const SizedBox(height: 14),
                            TextFormField(
                            obscureText: true,
                              controller: _passwordController,
                              decoration: const InputDecoration(
                              labelText: TTexts.password,
                              prefixIcon: Icon(Iconsax.password_check , color: TColors.secondary),
                              suffixIcon: Icon(Iconsax.eye_slash,color: TColors.secondary),
                            ),),
                    const SizedBox(height: 14),
                    const Text(
                      "What would you do in our application ?",
                      style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold),
                    ),
                  const SizedBox(height: 14),
                    Padding(
                      padding: const EdgeInsets.only(left: 30),
                      child: Row(
                        children: [
                          Radio(
                              value: "Seller",
                              activeColor: Colors.amberAccent,
                              groupValue: groupValue,
                              onChanged: (value) {
                                setState(() {
                                  groupValue = value!;
                                });
                              }),
                          const Text(
                            "Sell",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Radio(
                              value: "Buyer",
                              activeColor: Colors.amberAccent,
                              groupValue: groupValue,
                              onChanged: (value) {
                                setState(() {
                                  groupValue = value!;
                                });
                              }),
                          const Text(
                            "Buy",
                            style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 28),


                    SizedBox(width: double.infinity , child:ElevatedButton(onPressed: () { _signUp(); }
                   ,
                      child: const Text('Create Account'),
                    ),
                    ),
                  ],
                ),
              ),
                                const SizedBox(height: 28,),

              const Row(
        mainAxisAlignment: MainAxisAlignment.center ,
        children: [
        Flexible(child: Divider(color: Color.fromARGB(207, 0, 0, 0), thickness: 0.5 ,  indent:60 , endIndent: 5,)),
        Text(TTexts.orSignUpWith,),
        Flexible(child: Divider(color: Color.fromARGB(207, 0, 0, 0), thickness: 0.5 ,  indent:5 , endIndent: 60,)),
       ],),
          const SizedBox(height: 14),

       Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
Container(
  decoration: BoxDecoration(border: Border.all(color:TColors.grey),borderRadius: BorderRadius.circular(100)),
  child: IconButton(
    onPressed: (){},
     icon: const Image(
width: TSizes.iconMd,
height: TSizes.iconMd,
image: AssetImage(TImages.google),
     )
     )
)
            ],
          ),],
          
        ),
      ),)
    );


  }

  Future _signUp() async {
    String firstname=_firstController.text;
    String lastname=_lastController.text;
    String username=_userController.text;
    String password=_passwordController.text;
    String email =_emailController.text;
    String phone=_phoneController.text;
    bool verification=false;
    User? user= await _auth.signUpWithEmailAndPassword(email, password);
    if (user != null ){
      print (' user succesfully added');
      Map<String,dynamic>userDetail= { 'uid':user.uid
        ,'username': username,
        'firstname': firstname,
        'lastname': lastname,
        'phone': phone,
        'isvalidated': verification.toString(),
        'userNature':groupValue,
      };
      CollectionReference collectionReference=FirebaseFirestore.instance.collection('userDetail');
      collectionReference.doc(username).set(userDetail);
      print(collectionReference);
      print(userDetail);
      FirebaseAuth.instance.currentUser!.sendEmailVerification();
      Fluttertoast.showToast(msg: "User is successfully created");
      Get.offAll(() => VerifyEmailScreen()) ;
    } else {
        Fluttertoast.showToast(msg: "Some error happend");
       //var future = Get.to(()=> const VerifyEmailScreen();
    }
    }
  }
