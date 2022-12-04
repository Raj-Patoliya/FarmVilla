import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmvilla/ProductGrid.dart';
import 'package:farmvilla/cartScreen.dart';
import 'package:farmvilla/menubar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
                onPressed: () {
                  Navigator.push(context,MaterialPageRoute(builder: (context) => const CartScreen(),), );
                },
                icon: const Icon(
                  Icons.shopping_cart,
                  color: Colors.white,
                ))
          ],
          title: const Text(
            "FarmVilla",
            style: TextStyle(
              color: Color.fromARGB(255, 201, 245, 120),
            ),
          ),
          backgroundColor: const Color.fromARGB(255, 3, 151, 27),
        ),
        drawer:const MenuBar(),
        body: const ProductGrid(),


    );
  }
}

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<String> categories = ["Fruits", "Vegetables"];
  int selectedIndex = 0;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 25,
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemCount: categories.length,
          itemBuilder: (context, index) => subCategories(index)),
    );
  }

  Widget subCategories(int index){
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            categories[index],
            style:const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 9, 63, 12)
            ),
          ),
        ],
      ),
    );
  }
}
