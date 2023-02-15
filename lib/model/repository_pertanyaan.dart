import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sampah_market/constant.dart';
import 'pertanyaan_model.dart';

class Service {
  Future<List<Pertanyaan>> getAllBarang() async {
    final response = await http.get(Uri.parse(
        "$url/pertanyaan/"));
        if (response.statusCode == 200){
          List jsonResponse = jsonDecode(response.body);
          return jsonResponse.map((data) => Pertanyaan.fromJson(data)).toList();
        }else{
          throw Exception('failed to load data');
        }
  }
}
