import 'package:belajar_ukk/home_page.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DetailPenjualan extends StatefulWidget {
  const DetailPenjualan({super.key});

  @override
  State<DetailPenjualan> createState() => _DetailPenjualanState();
}

class _DetailPenjualanState extends State<DetailPenjualan> {
  List<Map<String, dynamic>> detailll = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    fetchDetail();
  }

  Future<void> fetchDetail() async {
    setState(() => isLoading = true);
    try {
      final response = await Supabase.instance.client
        .from('detailpenjualan')
        .select('*, penjualan(*, pelanggan(*)), produk(*)')
        .order('TanggalPenjualan', ascending: false,referencedTable: 'penjualan');
      print(response);
      setState(() => detailll = List<Map<String, dynamic>>.from(response));
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() => isLoading = false);
    }
  }

  Future<void> transaksi(int PelangganID, int Subtotal) async {
    try {
      await Supabase.instance.client.from('penjualan').insert({
        'PelangganID': PelangganID,
        'TotalHarga': Subtotal,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Pesanan berhasil disimpan!')),
      );
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
    } catch (e) {
      print('Error: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Terjadi kesalahan saat menyimpan pesanan')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Penjualan'),
        centerTitle: true,
      ),
      body: isLoading
          ? Center(
              child: LoadingAnimationWidget.fourRotatingDots(
                color: Colors.blue,
                size: 40,
              ),
            )
          : detailll.isEmpty
              ? const Center(
                  child: Text(
                    'Tidak ada detail penjualan.',
                    style: TextStyle(fontSize: 18),
                  ),
                )
              : ListView.builder(
                  padding: const EdgeInsets.all(12),
                  itemCount: detailll.length,
                  itemBuilder: (context, index) {
                    final detail = detailll[index];
                    final int Subtotal = int.tryParse(detail['Subtotal'].toString()) ?? 0;
                    return Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(16),
                        title: Text(
                          'Produk: ${detail['produk']['NamaProduk'] ?? '-'}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Nama Pelanggan: ${detail['penjualan']['pelanggan']['NamaPelanggan'] ?? '-'}'),
                            Text('Jumlah: ${detail['JumlahProduk'] ?? '-'}'),
                            Text('Subtotal: Rp. ${detail['Subtotal'] ?? '-'}'),
                            Text('Tanggal Penjualan: ${detail['penjualan']['TanggalPenjualan'] ?? '-'}'),
                          ],
                        ),
                        // trailing: ElevatedButton(
                        //   onPressed: () => transaksi(1, Subtotal),
                        //   child: const Text('Pesan'),
                        // ),
                      ),
                    );
                  },
                ),
      floatingActionButton: FloatingActionButton(
        onPressed: fetchDetail,
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
