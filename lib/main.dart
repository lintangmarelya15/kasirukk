import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: "https://wtaiczusnnhezgbjdcwz.supabase.co", 
    anonKey: "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Ind0YWljenVzbm5oZXpnYmpkY3d6Iiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYzMDc0MzAsImV4cCI6MjA1MTg4MzQzMH0.4dRiQ5p4ATrf5w_xRkBpRmaRDdt_J6LqMXlyPu4CiNo");
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp ({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Aplikasi Kasir"
      home: BookListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}