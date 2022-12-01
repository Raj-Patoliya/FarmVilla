import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmvilla/menubar.dart';
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
                onPressed: () {},
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
        drawer: const MenuBar(),
        body: StreamBuilder(
          stream: _products.snapshots(),
          builder: (context,AsyncSnapshot<QuerySnapshot> streamSnapshot){
            if(streamSnapshot.hasData){
              return ListView.builder(
                  itemCount: streamSnapshot.data!.docs.length,
                itemBuilder: (context,index){
                    final DocumentSnapshot documentSnapshot =
                        streamSnapshot.data!.docs[index];
                    return Card(
                      margin: const EdgeInsets.all(10),
                      child: ListTile(
                        title: Text(documentSnapshot['name']),
                        subtitle: Text(documentSnapshot['age'].toString()),
                      )
                    );
                },
              );
            }else
              {
                return Text("No Product are to displayed...");
              }
          },
        )
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
