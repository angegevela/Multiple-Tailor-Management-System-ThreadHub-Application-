import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:threadhub_system/Customer/pages/font_provider.dart';
import 'package:threadhub_system/Pages/splash_screen.dart';
import 'package:threadhub_system/Tailor/pages/menu%20item/tailor_profilesettings/tailor_fontprovider.dart';
import 'package:threadhub_system/firebase_options.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();

  FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Initialize Supabase
  await Supabase.initialize(
    url: "https://lyoarnvbiegjplqbakyg.supabase.co",
    anonKey:
        "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6Imx5b2FybnZiaWVnanBscWJha3lnIiwicm9sZSI6ImFub24iLCJpYXQiOjE3NTgyNzYxODYsImV4cCI6MjA3Mzg1MjE4Nn0.mJzp4HUoAkh_O3mc6DuTnkxkv6NQdU5pl6IYzYjJaYE",
  );

  // Inject providers + run app
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => FontProvider()),
        ChangeNotifierProvider(create: (_) => TailorFontprovider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();
    initialization();
  }

  void initialization() async {
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: AuthPage(),
      // home: TailorHomePage(),
      home: SplashScreen(),
    );
  }
}
