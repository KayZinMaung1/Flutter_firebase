import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'firebase_crud/screen/firebase_crud_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(FirebaseCrudApp());
}


