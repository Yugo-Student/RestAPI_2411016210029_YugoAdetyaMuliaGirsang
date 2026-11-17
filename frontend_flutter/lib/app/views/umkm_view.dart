import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../controllers/umkm_controller.dart';
import 'umkm_form_page.dart';

class UmkmView extends StatelessWidget {
  const UmkmView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(UmkmController());

    return Scaffold(
      appBar: AppBar(title: const Text("Daftar UMKM"), centerTitle: true),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.umkmList.isEmpty) {
          return const Center(child: Text("Belum ada data UMKM"));
        }
        return RefreshIndicator(
          onRefresh: controller.fetchUmkm,
          child: ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: controller.umkmList.length,
            itemBuilder: (context, index) {
              final item = controller.umkmList[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 10),
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text(item.id?.toString() ?? "?"),
                  ),
                  title: Text(
                    item.namaUmkm,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "${item.kategori ?? 'Umum'} • ${item.pemilik ?? '-'}\n${item.alamat ?? '-'}",
                  ),
                  isThreeLine: true,
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.blue),
                        onPressed: () {
                          Get.to(() => UmkmFormPage(umkm: item));
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          if (item.id != null) {
                            Get.defaultDialog(
                              title: "Hapus UMKM",
                              middleText:
                                  "Yakin ingin menghapus ${item.namaUmkm}?",
                              textConfirm: "Hapus",
                              textCancel: "Batal",
                              confirmTextColor: Colors.white,
                              onConfirm: () {
                                Get.back();
                                controller.deleteUmkm(item.id!);
                              },
                            );
                          }
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.to(() => UmkmFormPage()),
        child: const Icon(Icons.add),
      ),
    );
  }
}
