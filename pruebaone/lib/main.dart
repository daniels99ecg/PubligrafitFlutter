
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pruebaone/firebase_options.dart';
import 'package:pruebaone/page/auth_page.dart';
import 'package:pruebaone/page/login_page.dart';
import 'package:pruebaone/page/sign_up_page.dart';
import 'firebase_options.dart';
void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget{
  const MyApp({super.key});


  @override
  Widget build(BuildContext context) {
   return  MaterialApp(
          debugShowCheckedModeBanner: false,

    title: 'Login',
    theme: ThemeData(),
     home:AuthPage(), 

   );
   
  }
  
  }