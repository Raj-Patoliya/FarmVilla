import 'dart:developer';
import 'dart:convert';
import 'package:farmvilla/menubar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfileScreen2 extends StatelessWidget {
  const ProfileScreen2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Profile",
          style: TextStyle(
            color: Color.fromARGB(255, 201, 245, 120),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 3, 151, 27),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.network(FirebaseAuth.instance!.currentUser!.photoURL.toString()),
          const Text(
            "Hello Sina!",
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "Hello Welcome To FarmVilla!",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              ),
              const SizedBox(width: 10),
            ],
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Colors.green,
              onPrimary: Colors.white,
              shadowColor: Colors.greenAccent,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(23.0)),
              minimumSize: Size(340, 40), //////// HERE
            ),
            child: const Text("Login With Google"),
            onPressed: () async  {
              // await FirebaseServices().signInWithGoogle();
              // Navigator.push(context,MaterialPageRoute(builder: (context) => const ProfileScreen2(),), );
            },
          ),
        ],
      ),
    );
  }
}


