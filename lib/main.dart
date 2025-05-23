import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:selorgweb_main/order/provider/navigationprovider.dart';
import 'package:selorgweb_main/presentation/home/home_screen.dart';

void main() {
  FlutterError.onError = (FlutterErrorDetails details) {
    debugPrint('💥 Flutter error: ${details.exception}');
    debugPrint('📌 Stack trace: ${details.stack}');
  };
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => Navigationprovider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Selorg',
        theme: ThemeData(
          // scaffoldBackgroundColor: Color.fromARGB(255, 235, 233, 233),
          textTheme: GoogleFonts.poppinsTextTheme(),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: HomeScreen(),
      ),
    );
  }
}
