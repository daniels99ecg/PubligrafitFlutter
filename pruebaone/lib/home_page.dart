import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:pruebaone/Login.dart';

import 'main.dart';

import 'firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      // Remove the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Listado de Compras',
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // text fields' controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();


  final CollectionReference _productss =
      FirebaseFirestore.instance.collection('products');


  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _priceController.text = documentSnapshot['price'].toString();
      _cantidadController.text=documentSnapshot['cantidad'].toString();
    }

    await showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (BuildContext ctx) {
          return Padding(
            padding: EdgeInsets.only(
                top: 20,
                left: 20,
                right: 20,
                
                bottom: MediaQuery.of(ctx).viewInsets.bottom + 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _nameController,
                  decoration: const InputDecoration(labelText: 'Nombre'),
                ),
                TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  controller: _priceController,
                  decoration: const InputDecoration(
                    labelText: 'Precio',
                  ),
                ),
                  TextField(
                  keyboardType:
                      const TextInputType.numberWithOptions(decimal: false),
                  controller: _cantidadController,
                  decoration: const InputDecoration(
                    labelText: 'Cantidad',
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                  child: Text(action == 'create' ? 'Create' : 'Update'),
                  onPressed: () async {
                    final String? name = _nameController.text;
                    final double? price =
                        double.tryParse(_priceController.text);
                    final double? cantidad=
                        double.tryParse(_cantidadController.text);
                    if (name != null && price != null) {
                      if (action == 'create') {
                        // Persist a new product to Firestore
                        await _productss.add({"name": name, "price": price, "cantidad":cantidad});
                      }

                      if (action == 'update') {
                        // Update the product
                        await _productss
                            .doc(documentSnapshot!.id)
                            .update({"name": name, "price": price, "cantidad":cantidad});
                      }

                      // Clear the text fields
                      _nameController.text = '';
                      _priceController.text = '';
                      _cantidadController.text="";

                      // Hide the bottom sheet
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          );
        });
  }

  
  Future<void> _deleteProduct(String productId) async {
    await _productss.doc(productId).delete();

    
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text('You have successfully deleted a product')));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Listado de Compras'),
      ),
      

//Menu desde aqui

drawer: Drawer(
        child: ListView(
          children: <Widget>[
            
              UserAccountsDrawerHeader(
              accountName: Text("Daniel"),
              accountEmail: Text('danielsenju1999@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(
                    "https://static.vecteezy.com/system/resources/previews/000/439/863/original/vector-users-icon.jpg"),
              ),
             ),
 ListTile(
              leading: const Icon(Icons.home),
              title: const Text("Home"),
              onTap: () {
                  // Navigator.push(context,
                  //             MaterialPageRoute(builder: (context) =>  Index()));
              },
            ),
               ListTile(
              leading: const Icon(Icons.add_shopping_cart),
              title: const Text("Compras"),
              onTap: () {
                  Navigator.pushNamed(context,
                  "/home"
                  );
         

              },
            ),
             ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Perfil"),
               onTap: () {
                  Navigator.pushNamed(
                    context,
                    "/perfil");
               },
            ),
          

           Container(
                color: Colors.black,
                width: double.infinity,
                height: 0.1,
              ),
                ListTile(
                
                leading: const Icon(Icons.logout_sharp),
                title: const Text("Cerrar Sesión"),
               onTap: (){
              Navigator.pushNamed(context,
              "/"
              );
                
               },
                         ),
            

          ],

        ),
      ),


      // Using StreamBuilder to display all products from Firestore in real-time
      body: StreamBuilder(
        stream: _productss.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> streamSnapshot) {
          if (streamSnapshot.hasData) {
            return ListView.builder(
              itemCount: streamSnapshot.data!.docs.length,
              itemBuilder: (context, index) {
                final DocumentSnapshot documentSnapshot =
                    streamSnapshot.data!.docs[index];


                 final int  result=(documentSnapshot["price"].toInt()* documentSnapshot["cantidad"].toInt());

                return Card(
                  margin: const EdgeInsets.all(10.0),
                  child: ListTile(
                    title: Column(
                      
                      children: [
                    
                        Text('Nombre:${documentSnapshot['name']}', style: TextStyle(fontSize: 16),),

                        Text('Precio:${documentSnapshot["price"].toString()}', style: TextStyle(fontSize: 16),),
                      
                        Text('Cantidad:${documentSnapshot['cantidad'].toString()}', style: TextStyle(fontSize: 16),),

                         Text('Total: ${result.toString()}'),
                        
                      ],
                    ),
                    
                    trailing: SizedBox(
                      width: 195,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          // Press this button to edit a single product
                          IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () =>
                                  _createOrUpdate(documentSnapshot)),
                          // This icon button is used to delete a single product
                          IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () =>
                                  _deleteProduct(documentSnapshot.id)),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
      // Add new product
      floatingActionButton: FloatingActionButton(
        onPressed: () => _createOrUpdate(),
        child: const Icon(Icons.add),
      ),
    );
  }
}