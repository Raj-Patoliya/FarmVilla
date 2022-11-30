import 'package:farmvilla/menubar.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

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
      body: Center(
          child: Padding(
            padding:const EdgeInsets.all(14),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name text field
                 Text(FirebaseAuth.instance!.currentUser!.displayName.toString(),
                  style: TextStyle(fontSize: 25),
                 ),
                  const SizedBox(height: 15, width: 15),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: "Enter your phone number",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    ),
                  ),
                  const SizedBox(height: 20, width: 15),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: "Enter your full address",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(10))
                       ),
                    ),
                    keyboardType: TextInputType.multiline,
                    maxLines: 6,
                  ),
                  const SizedBox(height: 20, width: 30),
                  const TextField(
                    decoration: InputDecoration(
                      hintText: "Pincode",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    ),
                  ),

                  Container(
                    height: 75,
                    padding: const EdgeInsets.only(left: 30, right: 30,top: 25),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: const EdgeInsets.all(0.0),
                      ),
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [Color.fromARGB(202, 3, 83,9), Color.fromARGB(255, 70, 219, 120)],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: Container(
                          constraints:
                          const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                          alignment: Alignment.center,
                          child: const Text('Save',style: TextStyle(fontSize: 20),),
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
          )),
    );
  }
}
