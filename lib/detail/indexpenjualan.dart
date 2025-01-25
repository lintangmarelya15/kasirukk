import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';


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
    fetchdetail();
  }

  Future<void> fetchdetail() async{
    setState(() {
      isLoading = true;
    });
    try {
      final response = await Supabase.instance.client.from('detailpenjualan').select();
      setState(() {
        detailll = List<Map<String, dynamic>>.from(response);
        isLoading = false;
      });
    } catch (e) {
      print('error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: isLoading
      ? Center(child: LoadingAnimationWidget.twoRotatingArc(color: Colors.grey, size: 30))
      : detailll.isEmpty
      ? Center(
        child: Text('Detail penjualan tidak ada',
        style: TextStyle(fontSize: 18),
        ),
      )
      : ListView.builder(
        itemCount: detailll.length,  
        itemBuilder: (context, index){
          final detail = detailll[index];  // Mengakses data berdasarkan index
          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(vertical: 8),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)
            ),
            child: SizedBox(
             
              child: Padding(
                padding: EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,  // Merapikan teks
                  children: [
                    Row(
                      children: [
                        Text('Detail ID: ${detail['Detailid']?.toString() ?? 'tidak tersedia'}',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 28),
                    Text('Penjualan ID: ${detail['Penjualanid']?.toString() ?? 'tidak tersedia'}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 28),
                    Text('Produk ID: ${detail['Produkid']?.toString() ?? 'tidak tersedia'}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 28),
                    Text('Jumlah Produk: ${detail['JumlahProduk']?.toString() ?? 'tidak tersedia'}',
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(width: 28),
                    Text('Subtotal: ${detail['Subtotal']?.toString() ?? 'tidak tersedia'}',
                      style: TextStyle(fontSize: 16),
                    ),
                      ],
                    )
                  ],
                ),
              )
            ),
          );
        },
      ),
    );
  }
}