library connectivity_builder;

import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

/// A widget that builds different UIs based on network connectivity status.
///
/// The [onlineBuilder] is shown when the device has an active network connection.
/// The [offlineBuilder] is shown when there is no connection.
/// The [loadingBuilder] is shown while the initial connectivity check is in progress.
/// If [loadingBuilder] is not provided, [offlineBuilder] is used as a fallback.
class ConnectivityBuilder extends StatefulWidget {
  const ConnectivityBuilder({
    super.key,
    required this.offlineBuilder,
    required this.onlineBuilder,
    this.loadingBuilder,
  });

  final Widget Function(BuildContext context) offlineBuilder;
  final Widget Function(BuildContext context) onlineBuilder;
  final Widget Function(BuildContext context)? loadingBuilder;

  @override
  State<ConnectivityBuilder> createState() => _ConnectivityBuilderState();
}

class _ConnectivityBuilderState extends State<ConnectivityBuilder> {
  final _connectivity = Connectivity();

  /// null means the initial check hasn't completed yet.
  bool? _isConnected;

  late StreamSubscription<ConnectivityResult> _subscription;

  @override
  void initState() {
    super.initState();

    _connectivity.checkConnectivity().then(_updateStatus);

    _subscription = _connectivity.onConnectivityChanged.listen(_updateStatus);
  }

  void _updateStatus(ConnectivityResult result) {
    if (mounted) {
      setState(() => _isConnected = result != ConnectivityResult.none);
    }
  }

  @override
  void dispose() {
    _subscription.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (_isConnected == null) {
      return widget.loadingBuilder != null
          ? widget.loadingBuilder!(context)
          : widget.offlineBuilder(context);
    }

    return _isConnected!
        ? widget.onlineBuilder(context)
        : widget.offlineBuilder(context);
  }
}
