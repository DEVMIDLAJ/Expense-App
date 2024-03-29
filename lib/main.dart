import 'package:expence_app/View/splash_screen.dart';
import 'package:expence_app/controller/provider/auh_provider.dart';
import 'package:expence_app/controller/provider/budget_provider.dart';
import 'package:expence_app/controller/provider/profile_provider.dart';
import 'package:expence_app/controller/provider/transaction_provider.dart';
import 'package:expence_app/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AuthProvider()),
        ChangeNotifierProvider(create: (context) => TransactionProvider()),
        ChangeNotifierProvider(create: (context) => BudgetProvider()),
        ChangeNotifierProvider(create: (context) => ProfileProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.deepPurple,
          ),
          useMaterial3: true,
        ),
        home: const SplashPage(),
      ),
    );
  }
}
