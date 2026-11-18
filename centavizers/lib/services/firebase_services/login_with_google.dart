import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LogInWithGoogle {
  LogInWithGoogle._();
  static final LogInWithGoogle logInWithGoogle = LogInWithGoogle._();

  factory LogInWithGoogle (){
    return logInWithGoogle;
  }

  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<GoogleLoginModal?> signupWithGoogle(BuildContext context) async {
    final GoogleSignIn googleSignIn = GoogleSignIn(

      scopes: [
        'email',
        'https://www.googleapis.com/auth/contacts.readonly',
        "https://www.googleapis.com/auth/userinfo.profile"
      ],
    );


    try {

      final GoogleSignInAccount? googleSignInAccount = await  googleSignIn.signIn();

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken);


        // Getting users credential
        UserCredential result = await auth.signInWithCredential(authCredential);
        User? user = result.user;

        return GoogleLoginModal(googleSignInAuthentication: googleSignInAuthentication,user: user);

      }else{
        throw Exception('User not able to signup or login');
      }

    }catch (e){
      debugPrint(e.toString());
      throw Exception('e = > User not able to signup or login');
    }
  }


 /* Future<void> clear(BuildContext context) async {
    await GoogleSignIn().disconnect();
    FirebaseAuth.instance.signOut();
    StorageHelper().clear();
    Navigator.pushNamedAndRemoveUntil(context, RouteName.logIn, (route) => false);
  }*/
}

class GoogleLoginModal{
  User? user;
  GoogleSignInAuthentication googleSignInAuthentication;
  GoogleLoginModal({required this.googleSignInAuthentication,this.user});
}