import 'package:flutter/material.dart';
import 'package:prj_wisatacandisi51/models/candi.dart';

class ItemCard extends StatelessWidget {
  // TODO : 1. Deklarasikan variabel yang dibutuhkan dan pasang pada konstruktar
  final Candi candi;

  const ItemCard({super.key, required this.candi});

  @override
  Widget build(BuildContext context) {
    // TODO : 6. Implementasi routing ke Detailscreen    
    return Card(
      // TODO : 2. Tetapkan parameter shope, margin, dan elevation dari Cari
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      margin: EdgeInsets.all(4),
      elevation: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // TODO : 3 Buat Image sebagai anak dari Column
          Expanded(
            // TODO : 7 Implementasi Hero Animation
            child: ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.asset(
                candi.imageAsset,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          // TODO : 4 Buat Text sebagai anak dari Column
          Padding(
            padding: const EdgeInsets.only(left: 16, top: 8),
            child: Text(
              candi.name,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          // TODO : 5 Buat Text sebagai anak dari Column
          Padding(
            padding: const EdgeInsets.only(left: 16, bottom: 8),
            child: Text(
              candi.type,
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}