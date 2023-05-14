import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_food_ordering_app/firebase_options.dart';
import 'package:flutter_food_ordering_app/src/injections/injections.dart';
import 'package:flutter_food_ordering_app/src/pages/bloc_provider_page.dart';
import 'package:flutter_food_ordering_app/src/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  injectorInit();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const BlocProviderPage(
      child: MaterialApp(
        title: 'Order Me',
        home: Scaffold(
          body: WelcomePage(),
        ),
      ),
    );
  }
}
