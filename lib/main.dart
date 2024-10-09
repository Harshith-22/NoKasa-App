import 'package:flutter/material.dart';
import 'package:nokasa_app/home_page.dart';
import 'package:provider/provider.dart';
import 'package:nokasa_app/context/data_provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => DataProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'NoKasa',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromRGBO(10, 94, 13, 1)),
          useMaterial3: true,
        ),
        home: const HomePage(),
      ),
    );
  }
}
