import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:order_me/firebase_options.dart';
import 'package:order_me/src/core/injections/injections.dart';
import 'package:order_me/src/core/utils/utils.dart';
import 'package:order_me/src/features/presentation/bloc/bloc.dart';
import 'package:order_me/src/features/presentation/pages/pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  injectorInit();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((value) => runApp(const MainApp()));
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  late UserOptionCubit userOptionCubit;

  @override
  void initState() {
    super.initState();
    userOptionCubit = blocInject<UserOptionCubit>()..appRefreshed();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProviderPage(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Order Me',
        home: BlocBuilder<UserOptionCubit, UserOptionState>(
          builder: (context, state) {
            if (state is UserOptionIsUser) {
              return const UserAppPage();
            }

            if (state is UserOptionIsAdmin) {
              return const AdminAppPage();
            }

            if (state is UserOptionInitial) {
              return const WelcomePage();
            }

            return const Scaffold(
              backgroundColor: AppColor.primaryColor,
              body: Padding(
                padding: EdgeInsets.all(10.0),
                child: Center(
                  child: CircularProgressIndicator(
                    color: AppColor.secondaryColor,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
