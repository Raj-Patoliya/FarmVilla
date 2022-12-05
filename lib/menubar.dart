import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmvilla/EmptyCart.dart';
import 'package:farmvilla/Policy.dart';
import 'package:farmvilla/ProductGrid.dart';
import 'package:farmvilla/Services/FirebaseServices.dart';
import 'package:farmvilla/cartScreen.dart';
import 'package:farmvilla/home.dart';
import 'package:farmvilla/orderScreen.dart';
import 'package:farmvilla/profileScreen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class MenuBar extends StatefulWidget {
  const MenuBar({Key? key}) : super(key: key);

  @override
  State<MenuBar> createState() => _MenuBarState();
}

class _MenuBarState extends State<MenuBar> {

  @override
  void initState() {


  }
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
                child: FirebaseAuth.instance!.currentUser?.email  == null ?
                Image.asset("assets/profile_pic.png",
                  height: 90,
                  width: 90,
                  fit: BoxFit.cover,) :
                Image.network( FirebaseAuth.instance!.currentUser!.photoURL.toString(),
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
            onTap: () async {
              FirebaseAuth.instance!.currentUser?.email  !=null ?
              Navigator.push(context,MaterialPageRoute(builder: (context) =>  OrderScreen(),), )
              :
              null;
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.add_shopping_cart_outlined),
            title: const Text('My Cart'),
            onTap: () =>FirebaseServices()?.isLoggedIn() == true ? Navigator.push(context,MaterialPageRoute(builder: (context) => const CartScreen(),), ) :Navigator.push(context,MaterialPageRoute(builder: (context) => const EmptyCart()),),
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.description),
            title: const Text('Policies'),
            onTap: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const Policy(),), );
            },
          ),
          const Divider(),
          ListTile(
            leading: const Icon(Icons.exit_to_app),
            title: Text(FirebaseAuth.instance!.currentUser?.email  !=null ? "Logout" : "SignIn with Google"),
            onTap: () async{
              FirebaseAuth.instance!.currentUser?.email  !=null ?
              await FirebaseServices().signOut()
              : await FirebaseServices().signInWithGoogle();
              Navigator.push(context,MaterialPageRoute(builder: (context) =>  HomePage(),), );
            },
          ),
        ],
      ),
    );
  }
}

