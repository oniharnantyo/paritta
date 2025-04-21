import 'package:flutter/material.dart';
import 'package:paritta_app/app/app.dart';
import 'package:paritta_app/bootstrap.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  bootstrap(() => const App());
}
