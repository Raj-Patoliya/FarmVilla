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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const MenuBar(),
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
        body: const Categories());
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
