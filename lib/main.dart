import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'viewmodels/activity_viewmodel.dart';
import 'views/home_view.dart';
import 'views/activity_form_view.dart';
import 'views/activity_detail_view.dart';

void main() {
  runApp(const RamadhanLogApp());
}

class RamadhanLogApp extends StatelessWidget {
  const RamadhanLogApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ActivityViewModel(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'RamadhanLog — Amalan Ramadhan',
        theme: ThemeData(
          colorScheme: const ColorScheme.light(
            primary: Color(0xFF2E7D32), // emerald green
            primaryContainer: Color(0xFFE8F5E9),
            secondary: Color(0xFFEC407A), // soft pink
            secondaryContainer: Color(0xFFFCE4EC),
          ),
          scaffoldBackgroundColor: const Color(0xFFFFF8FA),
          appBarTheme: const AppBarTheme(
            backgroundColor: Color(0xFF2E7D32),
            foregroundColor: Colors.white,
            elevation: 0,
          ),
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Color(0xFFEC407A),
            foregroundColor: Colors.white,
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (_) => const HomeView(),
          '/add': (_) => const ActivityFormView(),
          '/detail': (_) => const ActivityDetailView(),
        },
      ),
    );
  }
}
