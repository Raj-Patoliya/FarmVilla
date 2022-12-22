import 'package:flutter/material.dart';

class EmptyCart extends StatelessWidget {
  const EmptyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        child: Center(
            child:Image.network('https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcScR-7iXnuAAkR6HYqBrsXosDMv1EipL5ybNHaVef_T8A&s')
        ),
      ),
    );
  }
}