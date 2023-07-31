import 'package:currencies_project/logic/settings/settings_repository.dart';
import 'package:currencies_project/pages/main_page.dart';
import 'package:currencies_project/service_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/currency/currency_repository.dart';

void main() {
  setupServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider<SettingsRepository>(
          create: (context) => SettingsRepository(),
        ),
        RepositoryProvider<CurrencyRepository>(
          create: (context) => CurrencyRepository(
            settingsRepository: RepositoryProvider.of<SettingsRepository>(context),
          ),
        ),
      ],
      child: MaterialApp(
        title: 'Currencies Project',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.cyanAccent),
          useMaterial3: false,
        ),
        home: const MainPage(),
      ),
    );
  }
}
