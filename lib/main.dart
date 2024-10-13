import 'package:flutter/material.dart';
import 'package:flutter/services.dart'; // Required to set orientation
import 'package:testing/Home_Page.dart'; // Import the HomePage widget

void main() async {
  // Ensure the widget binding is initialized
  WidgetsFlutterBinding.ensureInitialized();

  // Lock the orientation to landscape left
  await SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);

  // Start the app
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), // Make sure you have HomePage implemented correctly
    );
  }
}
