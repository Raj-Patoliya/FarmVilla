import 'dart:convert';
import 'package:farmvilla/Services/FirebaseServices.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Payment extends StatefulWidget {
  const Payment({Key? key}) : super(key: key);

  @override
  State<Payment> createState() => _PaymentState();
}

class _PaymentState extends State<Payment> {
  var formkey = GlobalKey<FormState>();
  TextEditingController _seats = TextEditingController();
  var seatname="";
  var eventname="";
  var seatprice="";
  int totalpayment=0;
  var availableseats=0.0;
  var seatid="";
  getdata() async
  {
    SharedPreferences prefs = await SharedPreferences.getInstance();
      setState((){
        eventname = "event_name";
        seatid = "seat_id";
        seatname = "title";
        seatprice = "price";
        availableseats = 50;
        totalpayment = prefs.getInt('totalPayment') ?? 50;
      });
    }
  @override
  void initState() {
    super.initState();
    getdata();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Ticket Booking"),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: formkey,
          child: Column(
            children: [
              SizedBox(height: 5.0,),
              Text("Total Payment : "+"Rs."+totalpayment.toString(),style: TextStyle(
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold
              ),),
              ElevatedButton(
                onPressed: (){
                    Razorpay razorpay = Razorpay();
                    var options = {
                      'key': 'rzp_test_jjvsGXFskAudUM',
                      'amount':  totalpayment * 100,
                      'name': eventname,
                      'description': seatname,
                      'retry': {'enabled': true, 'max_count': 1},
                      'send_sms_hash': true,
                      'prefill': {'contact': '7383309980', 'email': 'raj@farmvilla.com'},
                      'external': {
                        'wallets': ['paytm']
                      }
                    };
                    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
                    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
                    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
                    razorpay.open(options);
                  },
                child: Text("Pay"),
              )
            ],
          ),
        ),
      ),
    );
  }
  void handlePaymentErrorResponse(PaymentFailureResponse response){
    /*
    * PaymentFailureResponse contains three values:
    * 1. Error Code
    * 2. Error Description
    * 3. Metadata
    * */
    //Fail
    //showAlertDialog(context, "Payment Failed", "Code: ${response.code}\nDescription: ${response.message}\nMetadata:${response.error.toString()}");
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse res) async{
    /*
    * Payment Success Response contains three values:
    * 1. Order ID
    * 2. Payment ID
    * 3. Signature
    * */
    //API
    //Thankyou

    SharedPreferences prefs = await SharedPreferences
        .getInstance();
    Map<String, String> params = {
      "event_id":'101',
      "user_id":UserData().email,
      "seat_id":seatid,
      "total_payment":prefs.getInt('totalPayment').toString(),
      "number_of_person":_seats.text.toString(),
      "payment_number":res.paymentId.toString(),
      };
    }
  void handleExternalWalletSelected(ExternalWalletResponse response){

  }
    //showAlertDialog(context, "Payment Successful", "Payment ID: ${response.paymentId}");
  }