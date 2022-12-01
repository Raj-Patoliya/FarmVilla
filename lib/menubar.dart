import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmvilla/Services/FirebaseServices.dart';
import 'package:farmvilla/home.dart';
import 'package:farmvilla/orderScreen.dart';
import 'package:farmvilla/profileScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MenuBar extends StatelessWidget {
  const MenuBar({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(""),
            accountEmail: Text(FirebaseAuth.instance!.currentUser?.email  !=null ? FirebaseAuth.instance!.currentUser!.displayName.toString() : "",
              style:  TextStyle(fontSize: 18),
            ),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child:Image.network(FirebaseAuth.instance!.currentUser?.email  !=null ? FirebaseAuth.instance!.currentUser!.photoURL.toString(): "",
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            decoration: const BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage(
                      "assets/drawback.jpeg",
                    ),
                    fit: BoxFit.cover)),
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Profile'),
            onTap: () => FirebaseServices().isLoggedIn() == true? Navigator.push(context,MaterialPageRoute(builder: (context) => const ProfileScreen(),), ) :{},
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.notifications),
            title: const Text('My Orders'), // my order
            onTap: () {},
            trailing: ClipOval(
              child: Container(
                color: Colors.red,
                width: 20,
                height: 20,
                child: const Center(
                  child: Text("2",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12
                    ),
                  ),
                ),
              ),
            ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart_outlined),
            title: const Text('My Cart'),
            onTap: () =>Navigator.push(context,MaterialPageRoute(builder: (context) => const ProfileScreen2(),), ),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Policies'),
            onTap: () => null,
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(FirebaseAuth.instance!.currentUser?.email  !=null ? "Logout" : "SignIn with Google"),
            onTap: () async{
              FirebaseAuth.instance!.currentUser?.email  !=null ? await FirebaseServices().signOut() :
              await FirebaseServices().signInWithGoogle();
              Navigator.push(context,MaterialPageRoute(builder: (context) =>  HomePage(),), );
            },
          ),
        ],
      ),
    );
  }
}
