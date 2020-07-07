import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutterplugin/flutterplugin.dart';

void main() {
  runApp(_DeviceInfoWidget());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String _platformVersion = 'Unknown';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  Future<void> initPlatformState() async {
    String platformVersion;
    try {
      platformVersion = await Flutterplugin.platformVersion;
    } on PlatformException {
      platformVersion = 'Failed to get platform version.';
    }

    if (!mounted) return;

    setState(() {
      _platformVersion = platformVersion;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Text('Running on: $_platformVersion\n'),
        ),
      ),
    );
  }
}

class _DeviceInfoWidget extends StatefulWidget {
  @override
  _DeviceInfoWidgetState createState() => _DeviceInfoWidgetState();
}

class _DeviceInfoWidgetState extends State<_DeviceInfoWidget> {
  DeviceInfo _info = new DeviceInfo();

  @override
  void initState() {
    super.initState();
    initDeviceInfoState();
  }

  Future<void> initDeviceInfoState() async {
    try {
      _info = await Flutterplugin.getDeviceInfo();
    } on PlatformException {
      _info = new DeviceInfo();
    }

    if (!mounted) return;

    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Text>[
              Text("OS: ${_info.os}"),
              Text("Version: ${_info.version}"),
              Text("Manufacturer: ${_info.manufacturer}"),
            ],
          )
        ),
      ),
    );
  }
}
