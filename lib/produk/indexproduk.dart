import 'dart:async';
import 'package:belajar_ukk/penjualan/indexpenjualan.dart';
import 'package:belajar_ukk/penjualan/keranjang.dart';
import 'package:belajar_ukk/produk/insertproduk.dart';
import 'package:belajar_ukk/produk/updateproduk.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class Produk extends StatefulWidget {
  const Produk({super.key});

  @override
  State<Produk> createState() => _ProdukTabState();
}

class _ProdukTabState extends State<Produk> {
  List<Map<String, dynamic>> produk = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchProduk();
  }

  Future<void> fetchProduk() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await Supabase.instance.client.from('produk').select();
      setState(() {
        produk = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching produk: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteProduk(int id) async {
    try {
      await Supabase.instance.client.from('produk').delete().eq('ProdukID', id);
      fetchProduk();
    } catch (e) {
      print('Error deleting produk: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.green, Colors.black],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: isLoading
            ? Center(
                child: LoadingAnimationWidget.twoRotatingArc(
                    color: Colors.grey, size: 30),
              )
            : produk.isEmpty
                ? Center(
                    child: Text(
                      'Tidak ada produk',
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2, crossAxisSpacing: 12),
                    padding: EdgeInsets.all(8),
                    itemCount: produk.length,
                    itemBuilder: (context, index) {
                      final prd = produk[index];

                      return InkWell(
                        onTap: () async {
                          var result = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProdukDetail(),
                            ),
                          );
                          if (result == true) {}
                        },
                        child: Card(
                          elevation: 4,
                          margin: EdgeInsets.symmetric(vertical: 8),
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12)),
                          child: SizedBox(
                            height: 200,
                            child: Padding(
                              padding: EdgeInsets.all(12),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    prd['NamaProduk'] ?? 'Nama Tidak Tersedia',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Harga: Rp${prd['Harga']}',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  SizedBox(height: 8),
                                  Text(
                                    '${prd['Stok']} pcs',
                                    style: TextStyle(fontSize: 14),
                                  ),
                                  const Divider(),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.edit,
                                            color: Colors.grey),
                                        onPressed: () async {
                                          final ProdukID = prd['ProdukID'] ?? 0;
                                          if (ProdukID != 0) {
                                            var hasil = await Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Editproduk(
                                                            ProdukID:
                                                                ProdukID)));
                                            if (hasil == true) {
                                              fetchProduk();
                                            }
                                          } else {
                                            print('ID produk tidak valid');
                                          }
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.delete,
                                            color: Colors.redAccent),
                                        onPressed: () {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) {
                                                return AlertDialog(
                                                    title: const Text(
                                                        'Hapus Produk'),
                                                    content: const Text(
                                                        'Apakah Anda yakin ingin menghapus produk ini?'),
                                                    actions: [
                                                      TextButton(
                                                        onPressed: () =>
                                                            Navigator.pop(
                                                                context),
                                                        child:
                                                            const Text('Batal'),
                                                      ),
                                                      TextButton(
                                                        onPressed: () {
                                                          deleteProduk(
                                                              prd['ProdukID']);
                                                          Navigator.pop(
                                                              context);
                                                        },
                                                        child:
                                                            const Text('Hapus'),
                                                      )
                                                    ]);
                                              });
                                        },
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          var hasil = await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => addproduk()),
          );
          if (hasil == true) {
            fetchProduk();
          }
        },
        backgroundColor: Colors.green[400],
        child: Icon(Icons.add),
      ),
    );
  }
}
