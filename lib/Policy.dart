import 'package:flutter/material.dart';

class Policy extends StatelessWidget {
  const Policy({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('FarmVilla Policies'),
        ),
        body: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/Polici.png'), fit: BoxFit.fill),
          ),
        ),
      ),
    );
  }
}
