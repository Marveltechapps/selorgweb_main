import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:selorgweb_main/order/provider/navigationprovider.dart';
import 'package:selorgweb_main/presentation/home/cart_increment_cubit.dart';
import 'package:selorgweb_main/presentation/home/home_desktop_screen.dart';
import 'package:selorgweb_main/presentation/home/home_main_screen.dart';

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
      child: BlocProvider(
        create: (context) => CounterCubit(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Selorg',
          theme: ThemeData(
            textTheme: GoogleFonts.poppinsTextTheme(),
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          ),
          home: HomeMainScreen(),
        ),
      ),
    );
  }
}
