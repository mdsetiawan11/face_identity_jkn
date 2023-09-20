import 'package:face_net_authentication/pages/auth/landingpage.dart';
import 'package:face_net_authentication/pages/layoutpage.dart';
import 'package:face_net_authentication/locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  setupServices();
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences localStorage = await SharedPreferences.getInstance();
  var id = (localStorage.getString('id') ?? '');
  runApp(MyApp(id: id));
}

class MyApp extends StatelessWidget {
  final String id;
  const MyApp({super.key, required this.id});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue.shade900),
        useMaterial3: true,
        textTheme: GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme),
      ),
      home: id == "" ? const LandingPage() : const LayoutPage(),
    );
  }
}
