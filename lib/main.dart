import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shorts_restaurant/Welcome/Splashscreen.dart';
import 'package:shorts_restaurant/firebase_options.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Shorts',
      theme: ThemeData(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        primaryColor: Colors.black,
        useMaterial3: false,
        fontFamily: 'NotoSansKR',
      ),
      builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context).copyWith(
            textScaler: TextScaler.noScaling,
          ),
          child: child!),
      home: const SplashScreen(),
    );
  }
}
