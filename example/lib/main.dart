import 'package:connectivity_builder/connectivity_builder.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: ConnectivityBuilder(
          offlineBuilder: (context) => const Center(
            child: Text('No internet connection!'),
          ),
          onlineBuilder: (context) => const Center(
            child: Text('Internet connection available'),
          ),
        ),
      ),
    );
  }
}
