library connectivity_builder;

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

/// Provides a widget that builds one widget if the device is online and another widget if the device is offline.
///
/// The [offlineBuilder] parameter is a callback that builds the widget to display when the device is offline.
///
/// The [onlineBuilder] parameter is a callback that builds the widget to display when the device is online.
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
  /// The connectivity service instance.
  final connectivity = Connectivity();

  /// The current connectivity result.
  ConnectivityResult? isConnected;

  /// The stream subscription for connectivity changes.
  late StreamSubscription subscription;
  @override
  void initState() {
    super.initState();

    /// Check the initial connectivity status.
    connectivity.checkConnectivity().then((result) {
      setState(() {
        isConnected = result;
      });
    });

    /// Subscribe to connectivity changes.
    subscription = connectivity.onConnectivityChanged.listen((result) {
      setState(() {
        isConnected = result;
      });
    });
  }

  @override
  void dispose() {
    /// Unsubscribe from connectivity changes.
    subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    /// Determine which widget to build based on the connectivity status.
    return isConnected != ConnectivityResult.none
        /// The device is online, so build the online widget.
        ? widget.onlineBuilder(context)
        /// The device is offline, so build the offline widget.
        : widget.offlineBuilder(context);
  }
}
