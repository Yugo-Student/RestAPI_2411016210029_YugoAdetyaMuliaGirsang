import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/umkm_model.dart';
import '../services/umkm_service.dart';

class UmkmController extends GetxController {
  var umkmList = <Umkm>[].obs;
  var isLoading = true.obs;
  final UmkmService _service = UmkmService();

  @override
  void onInit() {
    fetchUmkm();
    super.onInit();
  }

  Future<void> fetchUmkm() async {
    try {
      isLoading(true);
      var result = await _service.getUmkmList();
      umkmList.assignAll(result);
    } catch (e) {
      Get.snackbar(
        "Error",
        "Gagal memuat data: $e",
        backgroundColor: Colors.red.shade100,
      );
    } finally {
      isLoading(false);
    }
  }

  Future<void> createUmkm({
    required String nama,
    String? kategori,
    String? pemilik,
    String? alamat,
    String? kontak,
  }) async {
    isLoading(true);
    try {
      final result = await _service.createUmkm({
        'nama_umkm': nama,
        'kategori': kategori ?? '',
        'pemilik': pemilik ?? '',
        'alamat': alamat ?? '',
        'kontak': kontak ?? '',
      });
      await fetchUmkm();
      Get.back();
      Get.snackbar(
        "Sukses",
        result['message'] ?? 'Data berhasil disimpan',
        backgroundColor: Colors.green.shade100,
      );
    } catch (e) {
      Get.snackbar("Error", "$e", backgroundColor: Colors.red.shade100);
    } finally {
      isLoading(false);
    }
  }

  Future<void> updateUmkm({
    required int id,
    required String nama,
    String? kategori,
    String? pemilik,
    String? alamat,
    String? kontak,
  }) async {
    isLoading(true);
    try {
      final result = await _service.updateUmkm(id, {
        'nama_umkm': nama,
        'kategori': kategori ?? '',
        'pemilik': pemilik ?? '',
        'alamat': alamat ?? '',
        'kontak': kontak ?? '',
      });
      await fetchUmkm();
      Get.back();
      Get.snackbar(
        "Sukses",
        result['message'] ?? 'Data berhasil diperbarui',
        backgroundColor: Colors.green.shade100,
      );
    } catch (e) {
      Get.snackbar("Error", "$e", backgroundColor: Colors.red.shade100);
    } finally {
      isLoading(false);
    }
  }

  Future<void> deleteUmkm(int id) async {
    try {
      final result = await _service.deleteUmkm(id);
      await fetchUmkm();
      Get.snackbar(
        "Sukses",
        result['message'] ?? 'Data berhasil dihapus',
        backgroundColor: Colors.green.shade100,
      );
    } catch (e) {
      Get.snackbar("Error", "$e", backgroundColor: Colors.red.shade100);
    }
  }
}
