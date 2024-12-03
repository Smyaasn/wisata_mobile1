import 'package:aslab_travel/model/makanan_model.dart';
import 'package:aslab_travel/servicec/makanan_service.dart';
import 'package:aslab_travel/widgets/makanan_card.dart';
import 'package:flutter/material.dart';

class Pertemuan9APIScreen extends StatelessWidget {
  final MakananService _makananService = MakananService();
  Pertemuan9APIScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Daftar Menu Seafood',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: FutureBuilder<List<MakananModel>>(
        future: _makananService.fetchMakanan(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text("Error : ${snapshot.error}"),
            );
          }else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text("Tidak ada makanan yang tersedia"),);
          } else {
            final makanan = snapshot.data!;
            return ListView.builder(itemBuilder: (context, index) {
              return MakananCard(makananModel: makanan[index]);
            },
             itemCount: makanan.length,);
          }
        },
      ),
    );
  }
}