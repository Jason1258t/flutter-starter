import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:starter/app.dart';
import 'package:starter/feature/auth/ui/login_screen.dart';
import 'package:starter/feature/auth/ui/register_screen.dart';
import 'package:starter/services/custom_bloc_observer.dart';

import 'feature/home/ui/home_screen.dart';
import 'feature/map/ui/map_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  Bloc.observer = CustomBlocObserver();

  await dotenv.load();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        fontFamily: 'Nunito',
      ),
      routes: {
        '/': (context) => const MyRepositoryProvider(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/map': (context) => const MapScreen(),
        '/main': (context) => const HomeScreen()
      },
      // home: const MyRepositoryProvider(),
      debugShowCheckedModeBanner: false,
    );
  }
}
