import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 1; // Default to the "Produk" tab
  final List<Map<String, String>> _products = []; // List to store products

  void _onTabTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _addProduct(String name, String price, String stock) {
    setState(() {
      _products.add({"name": name, "price": price, "stock": stock});
    });
  }

  void _editProduct(int index, String name, String price, String stock) {
    setState(() {
      _products[index] = {"name": name, "price": price, "stock": stock};
    });
  }

  void _deleteProduct(int index) {
    setState(() {
      _products.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Informasi Kasir'),
        centerTitle: true,
        backgroundColor: Colors.green[200],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green[200],
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.person),
              title: Text('Profile'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Profile page
              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Log Out'),
              onTap: () {
                Navigator.pop(context);
                // Log out action
              },
            ),
            ListTile(
              leading: Icon(Icons.app_registration),
              title: Text('Registrasi'),
              onTap: () {
                Navigator.pop(context);
                // Navigate to Registration page
              },
            ),
          ],
        ),
      ),
      body: Center(
        child: _selectedIndex == 1
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => _buildAddProductDialog(),
                      );
                    },
                    child: Text('Tambah Produk'),
                  ),
                  SizedBox(height: 20),
                  _products.isEmpty
                      ? Text(
                          'Belum ada produk',
                          style: TextStyle(color: Colors.grey, fontSize: 16),
                        )
                      : Expanded(
                          child: ListView.builder(
                            itemCount: _products.length,
                            itemBuilder: (context, index) {
                              return ListTile(
                                title: Text(_products[index]['name'] ?? ''),
                                subtitle: Text('Harga: ${_products[index]['price']} | Stok: ${_products[index]['stock']}'),
                                trailing: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    IconButton(
                                      icon: Icon(Icons.edit),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) => _buildEditProductDialog(index),
                                        );
                                      },
                                    ),
                                    IconButton(
                                      icon: Icon(Icons.delete),
                                      onPressed: () {
                                        _deleteProduct(index);
                                      },
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ],
              )
            : Text(_selectedIndex == 0 ? 'Halaman Customer' : 'Halaman Penjualan'),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: 'Customer',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inventory),
            label: 'Produk',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'Penjualan',
          ),
        ],
      ),
    );
  }

  Widget _buildAddProductDialog() {
    final TextEditingController nameController = TextEditingController();
    final TextEditingController priceController = TextEditingController();
    final TextEditingController stockController = TextEditingController();

    return AlertDialog(
      title: Text('Tambah Produk'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Nama Produk'),
          ),
          TextField(
            controller: priceController,
            decoration: InputDecoration(labelText: 'Harga Produk'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: stockController,
            decoration: InputDecoration(labelText: 'Stok Produk'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                priceController.text.isNotEmpty &&
                stockController.text.isNotEmpty) {
              _addProduct(nameController.text, priceController.text, stockController.text);
              Navigator.pop(context);
            }
          },
          child: Text('Tambah'),
        ),
      ],
    );
  }

  Widget _buildEditProductDialog(int index) {
    final TextEditingController nameController = TextEditingController(text: _products[index]['name']);
    final TextEditingController priceController = TextEditingController(text: _products[index]['price']);
    final TextEditingController stockController = TextEditingController(text: _products[index]['stock']);

    return AlertDialog(
      title: Text('Edit Produk'),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: nameController,
            decoration: InputDecoration(labelText: 'Nama Produk'),
          ),
          TextField(
            controller: priceController,
            decoration: InputDecoration(labelText: 'Harga Produk'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: stockController,
            decoration: InputDecoration(labelText: 'Stok Produk'),
            keyboardType: TextInputType.number,
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text('Batal'),
        ),
        ElevatedButton(
          onPressed: () {
            if (nameController.text.isNotEmpty &&
                priceController.text.isNotEmpty &&
                stockController.text.isNotEmpty) {
              _editProduct(index, nameController.text, priceController.text, stockController.text);
              Navigator.pop(context);
            }
          },
          child: Text('Simpan'),
        ),
      ],
    );
  }
}
