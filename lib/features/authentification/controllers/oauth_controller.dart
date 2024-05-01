import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:waffir/features/Profil/models/user.dart';

class OauthController extends GetxController {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<UserModel> signInWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);

    UserCredential userCredentials =
        await _auth.signInWithCredential(credential);

    if (userCredentials.additionalUserInfo!.isNewUser) {
      _firestore.collection('userDetail').doc(userCredentials.user!.uid).set({
        'uid': userCredentials.user!.uid,
        'username': userCredentials.user!.displayName,
        'photo_URL': userCredentials.user!.photoURL,
        'firstname': userCredentials.user!.displayName,
        'lastname': userCredentials.user!.displayName,
        'userNature': 'Buyer',
        'phone': userCredentials.user!.phoneNumber,
      });
    }
    UserModel user = UserModel(
      uid: userCredentials.user!.uid,
      photoURL: userCredentials.user!.photoURL!,
      username: userCredentials.user!.email!,
      firstName: userCredentials.user!.displayName!,
      lastName: userCredentials.user!.displayName!,
      userNature: 'Buyer',
      phone: userCredentials.user!.phoneNumber!,
    );
    return user;
  }
}
