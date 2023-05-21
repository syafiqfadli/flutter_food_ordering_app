import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_food_ordering_app/firebase_options.dart';
import 'package:flutter_food_ordering_app/src/core/injections/injections.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/bloc/bloc.dart';
import 'package:flutter_food_ordering_app/src/features/presentation/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  injectorInit();
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    final userStatus = FirebaseAuth.instance.currentUser;

    return BlocProviderPage(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Order Me',
        home: userStatus != null
            ? BlocBuilder<UserOptionCubit, UserOptionState>(
                builder: (context, state) {
                  if (state is UserOptionIsUser) {
                    return const UserAppPage();
                  }

                  if (state is UserOptionIsAdmin) {
                    return const AdminAppPage();
                  }

                  return const WelcomePage();
                },
              )
            : const WelcomePage(),
      ),
    );
  }
}
