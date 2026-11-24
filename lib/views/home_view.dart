import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/activity_viewmodel.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('RamadhanLog — Amalan Ramadhan')),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: Consumer<ActivityViewModel>(
            builder: (context, vm, _) {
              final activities = vm.activities;
              final totalActivities = activities.length;
              final totalCount = activities.fold<int>(
                0,
                (sum, a) => sum + a.count,
              );

              if (activities.isEmpty) {
                return const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.nightlight_round,
                      size: 80,
                      color: Color(0xFF2E7D32),
                    ),
                    SizedBox(height: 16),
                    Text(
                      'Tidak ada aktivitas. Tambahkan sekarang!',
                      style: TextStyle(fontSize: 18),
                    ),
                  ],
                );
              }

              return Column(
                children: [
                  // Header Banner
                  Container(
                    width: double.infinity,
                    margin: const EdgeInsets.symmetric(
                      vertical: 12,
                      horizontal: 12,
                    ),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF2E7D32), Color(0xFFD81B60)],
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.nights_stay_rounded,
                          size: 40,
                          color: Colors.white,
                        ),
                        SizedBox(height: 8),
                        Text(
                          'Target Amalan Ramadhan',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),

                  // Ringkasan Total
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    child: Text(
                      'Total Aktivitas: $totalActivities | Total Hitungan: $totalCount',
                      style: const TextStyle(
                        color: Colors.black54,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Daftar Kartu Amalan
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.only(bottom: 84),
                      itemCount: activities.length,
                      separatorBuilder: (_, _) => const SizedBox(height: 12),
                      itemBuilder: (context, index) {
                        final act = activities[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(horizontal: 12),
                          clipBehavior: Clip.antiAlias,
                          shape: RoundedRectangleBorder(
                            side: const BorderSide(color: Color(0xFFF8BBD0)),
                            borderRadius: BorderRadius.circular(16),
                          ),
                          elevation: 2,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(16),
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                '/detail',
                                arguments: act.id,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: Row(
                                children: [
                                  // Ikon Amalan
                                  Container(
                                    width: 48,
                                    height: 48,
                                    decoration: const BoxDecoration(
                                      color: Color(0xFFE8F5E9),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.mosque_rounded,
                                      color: Color(0xFF2E7D32),
                                    ),
                                  ),
                                  const SizedBox(width: 12),

                                  // Nama & Subteks
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          act.name,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        const Text(
                                          'Ketuk untuk hitung amalan',
                                          style: TextStyle(
                                            color: Colors.grey,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),

                                  // Badge Counter
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: const Color(0xFFFCE4EC),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      '${act.count}',
                                      style: const TextStyle(
                                        color: Color(0xFFC2185B),
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 4),

                                  // Tombol Edit Nama
                                  IconButton(
                                    tooltip: 'Edit Amalan',
                                    icon: const Icon(Icons.edit_rounded),
                                    color: const Color(0xFF2E7D32),
                                    onPressed: () {
                                      Navigator.pushNamed(
                                        context,
                                        '/add',
                                        arguments: {'id': act.id},
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.pushNamed(context, '/add');
        },
        icon: const Icon(Icons.add_rounded),
        label: const Text(
          'Tambah Amalan',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFFEC407A),
        foregroundColor: Colors.white,
      ),
    );
  }
}
