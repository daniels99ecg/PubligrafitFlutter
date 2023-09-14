import 'package:cloud_firestore/cloud_firestore.dart';

FirebaseFirestore db = FirebaseFirestore.instance;


Future<List> getPerfil() async {
  List clientes = [];
  CollectionReference collectionReference = db.collection("users");

  QuerySnapshot queryCliente = await collectionReference.get();
  for (var documento in queryCliente.docs) {
    final Map<String, dynamic> data = documento.data() as Map<String,
        dynamic>; 
    final cliente = {
      "uid": documento.id,
      "firstname": data["firstname"],
      "lastname": data["lastname"],
      "age": data["age"],
      "email": data["email"],
      "password": data["password"],
    };
    clientes.add(cliente);
  }
  return clientes;
}


// add 
Future<void> adUsers(String firstname, String lastname, String age,
    String email,  String passsword) async {
  await db.collection("users").add({
    "firstname": firstname,
    "lastname": lastname,
    "age": age,
    "email": email,
    "password": passsword,
  });
}



Future<void> updateProfile(String uid, String nombre, String apellido, String edad, String correo, String contrasena ) async{
  await db.collection("users").doc(uid).set({
    "firstname":nombre,
    "lastname":apellido,
    "age": edad,
    "email":correo,
    "password":contrasena
  });
}
