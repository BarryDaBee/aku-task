import 'package:aku_task/src/app/app.dart';
import 'package:aku_task/src/di/locator.dart';
import 'package:flutter/material.dart';

void main() {
  setupDependencies();
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const AkuTaskApp());
}

