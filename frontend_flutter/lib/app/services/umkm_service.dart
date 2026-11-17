import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/umkm_model.dart';

class UmkmService {
  final String baseUrl = "http://localhost:8080/api/";

  // 1. GET ALL UMKM
  Future<List<Umkm>> getUmkmList() async {
    final response = await http.get(Uri.parse('${baseUrl}umkm'));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final List<dynamic> data = jsonResponse['data'];
      return data.map((e) => Umkm.fromJson(e)).toList();
    } else {
      throw Exception("Gagal mengambil data UMKM");
    }
  }

  // 2. POST CREATE UMKM
  Future<dynamic> createUmkm(Map<String, String> data) async {
    final response = await http.post(
      Uri.parse('${baseUrl}umkm'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
      body: data,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      final errorBody = jsonDecode(response.body);
      throw Exception(errorBody['message'] ?? 'Gagal menambah data');
    }
  }

  // 3. PUT UPDATE UMKM
  Future<dynamic> updateUmkm(int id, Map<String, String> data) async {
    final response = await http.put(
      Uri.parse('${baseUrl}umkm/$id'),
      headers: {
        'Content-Type': 'application/x-www-form-urlencoded',
        'Accept': 'application/json',
      },
      body: data,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal memperbarui data UMKM');
    }
  }

  // 4. DELETE UMKM
  Future<dynamic> deleteUmkm(int id) async {
    final response = await http.delete(
      Uri.parse('${baseUrl}umkm/$id'),
      headers: {'Accept': 'application/json'},
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Gagal menghapus data UMKM');
    }
  }
}
