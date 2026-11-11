import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../data/destinasi_data.dart';
import '../models/destinasi.dart';

class DetailDestinasiScreen extends StatelessWidget {
  final String id;

  const DetailDestinasiScreen({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    final Destinasi? destinasi = daftarDestinasiData
        .cast<Destinasi?>()
        .firstWhere((item) => item?.id == id, orElse: () => null);

    if (destinasi == null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Destinasi Tidak Ditemukan')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.search_off, size: 64, color: Colors.grey),
              const SizedBox(height: 16),
              Text('Destinasi dengan ID "$id" tidak ditemukan.'),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () => context.go('/'),
                child: const Text('Kembali ke Beranda'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(destinasi.nama),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (Navigator.of(context).canPop()) {
              context.pop();
            } else {
              context.go('/');
            }
          },
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 800;

          Widget headerGambar = Stack(
            children: [
              Container(
                height: isWide ? double.infinity : 300,
                width: double.infinity,
                decoration: const BoxDecoration(color: Colors.black12),
                child: Image.network(
                  destinasi.imageUrl,
                  fit: BoxFit.cover,
                  errorBuilder: (ctx, err, stack) =>
                      const Icon(Icons.landscape, size: 64),
                ),
              ),
              Positioned(
                bottom: 16,
                left: 16,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.7),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.star, color: Colors.amber, size: 18),
                      const SizedBox(width: 6),
                      Text(
                        '${destinasi.rating} / 5.0',
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );

          Widget kontenInfo = SingleChildScrollView(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  destinasi.nama,
                  style: Theme.of(context).textTheme.headlineMedium
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, color: Colors.redAccent),
                    const SizedBox(width: 4),
                    Text(
                      destinasi.lokasi,
                      style: Theme.of(context).textTheme.titleMedium
                          ?.copyWith(color: Colors.grey.shade700),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.access_time, color: Colors.blueAccent),
                    const SizedBox(width: 4),
                    Text(
                      'Jam Buka: ${destinasi.jamBuka}',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
                const Divider(height: 32),
                Text(
                  'Tentang Destinasi',
                  style: Theme.of(context).textTheme.titleLarge
                      ?.copyWith(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Text(
                  destinasi.deskripsi,
                  style: const TextStyle(fontSize: 16, height: 1.5),
                ),
              ],
            ),
          );

          if (isWide) {
            return Row(
              children: [
                Expanded(flex: 5, child: headerGambar),
                Expanded(flex: 7, child: kontenInfo),
              ],
            );
          }

          return ListView(
            children: [
              SizedBox(height: 300, child: headerGambar),
              kontenInfo,
            ],
          );
        },
      ),
    );
  }
}
