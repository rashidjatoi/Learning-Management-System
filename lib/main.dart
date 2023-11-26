import 'package:agriconnect/provider/home_provider.dart';
import 'package:agriconnect/provider/theme_change_provider.dart';
import 'package:agriconnect/firebase_options.dart';
import 'package:agriconnect/views/splash_view/splash_view.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeChangeProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
      ],
      builder: (context, child) {
        final themeChnager = Provider.of<ThemeChangeProvider>(context);

        return GetMaterialApp(
          title: 'AgriConnect',
          debugShowCheckedModeBanner: false,
          themeMode: themeChnager.themeMode,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color(0xff30384D),
            ),
            appBarTheme: const AppBarTheme(
              elevation: 0.8,
              centerTitle: true,
              titleTextStyle: TextStyle(
                color: Color(0xff30384D),
                fontSize: 20,
                fontFamily: "DMSans Bold",
              ),
            ),
            useMaterial3: true,
            textTheme: const TextTheme().apply(
              displayColor: const Color(0xff30384D),
            ),
          ),
          darkTheme: ThemeData(
            brightness: Brightness.dark,
            useMaterial3: true,
            scaffoldBackgroundColor: const Color(0xff30384C),
            appBarTheme: const AppBarTheme(
              elevation: 0,
              centerTitle: true,
              backgroundColor: Color(0xff2C3448),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontFamily: "DMSans Bold",
              ),
            ),
          ),
          home: const SplashView(),
        );
      },
    );
  }
}
