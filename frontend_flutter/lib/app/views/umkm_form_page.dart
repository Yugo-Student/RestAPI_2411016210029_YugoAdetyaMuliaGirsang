import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/umkm_controller.dart';
import '../models/umkm_model.dart';

class UmkmFormPage extends StatelessWidget {
  final Umkm? umkm;
  final UmkmController controller = Get.find<UmkmController>();

  final TextEditingController namaC = TextEditingController();
  final TextEditingController pemilikC = TextEditingController();
  final TextEditingController alamatC = TextEditingController();
  final TextEditingController kategoriC = TextEditingController();
  final TextEditingController kontakC = TextEditingController();

  UmkmFormPage({super.key, this.umkm}) {
    if (umkm != null) {
      namaC.text = umkm!.namaUmkm;
      pemilikC.text = umkm!.pemilik ?? '';
      alamatC.text = umkm!.alamat ?? '';
      kategoriC.text = umkm!.kategori ?? '';
      kontakC.text = umkm!.kontak ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isEdit = umkm != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEdit ? 'Edit UMKM' : 'Tambah UMKM')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: namaC,
              decoration: const InputDecoration(
                labelText: 'Nama UMKM *',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: pemilikC,
              decoration: const InputDecoration(
                labelText: 'Pemilik',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: alamatC,
              decoration: const InputDecoration(
                labelText: 'Alamat',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: kategoriC,
              decoration: const InputDecoration(
                labelText: 'Kategori (Kuliner, Fashion, Jasa, dll)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 12),
            TextField(
              controller: kontakC,
              keyboardType: TextInputType.phone,
              decoration: const InputDecoration(
                labelText: 'Kontak',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),
            Obx(() {
              if (controller.isLoading.value) {
                return const CircularProgressIndicator();
              }
              return SizedBox(
                width: double.infinity,
                height: 48,
                child: ElevatedButton(
                  onPressed: () {
                    if (isEdit && umkm!.id != null) {
                      controller.updateUmkm(
                        id: umkm!.id!,
                        nama: namaC.text,
                        pemilik: pemilikC.text,
                        alamat: alamatC.text,
                        kategori: kategoriC.text,
                        kontak: kontakC.text,
                      );
                    } else {
                      controller.createUmkm(
                        nama: namaC.text,
                        pemilik: pemilikC.text,
                        alamat: alamatC.text,
                        kategori: kategoriC.text,
                        kontak: kontakC.text,
                      );
                    }
                  },
                  child: Text(isEdit ? 'Update Data' : 'Simpan Data'),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
