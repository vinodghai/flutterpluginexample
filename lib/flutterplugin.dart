import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';

class Flutterplugin {
  static const MethodChannel _channel = const MethodChannel('flutterplugin');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }

  static Future<DeviceInfo> getDeviceInfo() async {
    final String json = await _channel.invokeMethod('getDeviceInfo');
    Map<String, dynamic> map = jsonDecode(json);
    return DeviceInfo.fromJson(map);
  }
}

class DeviceInfo {
  String os;
  String version;
  String manufacturer;

  factory DeviceInfo.fromJson(Map<String, dynamic> map) {
    return DeviceInfo._internal(map["os"], map["version"], map["manufacturer"]);
  }

  DeviceInfo._internal(this.os, this.version, this.manufacturer);

  DeviceInfo();
}
