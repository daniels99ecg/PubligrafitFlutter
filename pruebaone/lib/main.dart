import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pruebaone/Login.dart';
import 'package:pruebaone/editPerfil.dart';
import 'package:pruebaone/home_page.dart';
import 'package:pruebaone/register.dart';

import 'firebase_options.dart';
import 'home_new.dart';
import 'miPeril.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}



class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/",
      routes: {
       "/":(context) => const MyLoginPage(title: 'Login'),
         "/perfil": (context) => const MyPerfil(),
         "/edit": (context) => const EditProfile(),
         "/home":(context)=> const HomePage(),
         "/Homeprincipal": (context)=> HomePageNew(),
         "/register":(context)=>  RegisterPage(title: "Registrar",),
      },
    );
  }
}