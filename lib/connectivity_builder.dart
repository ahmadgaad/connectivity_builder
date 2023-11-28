library connectivity_builder;

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

class ConnectivityBuilder extends StatefulWidget {
  const ConnectivityBuilder({
    super.key,
    required this.offlineBuilder,
    required this.onlineBuilder,
  });

  final Widget Function(BuildContext context) offlineBuilder;
  final Widget Function(BuildContext context) onlineBuilder;

  @override
  State<ConnectivityBuilder> createState() => _ConnectivityBuilderState();
}

class _ConnectivityBuilderState extends State<ConnectivityBuilder> {
  final connectivity = Connectivity();
  ConnectivityResult? isConnected;
  late StreamSubscription subscription;
  @override
  void initState() {
    super.initState();
    connectivity.checkConnectivity().then((result) {
      setState(() {
        isConnected = result;
      });
    });
    subscription = connectivity.onConnectivityChanged.listen((result) {
      setState(() {
        isConnected = result;
      });
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return isConnected != ConnectivityResult.none
        ? widget.onlineBuilder(context)
        : widget.offlineBuilder(context);
  }
}
