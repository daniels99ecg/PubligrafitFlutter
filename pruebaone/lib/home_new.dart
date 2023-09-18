import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Listado de Compras',
      home: HomePageNew(),
    );
  }
}

class HomePageNew extends StatefulWidget {
  const HomePageNew({Key? key}) : super(key: key);

  @override
  State<HomePageNew> createState() => _HomePageNewState();
}

class _HomePageNewState extends State<HomePageNew> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _cantidadController = TextEditingController();
  final CollectionReference _productss =
      FirebaseFirestore.instance.collection('products');
  List<Map<String, dynamic>> tempProducts = [];

  Future<void> _createOrUpdate([DocumentSnapshot? documentSnapshot]) async {
    String action = 'create';
    if (documentSnapshot != null) {
      action = 'update';
      _nameController.text = documentSnapshot['name'];
      _priceController.text = documentSnapshot['price'].toString();
      _cantidadController.text = documentSnapshot['cantidad'].toString();
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
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20,
          ),
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
                  final double? price = double.tryParse(_priceController.text);
                  final double? cantidad =
                      double.tryParse(_cantidadController.text);
                  if (name != null && price != null) {
                    if (action == 'create') {
                      // Añadir el producto a la lista temporal
                      tempProducts.add({
                        "name": name,
                        "price": price,
                        "cantidad": cantidad
                      });
                    }

                    if (action == 'update') {
                      // ...
                    }

                    // Clear the text fields
                    _nameController.text = '';
                    _priceController.text = '';
                    _cantidadController.text = '';

                    if (action == 'create') {
                      // Preguntar si desea seguir comprando
                      final bool continueShopping = await showDialog(
                        context: context,
                        builder: (BuildContext ctx) {
                          return AlertDialog(
                            title: Text('¿Desea seguir comprando?'),
                            actions: [
                              TextButton(
                                child: Text('Sí'),
                                onPressed: () {
                                  Navigator.of(ctx).pop(true);
                                  // Abre automáticamente el formulario de compra nuevamente
                                  _createOrUpdate();
                                },
                              ),
                              TextButton(
                                child: Text('No'),
                                onPressed: () {
                                  Navigator.of(ctx).pop(false);
                                },
                              ),
                            ],
                          );
                        },
                      );

                      if (!continueShopping) {
                        // Calcular el subtotal de la compra
                        double subtotalCompra = calcularSubtotalCompra(tempProducts);
                        // Calcular el IVA (19%)
                        double iva = subtotalCompra * 0.19;
                        // Calcular el total con IVA
                        double totalCompra = subtotalCompra + iva;

                        // Mostrar el total en un cuadro de diálogo
                        await showDialog(
                          context: context,
                          builder: (BuildContext ctx) {
                            return AlertDialog(
                              title: Text('Total de la compra'),
                              content: Column(
                                mainAxisSize: MainAxisSize.min,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text('Subtotal: \$${subtotalCompra.toStringAsFixed(0)}'),
                                  Text('IVA (19%): \$${iva.toStringAsFixed(0)}'),
                                  Text('Total con IVA: \$${totalCompra.toStringAsFixed(0)}'),
                                ],
                              ),
                              actions: [
                                TextButton(
                                  child: Text('Confirmar compra'),
                                  onPressed: () async {
                                    // Registrar la compra final
                                    await confirmarCompra(tempProducts);
                                    tempProducts.clear();
                                    Navigator.of(ctx).pop(); // Cerrar el cuadro de diálogo
                                  },
                                ),
                                TextButton(
                                  child: Text('Cancelar'),
                                  onPressed: () {
                                    Navigator.of(ctx).pop();
                                  },
                                ),
                              ],
                            );
                          },
                        );
                      }
                    }

                    // Hide the bottom sheet
                    Navigator.of(context).pop();
                  }
                },
              )
            ],
          ),
        );
      },
    );
  }

  Future<void> confirmarCompra(List<Map<String, dynamic>> productosCompra) async {
    final double totalCompra = calcularTotalCompra(productosCompra);

    final Map<String, dynamic> compra = {
      'fecha': Timestamp.now(),
      'productos': productosCompra,
      'total': totalCompra,
    };

    await FirebaseFirestore.instance.collection('compras').add(compra);
  }

  double calcularSubtotalCompra(List<Map<String, dynamic>> productosCompra) {
    double subtotal = 0.0;
    for (final producto in productosCompra) {
      subtotal +=
          (producto["price"] as double) * (producto["cantidad"] as double);
    }
    return subtotal;
  }

  double calcularTotalCompra(List<Map<String, dynamic>> productosCompra) {
    double subtotal = calcularSubtotalCompra(productosCompra);
    // Calcular el IVA (19%)
    double iva = subtotal * 0.19;
    // Calcular el total con IVA
    double total = subtotal + iva;
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PubliGrafit'),
      ),
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
                           Navigator.pushNamed(
                  context,
                 "/Homeprincipal"
                 );
              },
            ),
            ListTile(
              leading: const Icon(Icons.add_shopping_cart),
              title: const Text("Compras"),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/home",
                );
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text("Perfil"),
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/perfil",
                );
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
              onTap: () {
                Navigator.pushNamed(
                  context,
                  "/",
                );
              },
            ),
          ],
        ),
      ),
      body: Center(
          child: Column(
            children: [
              Card(
                 color: Color.fromARGB(255, 238, 237, 237),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                    children:<Widget> [
                      ListTile(
                        title: Column(
                          children: [
                        Image.network(
                  'http://drive.google.com/uc?export=view&id=1Zu2cm69lPkIEu09fqA4wA1B3BTL88v1w',
                  height: 100,
                ),
                            Text('Bienvenido a la App de Publigrafit' , style: TextStyle(fontWeight: FontWeight.bold),),
                             
                          ],
                        ),
                      ),
                     
                    ],
                  
                  ),
              ),

                  Card(
                 color: Color.fromARGB(255, 238, 237, 237),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                    children:<Widget> [
                      ListTile(
                        title: Column(
                          children: [
                        Image.network(
                  'https://img.freepik.com/iconos-gratis/carrito-compras_318-869187.jpg?w=2000',
                  height: 100,
                ),
                            Text('Las compras las puedes realizar por este medio' , style: TextStyle(fontWeight: FontWeight.bold),),
                             
                          ],
                        ),
                      ),
                     
                    ],
                  
                  ),
              ),



 Card(
                 color: Color.fromARGB(255, 238, 237, 237),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                    children:<Widget> [
                      ListTile(
                        title: Column(
                          children: [
                        Image.network(
                  'https://cdn-icons-png.flaticon.com/512/1600/1600225.png',
                  height: 100,
                ),
                            Text('Puedes ver el listado de tus compras' , style: TextStyle(fontWeight: FontWeight.bold),),
                             
                          ],
                        ),
                      ),
                     
                    ],
                  
                  ),
              ),
            ],

          ), 
      ),
      
      
    );
  }

}