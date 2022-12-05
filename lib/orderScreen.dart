import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmvilla/EmptyCart.dart';
import 'package:farmvilla/Services/FirebaseServices.dart';
import 'package:farmvilla/detailedOrder.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

// final ProductController controller = Get.put(ProductController());
const qty = 3;
int total = 300;
class OrderScreen extends StatefulWidget {
  const OrderScreen({Key? key}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  final CollectionReference _cart = FirebaseFirestore.instance.collection("order");
  var productData;
  var countIterator;
  var countProduct = 0;
  var pId;
  var cartItem = [];
  var cartProductId = [];
  var orderId = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderList();
  }

  getOrderId(String orderId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('orderId', orderId);
  }

  getOrderList () async {
    CollectionReference _collectionRef = FirebaseFirestore.instance.collection('order');
    QuerySnapshot querySnapshot = await _collectionRef.where("email", isEqualTo: UserData().email).get();

    setState(() {
      productData = querySnapshot.docs.map((doc) => doc.data()).toList();
      countProduct = querySnapshot.docs.length;
      countIterator = countProduct;
      int i =0;
      for (var snapshot in querySnapshot.docs) {
        var documentID = snapshot.id; //
        orderId.add(documentID);
        i++;
      }
      print(orderId);
    });
  }


  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title:const Text(
        "My Order",
      ),
    );
  }

  Widget orderListView() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      itemCount: countProduct,
      itemBuilder: (_, index) {
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
              Padding(
                padding: const EdgeInsets.only(left: 10),

                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      productData[index]['username'].toString(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    Text(
                      'Order of '+productData[index]['orderDate'].toString(),
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400),
                    ),
                  ],

                ),

              ),

              const Spacer(),
              SizedBox(width: 30, height:100,child:
              IconButton(
                  icon: Icon(Icons.arrow_forward_ios),
                  onPressed: (){
                    getOrderId(orderId[index].toString());
                    Navigator.push(context,MaterialPageRoute(builder: (context) => const DetailedOder(),), );
                    },
              )
              ),
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _appBar(context),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 10,
            child: qty > 0 ? orderListView() : const EmptyCart(),
          ),
          bottomBarTitle(),
        ],
      ),
    );
  }
}
