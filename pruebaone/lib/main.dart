import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pruebaone/Login.dart';
import 'firebase_options.dart';
import 'miPeril.dart';



class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      initialRoute: "/",
      routes: {
       "/":(context) => const MyLoginPage(title: 'Login'),
        // "/": (context) => const MyPerfil() 
      },
    );
  }
}