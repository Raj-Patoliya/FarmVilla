import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmvilla/EmptyCart.dart';
import 'package:farmvilla/Services/FirebaseServices.dart';
import 'package:farmvilla/deliveryDetails.dart';
import 'package:farmvilla/payment.dart';
// import 'package:farmvilla/payment.dart';
import 'package:flutter/material.dart';
import 'package:collection/collection.dart';
import 'package:shared_preferences/shared_preferences.dart';


const qty = 6;
int total = 0;


class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}
class _CartScreenState extends State<CartScreen> {
  final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  final CollectionReference _cart = FirebaseFirestore.instance.collection("cart");
  var productData;
  var countIterator;
  var countProduct = 0;
  var pId;
  var cartItem = [];
  var cartProductId = [];
  var userData;
  @override
  void initState() {
    super.initState();
    getProductForCart();
  }
  getProductForCart() async{
    var cartIds;
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('cart');
    QuerySnapshot querySnapshot = await _collectionRef.where("email", isEqualTo: UserData().email).get();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    int i = 0;
    for (var snapshot in querySnapshot.docs) {
      var documentID = snapshot.id; //
      cartItem.add(documentID);
      prefs.setString(i.toString(),documentID.toString());
      i++;
    }
    prefs.setInt('cartItemCount', cartItem.length);
    print(cartItem.length);
    print(cartItem);
    print('hello');
    // Get data from docs and convert map to List
    setState(() {
      productData = querySnapshot.docs.map((doc) => doc.data()).toList();
      countProduct = querySnapshot.docs.length;
      countIterator = countProduct;
      List<int> temp=[];
      for(int i=0;i<countProduct;i++)
        {
          cartProductId.add(productData[i]['pId'].toString());
          prefs.setString('productId'+i.toString(),productData[i]['pId'].toString());
          temp.add(productData[i]['rate'].toInt());
        }
      print(cartProductId);
      total = temp.sum ;
      prefs.setInt('totalPayment', total);
    });


  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title: const Text(
        "My cart",
      ),
    );
  }

  Widget cartListView() {
    return cartItem ==  null ? const EmptyCart():ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      itemCount: countProduct,
      itemBuilder: (_, index) {
        // Product product = controller.cartProducts[index];
        return Container(
          margin: const EdgeInsets.only(bottom: 20),
          padding: const EdgeInsets.all(15),
          height: 120,
          decoration: BoxDecoration(
              color: Colors.grey[200]?.withOpacity(0.6),
              borderRadius: BorderRadius.circular(10)),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 206, 234, 247)),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.network(
                      productData[index]['image'],
                      width: 50,
                      height: 80,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      productData[index]['pname'],
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style:
                      TextStyle(fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    Text(
                      "Rate Per 1kg",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400),
                    ),
                    Text(
                      productData[index]['rate'].toString(),
                      style: const TextStyle(
                          fontWeight: FontWeight.w900, fontSize: 20),
                    ),
                  ],
                ),
              ),
              const Spacer(),
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Row(
                  children: [
                    IconButton(
                      splashRadius: 10.0,
                      onPressed: () async {
                        print(cartItem[index]);
                        await FirebaseFirestore.instance.collection("cart").doc(cartItem[index]).delete();
                        getProductForCart();
                        },
                      icon: const Icon(
                        Icons.delete,
                        color: Color(0xFFEC6813),
                      ),
                    ),
                    // const Text(
                    //   'remove',
                    //   style:
                    //   TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
                    // ),
                    // IconButton(
                    //   splashRadius: 10.0,
                    //   onPressed: () => {},
                    //   icon: const Icon(
                    //     Icons.add,
                    //     color: Color(0xFFEC6813),
                    //   ),
                    // ),
                  ],
                ),
              )
            ],
          ),
        );
      },
    );
  }

  Widget bottomBarTitle() {
    return Expanded(
      flex: 1,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Total",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w400)),
            Text(
              "\$$total",
              key: ValueKey<int>(total),
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w900,
                color: Color(0xFFEC6813),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget bottomBarButton() {
    return Expanded(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.only(left: 30, right: 30, bottom: 10),
          child: ElevatedButton(
            child: const Text("Buy Now"),
            onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder: (context) => const DeliverDetails(),), );
            },
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: countProduct == 0 ? const Center(child:  EmptyCart(),) :  Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 10,
            child: qty > 0 ? cartListView() : const EmptyCart(),
          ),
          bottomBarTitle(),
          bottomBarButton()
        ],
      ),
    );
  }
}
