import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class FirebaseServices{
  final _auth = FirebaseAuth.instance;
  final _googleSignIn = GoogleSignIn();
  late BuildContext _context;
  signInWithGoogle() async{
    try
    {
      final GoogleSignInAccount? googleSignInAccount =
      await _googleSignIn.signIn();
      if(googleSignInAccount !=null)
      {
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
        final AuthCredential authCredential = GoogleAuthProvider.credential(
            accessToken: googleSignInAuthentication.accessToken,
            idToken: googleSignInAuthentication.idToken
        );
        await _auth.signInWithCredential(authCredential);
      }

    }on FirebaseAuthException catch(e)
    {
      throw e;
    }
  }

  signOut() async{
    print(FirebaseAuth.instance.currentUser!.email);
    await _auth.signOut();
    await _googleSignIn.signOut();
  }

  bool isLoggedIn(){
    if(FirebaseAuth.instance.currentUser?.email != null)
      {
        return true;
      }
    else
      {
        return false;
      }
  }
}
class UserData{

  // var cR = FirebaseAuth.instance.currentUser;

  String email =  FirebaseAuth.instance!.currentUser!.email.toString();
  String userName = FirebaseAuth.instance.currentUser!.displayName.toString();
  String profileUrl = FirebaseAuth.instance.currentUser!.photoURL.toString();
}