import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Pruebas extends StatelessWidget{
   Pruebas({super.key});
final User = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
   return Scaffold(
appBar: AppBar(
  centerTitle: true,
  title: Text('Registro'),
  actions: [
    IconButton(
      onPressed: (){},
       icon: const Icon(Icons.login))
  ],
),
body: Center(
  child: Text(User!.email.toString()),
),
   );
  }

}