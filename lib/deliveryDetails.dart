import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:farmvilla/Services/FirebaseServices.dart';
import 'package:farmvilla/menubar.dart';
import 'package:farmvilla/payment.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DeliverDetails extends StatefulWidget {
  const DeliverDetails({Key? key}) : super(key: key);

  @override
  State<DeliverDetails> createState() => _DeliverDetailsState();
}

class _DeliverDetailsState extends State<DeliverDetails> {
  final CollectionReference _userDetails = FirebaseFirestore.instance
      .collection("order");
  var lst = [];
  int count =  0;
  int totalPayment = 0;
  DateTime now = new DateTime.now();
  final TextEditingController _mobile = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _pincode = TextEditingController();

  @override
  void initState() {
    super.initState();
    getCartList();
  }
  getCartList() async{


    SharedPreferences _prefs = await SharedPreferences.getInstance();
    count = _prefs.getInt('cartItemCount') ?? 0;
    totalPayment = _prefs.getInt('totalPayment' )?? 0;
    for(int i=0;i<count;i++){
      lst.add(_prefs.getString("productId"+i.toString()));
    }
    print(lst);
    print(totalPayment);
    setState(() {
    });
    print(count);
  }
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
            padding: const EdgeInsets.all(14),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // name text field
                  Text(
                    FirebaseAuth.instance!.currentUser!.displayName.toString(),
                    style: TextStyle(fontSize: 25),
                  ),
                  const SizedBox(height: 15, width: 15),
                  TextField(
                    controller: _mobile,
                    decoration: InputDecoration(
                      hintText: "Enter your phone number",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    ),
                  ),
                  const SizedBox(height: 20, width: 15),
                  TextField(
                    controller: _address,
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
                  TextField(
                    controller: _pincode,
                    decoration: InputDecoration(
                      hintText: "Pincode",
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(10))
                      ),
                    ),
                  ),

                  Container(
                    height: 75,
                    padding: const EdgeInsets.only(
                        left: 30, right: 30, top: 25),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_address.text != "" && _pincode.text != "" &&
                            _mobile.text != "") {
                          await _userDetails.add({
                            "username": FirebaseAuth.instance!.currentUser!
                                .displayName.toString(),
                            "email": FirebaseAuth.instance!.currentUser!.email
                                .toString(),
                            "mobile": _mobile.text,
                            "address": _address.text,
                            "pincode": _pincode.text,
                            "totalPayment":totalPayment+60,
                            "cartItems":lst,
                            'orderDate':now.day.toString()+' Dec 2022',
                            'deliveryDate':(now.day + 1).toString()+' Dec 2022'
                          });
                          CollectionReference _collectionRef = FirebaseFirestore.instance.collection('cart');
                          QuerySnapshot querySnapshot = await _collectionRef.where("email", isEqualTo: UserData().email).get();
                          for (var snapshot in querySnapshot.docs) {
                            var documentID = snapshot.id; //
                            await FirebaseFirestore.instance.collection("cart").doc(documentID).delete();
                          }
                          Navigator.push(context,MaterialPageRoute(builder: (context) => const PaymentPage(),), );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(80.0)),
                        padding: const EdgeInsets.all(0.0),
                      ),
                      child: Ink(
                        decoration: const BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Color.fromARGB(202, 3, 83, 9),
                              Color.fromARGB(255, 70, 219, 120)
                            ],
                          ),
                          borderRadius: BorderRadius.all(Radius.circular(30.0)),
                        ),
                        child: Container(
                          constraints:
                          const BoxConstraints(minWidth: 88.0, minHeight: 36.0),
                          alignment: Alignment.center,
                          child: const Text('Save', style: TextStyle(
                              fontSize: 20),),
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
