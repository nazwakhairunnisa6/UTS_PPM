import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/activity_model.dart';
import '../viewmodels/activity_viewmodel.dart';

class ActivityDetailView extends StatelessWidget {
  const ActivityDetailView({super.key});

  @override
  Widget build(BuildContext context) {
    final args = ModalRoute.of(context)?.settings.arguments;
    final String? activityId = args is String
        ? args
        : (args is Map ? args['id'] as String? : null);

    return Consumer<ActivityViewModel>(
      builder: (context, vm, _) {
        Activity? activity;
        if (activityId != null) {
          for (final item in vm.activities) {
            if (item.id == activityId) {
              activity = item;
              break;
            }
          }
        }

        if (activity == null) {
          return Scaffold(
            appBar: AppBar(title: const Text('Detail Amalan')),
            body: const Center(child: Text('Aktivitas tidak ditemukan')),
          );
        }

        final current = activity;

        return Scaffold(
          appBar: AppBar(title: const Text('Detail Amalan')),
          body: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Card(
                  shape: RoundedRectangleBorder(
                    side: const BorderSide(
                      color: Color(0xFFF8BBD0),
                      width: 1.5,
                    ),
                    borderRadius: BorderRadius.circular(24),
                  ),
                  elevation: 3,
                  child: Padding(
                    padding: const EdgeInsets.all(24),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // Badge Kategori
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFE8F5E9),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: const Text(
                            'Progress Amalan Ramadhan',
                            style: TextStyle(
                              color: Color(0xFF2E7D32),
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),

                        // Nama Aktivitas
                        Text(
                          current.name,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 24),

                        // Lingkaran Angka Counter
                        Container(
                          width: 150,
                          height: 150,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [Color(0xFFE8F5E9), Color(0xFFFCE4EC)],
                            ),
                            border: Border.all(
                              color: const Color(0xFFEC407A),
                              width: 3,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '${current.count}',
                            style: const TextStyle(
                              fontSize: 56,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF2E7D32),
                            ),
                          ),
                        ),
                        const SizedBox(height: 28),

                        // Tombol Kurang (-) dan Tambah (+)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton.icon(
                              onPressed: current.count > 0
                                  ? () {
                                      vm.decrement(current.id);
                                      ScaffoldMessenger.of(context)
                                          .hideCurrentSnackBar();
                                      ScaffoldMessenger.of(
                                        context,
                                      ).showSnackBar(
                                        const SnackBar(
                                          content: Text(
                                            'Nilai counter berhasil dikurangi',
                                          ),
                                          duration: Duration(seconds: 1),
                                        ),
                                      );
                                    }
                                  : null,
                              icon: const Icon(Icons.remove_rounded),
                              label: const Text('Kurang'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFFEC407A),
                                foregroundColor: Colors.white,
                                disabledBackgroundColor: Colors.grey.shade300,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                            const SizedBox(width: 16),
                            ElevatedButton.icon(
                              onPressed: () {
                                vm.increment(current.id);
                                ScaffoldMessenger.of(context)
                                    .hideCurrentSnackBar();
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text(
                                      'Nilai counter berhasil ditambah',
                                    ),
                                    duration: Duration(seconds: 1),
                                  ),
                                );
                              },
                              icon: const Icon(Icons.add_rounded),
                              label: const Text('Tambah'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2E7D32),
                                foregroundColor: Colors.white,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 14,
                                ),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        const Divider(),
                        const SizedBox(height: 16),

                        // Tombol Reset & Hapus
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton.icon(
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (c) => AlertDialog(
                                      title: const Text('Konfirmasi Reset'),
                                      content: const Text(
                                        'Apakah Anda yakin ingin me-reset nilai counter menjadi 0?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(c, false),
                                          child: const Text('Batal'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(c, true),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFFEC407A,
                                            ),
                                            foregroundColor: Colors.white,
                                          ),
                                          child: const Text('Reset'),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (!context.mounted) return;
                                  if (confirm == true) {
                                    vm.reset(current.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Nilai counter berhasil di-reset ke 0',
                                        ),
                                      ),
                                    );
                                  }
                                },
                                icon: const Icon(Icons.refresh_rounded),
                                label: const Text('Reset'),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: const Color(0xFFC2185B),
                                  side: const BorderSide(
                                    color: Color(0xFFEC407A),
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: ElevatedButton.icon(
                                onPressed: () async {
                                  final confirm = await showDialog<bool>(
                                    context: context,
                                    builder: (c) => AlertDialog(
                                      title: const Text('Konfirmasi Hapus'),
                                      content: Text(
                                        'Yakin ingin menghapus "${current.name}" dari daftar?',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () =>
                                              Navigator.pop(c, false),
                                          child: const Text('Batal'),
                                        ),
                                        ElevatedButton(
                                          onPressed: () =>
                                              Navigator.pop(c, true),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.red,
                                            foregroundColor: Colors.white,
                                          ),
                                          child: const Text('Hapus'),
                                        ),
                                      ],
                                    ),
                                  );
                                  if (!context.mounted) return;
                                  if (confirm == true) {
                                    vm.deleteActivity(current.id);
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(
                                        content: Text(
                                          'Aktivitas berhasil dihapus',
                                        ),
                                      ),
                                    );
                                    Navigator.pop(context);
                                  }
                                },
                                icon: const Icon(Icons.delete_outline_rounded),
                                label: const Text('Hapus'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red.shade600,
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 14,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(14),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
