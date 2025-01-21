// import 'package:belajar_ukk/pelanggan/updatepelanggan.dart';
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class Editproduk extends StatefulWidget {
//   final int ProdukID;
//   const Editproduk({super.key, required this.ProdukID});

//   @override
//   State<Editproduk> createState() => _EditprodukState();
// }

// class _EditprodukState extends State<Editproduk> {
//   final _nmprd = TextEditingController();
//   final _harga = TextEditingController();
//   final _stok = TextEditingController();
//   final _formKey = GlobalKey<FormState>();

//   @override
//   void initState() {
//     super.initState();
//     _updateproduk();
//   }
//   Future<void> _updateproduk() async {
//     try{
//       final data = await Supabase.instance.client
//       .from('produk')
//       .select()
//       .eq('Penjualanid', widget.ProdukID)
//       .single();
//       setState(() {
//         _nmprd.text = data['NamaProduk'] ?? '';
//         _harga.text = data['Harga'] ?? '';
//         _stok.text = data['Stok'] ?? '';
//       });
//     } catch (error) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('error : $error')),
//       );
//     }
//   }

//   Future
//   @override
//   Widget build(BuildContext context) {
//     return const Placeholder();
//   }
// }