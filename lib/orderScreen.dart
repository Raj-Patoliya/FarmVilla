import 'dart:developer';
import 'dart:convert';
import 'package:farmvilla/Services/FirebaseServices.dart';
import 'package:farmvilla/menubar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class ProfileScreen2 extends StatefulWidget {
  const ProfileScreen2({Key? key}) : super(key: key);

  @override
  State<ProfileScreen2> createState() => _ProfileScreen2State();
}



class _ProfileScreen2State extends State<ProfileScreen2> {

  var userData;
  @override
  void initState() {
    super.initState();
    getUserByEmail();
  }
  getUserByEmail() async{
    var result = await FirebaseFirestore.instance
        .collection("userDetails")
        .where("email", isEqualTo: UserData().email)
        .get();
    setState(() {
      userData = result.docs.single.data();
    });
  }

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
          CircleAvatar(
            child: ClipOval(
              child:Image.network(FirebaseAuth.instance!.currentUser!.photoURL.toString(),
                height: 90,
                width: 90,
                fit: BoxFit.cover,
              ),
            ),
          ),
           Text(
            userData['username'],
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                userData['address'],
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
            child: const Text("Button"),
            onPressed: () async  {
            },
          ),
        ],
      ),
    );
  }
}


