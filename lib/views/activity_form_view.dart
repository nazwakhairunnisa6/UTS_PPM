import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../viewmodels/activity_viewmodel.dart';

class ActivityFormView extends StatefulWidget {
  const ActivityFormView({super.key});

  @override
  State<ActivityFormView> createState() => _ActivityFormViewState();
}

class _ActivityFormViewState extends State<ActivityFormView> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _countController = TextEditingController(text: '0');
  String? _editingId;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;
    if (args != null && args['id'] != null) {
      _editingId = args['id'] as String;
      final vm = Provider.of<ActivityViewModel>(context, listen: false);
      final activity = vm.activities.firstWhere((a) => a.id == _editingId);
      _nameController.text = activity.name;
      _countController.text = activity.count.toString();
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _countController.dispose();
    super.dispose();
  }

  void _save() {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    final name = _nameController.text.trim();
    final count = int.parse(_countController.text);
    final vm = Provider.of<ActivityViewModel>(context, listen: false);
    if (_editingId == null) {
      vm.addActivity(name, count);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Aktivitas ditambahkan')));
    } else {
      vm.updateActivity(_editingId!, name, count);
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text('Aktivitas diubah')));
    }
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isEdit = _editingId != null;
    return Scaffold(
      appBar: AppBar(
        title: Text(isEdit ? 'Edit Aktivitas' : 'Tambah Aktivitas'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Nama Aktivitas',
                  border: OutlineInputBorder(),
                ),
                validator: (v) =>
                    (v == null || v.isEmpty) ? 'Tidak boleh kosong' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _countController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Nilai Counter Awal',
                  border: OutlineInputBorder(),
                ),
                validator: (v) {
                  if (v == null || v.isEmpty) return 'Tidak boleh kosong';
                  final n = int.tryParse(v);
                  if (n == null || n < 0) return 'Masukkan angka non‑negatif';
                  return null;
                },
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF2E7D32),
                  foregroundColor: Colors.white,
                ),
                child: Text(isEdit ? 'Simpan Perubahan' : 'Simpan'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
