import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:mobileapp/app/modules/storage_demo/controllers/storage_demo_controller.dart';

class StorageDemoView extends GetView<StorageDemoController> {
  const StorageDemoView({super.key});

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        backgroundColor:
            controller.isDark.value ? Colors.grey[900] : Colors.white,
        appBar: AppBar(
          title: const Text('Demo Penyimpanan Lokal & Cloud'),
          backgroundColor:
              controller.isDark.value ? Colors.grey[850] : Colors.indigo,
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ------------ shared_preferences ------------
              Text(
                '1. shared_preferences (Tema)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Text('Mode Gelap'),
                  const SizedBox(width: 8),
                  Switch(
                    value: controller.isDark.value,
                    onChanged: controller.toggleTheme,
                  ),
                ],
              ),
              const Divider(height: 32),

              // ------------ Hive ------------
              Text(
                '2. Hive (Catatan Lokal)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.localTitleC,
                decoration: const InputDecoration(
                  labelText: 'Judul catatan lokal',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.localContentC,
                decoration: const InputDecoration(
                  labelText: 'Isi catatan lokal',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 8),
             Row(
  children: [
    ElevatedButton(
      onPressed: controller.addLocalNote,
      child: const Text('Simpan ke Hive'),
    ),
    const SizedBox(width: 8),
    OutlinedButton(
      onPressed: controller.clearLocalNotes,
      child: const Text('Hapus semua'),
    ),
  ],
),

              const SizedBox(height: 8),
              Column(
                children: controller.localNotes
                    .map(
                      (n) => Card(
                        child: ListTile(
                          title: Text(n.title),
                          subtitle: Text(n.content),
                        ),
                      ),
                    )
                    .toList(),
              ),
              const Divider(height: 32),

              // ------------ Supabase ------------
              Text(
                '3. Supabase (Catatan Cloud)',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.cloudTitleC,
                decoration: const InputDecoration(
                  labelText: 'Judul catatan cloud',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 8),
              TextField(
                controller: controller.cloudContentC,
                decoration: const InputDecoration(
                  labelText: 'Isi catatan cloud',
                  border: OutlineInputBorder(),
                ),
                maxLines: 2,
              ),
              const SizedBox(height: 8),
             Row(
  children: [
    ElevatedButton(
      onPressed: controller.addCloudNote,
      child: const Text('Simpan ke Supabase'),
    ),
    const SizedBox(width: 8),
    OutlinedButton(
      onPressed: controller.isLoadingCloud.value
          ? null
          : () => controller.reloadCloudNotes(),
      child: const Text('Muat ulang'),
    ),
  ],
),
              const SizedBox(height: 8),
              controller.isLoadingCloud.value
                  ? const Center(child: CircularProgressIndicator())
                  : Column(
                      children: controller.cloudNotes
                          .map(
                            (n) => Card(
                              color: Colors.indigo.shade50,
                              child: ListTile(
                                title: Text(n.title),
                                subtitle: Text(n.content),
                                trailing: const Icon(Icons.cloud_done),
                              ),
                            ),
                          )
                          .toList(),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
