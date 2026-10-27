import 'package:entrecomunidad/app.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await _loadEnv();
  runApp(const EntreComunidadApp());
}

Future<void> _loadEnv() async {
  try {
    await dotenv.load(fileName: '.env');
    return;
  } catch (_) {}
  try {
    await dotenv.load(fileName: '.env.example');
  } catch (_) {
    // Valores por defecto en ApiConfig.
  }
}
