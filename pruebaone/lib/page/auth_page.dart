import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pruebaone/page/login_or_signup.dart';
import 'package:pruebaone/page/login_page.dart';
import 'package:pruebaone/page/prueba.dart';

import 'home_page.dart';

class AuthPage extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream:  FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot){
            if(snapshot.connectionState==ConnectionState.waiting){
                  return const CircularProgressIndicator();
            }else{
              if(snapshot.hasData){
                  return const HomePage();
              }else{
                return const LoginAndSingUp();
              }
            }
        },
        ),
    );
  }

}