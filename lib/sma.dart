import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Top Loading Bar Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isLoading = false;

  void startLoading() async {
    setState(() => isLoading = true);

    // Simulate a network delay
    await Future.delayed(const Duration(seconds: 3));

    setState(() => isLoading = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Main Content
          Center(
            child: ElevatedButton(
              onPressed: startLoading,
              child: const Text('Load Something'),
            ),
          ),

          // Top Loading Bar
          if (isLoading)
            const Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: LinearProgressIndicator(
                minHeight: 4,
                backgroundColor: Colors.transparent,
                color: Colors.deepPurple,
              ),
            ),
        ],
      ),
    );
  }
}