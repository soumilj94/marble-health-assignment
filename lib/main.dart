import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:soumil_jaiswal_marbles_health_assignment/home_screen.dart';

void main() {
  setup();
  runApp(const MyApp());
}

void setup() {
  GetIt.I.registerSingleton<FormService>(FormService());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Marble heath flutter assignment',
      home: const HomeScreen(),
      theme: ThemeData.from(colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.blue)),
    );
  }
}

class FormService {
  List<Map<String, dynamic>> formData = [];

  void addData(Map<String, dynamic> data) {
    formData.add(data);
  }

  List<Map<String, dynamic>> getData() {
    return formData;
  }
}
