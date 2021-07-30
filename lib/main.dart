import 'package:flutter/material.dart';
import 'package:flutter_workbook/app.dart';
import 'package:flutter_workbook/common/api/index.dart';

void main() {
  HttpManager.init();
  runApp(FlutterReduxApp());
}
