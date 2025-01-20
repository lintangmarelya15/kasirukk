import 'package:belajar_ukk/penjualan/insertpenjualan.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class PenjualanTab extends StatefulWidget {
  @override
  _PenjualanTabState createState() => _PenjualanTabState();
}

class _PenjualanTabState extends State<PenjualanTab> {
  List<Map<String, dynamic>> penjualan = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchPenjualan();
  }

  Future<void> fetchPenjualan() async {
    setState(() {
      isLoading = true;
    });
    try {
      final response = await Supabase.instance.client.from('penjualan').select();
      setState(() {
        penjualan = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (e) {
      print('Error fetching penjualan: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> deleteBarang(int id) async {
    try {
      await Supabase.instance.client.from('penjualan').delete().eq('id', id);
      fetchPenjualan();
    } catch (e) {
      print('Error deleting barang: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.twoRotatingArc(color: Colors.grey, size: 30),
            )
          : penjualan.isEmpty
              ? Center(
                  child: Text(
                    'Tidak ada penjualan',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                )
              : GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  ),
                  padding: EdgeInsets.all(8),
                  itemCount: penjualan.length,
                  itemBuilder: (context, index) {
                    final jual = penjualan[index];
                    return Card(
                      elevation: 4,
                      margin: EdgeInsets.symmetric(vertical: 8),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      child: SizedBox(
                        height: 150,
                        width: 20,
                        child: Padding(
                          padding: EdgeInsets.all(12),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                jual['TanggalPenjualan'] ?? 'Tanggal tidak tersedia',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20,
                                ),
                              ),
                              SizedBox(height: 4),
                              Text(
                                'Total Harga: ${jual['TotalHarga'] ?? 'Tidak tersedia'}',
                                style: TextStyle(
                                  fontStyle: FontStyle.italic, fontSize: 16, color: Colors.grey,
                                ),
                              ),
                              SizedBox(height: 8),
                              Text(
                                'Pelanggan ID: ${jual['Pelangganid'] ?? 'Tidak tersedia'}',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 14,
                                ),
                                textAlign: TextAlign.justify,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: () { 
          Navigator.push(context, MaterialPageRoute(builder: (context) => AddTransaksi()));

        },
        child: Icon(Icons.add),
      ),
    );
  }
}