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

  final CollectionReference _products = FirebaseFirestore.instance.collection("product");

  Widget _gridItemHeader() {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          FittedBox(
            child: Text(
              "Raju Rastogi",
              overflow: TextOverflow.ellipsis,
              maxLines: 100,
              style: TextStyle(
                  fontSize: 20, color: Color.fromARGB(255, 75, 73, 73)),
            ),
          ),
        ],
      ),
    );
  }

  Widget _gridItemBody() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: const Color(0xFFE5E6E8),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Image.asset("assets/Raju.jpg"),
    );
  }

  Widget _gridItemFooter() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        padding: const EdgeInsets.all(10),
        height: 60,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(15),
            bottomRight: Radius.circular(15),
          ),
        ),
        child:
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children:[
            const Expanded(child: Center(child: Text('\$100',style: TextStyle(fontSize: 20),))),
            const VerticalDivider(width: 1.0),
            Expanded(
                child: Center(
                    child: ElevatedButton(
                      onPressed: () {},
                      child:const Text("Add"),
                    ))),
          ],
        ),

      ),
    );
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: const Icon(
                Icons.search,
                color: Colors.white,
              ),
              onPressed: () {},
            ),
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
            "Farmer Home Page",
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

  // Widget subCategories(int index) {
  //   return Center(
  //     child: ButtonBar(
  //       mainAxisSize: MainAxisSize.min, // this will take space as minimum as posible(to center)
  //       children:[
  //         new RaisedButton(
  //             child: new Text('Hello'),
  //             onPressed: null,
  //           ),
  //       ],
  //     ),
  //   );
  // }

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
