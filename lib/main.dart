import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:rickmorty_app/pages/details_page.dart';
import 'package:rickmorty_app/pages/home_page.dart';
import 'package:rickmorty_app/pages/intro_page.dart';
import 'package:rickmorty_app/services/rickmorty_service.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => RickMortyService(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(useMaterial3: true),
        title: 'Rick & Morty App',
        initialRoute: "intro",
        routes: {
          "home": (_) => const HomePage(),
          "intro": (_) => const IntroPage(),
          "details": (_) => const DetailsPage(),
        },
      ),
    );
  }
}
