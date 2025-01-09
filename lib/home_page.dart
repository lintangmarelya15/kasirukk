import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('MAXLin'),
        actions: [
          IconButton(
            icon: Icon(Icons.translate),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          // Header section
          Container(
            color: Colors.green,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                  ],
                ),
              ],
            ),
          ),
          // Grid menu section
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(16),
              crossAxisCount: 4,
              children: [
                _buildMenuItem(Icons.point_of_sale, "POS"),
                _buildMenuItem(Icons.shopping_cart, "Kulakan"),
                _buildMenuItem(Icons.money_off, "Pengeluaran"),
                _buildMenuItem(Icons.settings, "Manajemen"),
                _buildMenuItem(Icons.list, "Transaksi"),
                _buildMenuItem(Icons.border_color, "Kelola Order"),
                _buildMenuItem(Icons.credit_card, "Kelola Hutang"),
                _buildMenuItem(Icons.label, "Mencetak label"),
                _buildMenuItem(Icons.inventory, "Kelola stok"),
                _buildMenuItem(Icons.undo, "Sales Return"),
                _buildMenuItem(Icons.add, "Add On"),
                _buildMenuItem(Icons.menu, "Menu Lain"),
              ],
            ),
          ),
          // News section
          Container(
            color: Colors.white,
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Kabar Terbaru",
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://via.placeholder.com/150/0000FF/808080?text=Passive+Income'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    SizedBox(width: 8),
                    Expanded(
                      child: Container(
                        height: 100,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                            image: NetworkImage(
                                'https://via.placeholder.com/150/FF0000/FFFFFF?text=Beli+1+Gratis+1'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Beranda",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.newspaper),
            label: "Berita",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "Akun",
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(IconData icon, String title) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(icon, size: 30, color: Colors.green),
        SizedBox(height: 8),
        Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 12),
        ),
      ],
    );
  }
}

// void main() => runApp(MaterialApp(
//       debugShowCheckedModeBanner: false,
//       home: DashboardPage(),
//     ));

