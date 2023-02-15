// import 'dart:convert';

// import 'package:http/http.dart' as http;

class Barang {
  int id;
  String nama;
  String harga;
  String foto;

  Barang(
      {required this.id,
      required this.nama,
      required this.harga,
      required this.foto});

  factory Barang.fromJson(Map<String, dynamic> json) {
    return Barang(
        id: json['id'],
        nama: json['nama'],
        harga: json['harga'],
        foto: json['foto']);
  }

  // factory Barang.createBarang(Map<String, dynamic> json)
  // {
  //   return Barang(
  //     id: json['id'],
  //     nama: json['nama'],
  //     harga: json['harga'],
  //     foto: json['foto']
  //   );
}

  // static fromJson(e) {}
  

