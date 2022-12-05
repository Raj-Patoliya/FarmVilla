import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmvilla/EmptyCart.dart';
import 'package:farmvilla/Services/FirebaseServices.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
class DetailedOder extends StatefulWidget {
  const DetailedOder({Key? key}) : super(key: key);

  @override
  State<DetailedOder> createState() => _DetailedOderState();
}
var itemLength  = 0;
int total = 300;
var orderData ;
var orderItemData = [];
class _DetailedOderState extends State<DetailedOder> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrderId();
    getOrderDetails();
  }
  getOrderId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String orderId = prefs.getString('orderId') ?? '';
    return orderId;
  }
  getOrderDetails()async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String orderId = prefs.getString('orderId') ?? '';
    DocumentReference doc_ref= FirebaseFirestore.instance.collection("order").doc(orderId);
    DocumentSnapshot docSnap = await doc_ref.get();
    setState(() {
      orderData = docSnap.data();
      itemLength = orderData['cartItems'].length;
    });
    for(var i = 0;i<itemLength;i++)
      {
        DocumentReference doc_ref= FirebaseFirestore.instance.collection("product").doc(orderData['cartItems'][i]);
        DocumentSnapshot docSnap = await doc_ref.get();
        orderItemData.add(docSnap.data());
      }
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      title:const Text(
        "Order Details",
      ),
    );
  }

  Widget orderListView() {
    return ListView.builder(
      shrinkWrap: true,
      padding: const EdgeInsets.all(20),
      itemCount: itemLength ,
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
              Container(
                padding: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: const Color.fromARGB(255, 206, 234, 247)),
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20)),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: Image.asset(
                      "assets/profile_pic.png",
                      width: 43,
                      height: 120,
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
                    const Text(
                      "Babu bhaiya",
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          fontWeight: FontWeight.w600, fontSize: 15),
                    ),
                    Text(
                      "babu bhiya bare sayane",
                      style: TextStyle(
                          color: Colors.black.withOpacity(0.5),
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
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
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Name : "+orderData['username'].toString(),style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
            Text("Mobile no : "+orderData['mobile'].toString(),style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
            Text("Address : "+orderData['address'].toString() +" "+orderData['pincode'].toString() ,style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
            Text("Order Date : "+orderData['orderDate'].toString(),style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
            Text("Expected delivery :"+orderData['deliveryDate'].toString(),style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
            Text("Total : "+orderData['totalPayment'].toString(),style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400)),
          ],
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
            flex: 1,
            child: itemLength > 0 ? orderListView() : const EmptyCart(),
          ),
          bottomBarTitle(),
        ],
      ),
    );
  }
}
