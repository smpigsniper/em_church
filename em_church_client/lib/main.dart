import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:em_church_client/blocs/login/login_blocs.dart';
import 'package:em_church_client/home/home.dart';
import 'package:em_church_client/login.dart';
import 'package:em_church_client/repositories/login_response.dart';
import 'package:em_church_client/style/color.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  final LoginBlocs _loginBlocs = LoginBlocs(LoginResponse());
  final FlutterSecureStorage _secureStorage = const FlutterSecureStorage();

  Future<Widget> _getInitialPage() async {
    final String? email = await _secureStorage.read(key: 'email');
    final String? accessToken = await _secureStorage.read(key: 'accessToken');

    if (email != null && accessToken != null) {
      // Assuming that if email and accessToken are not null, the user is authenticated.
      // You might want to add additional checks here based on your authentication logic.
      return const Home();
    }
    return const Loging();
  }

  @override
  Widget build(BuildContext context) {
    CustColors custColors = CustColors();
    ThemeMode themeMode = ThemeMode.system;

    return FutureBuilder<Widget>(
      future: _getInitialPage(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Show a loading indicator while checking the authentication state
          return const MaterialApp(
            home: Scaffold(
              body: Center(child: CircularProgressIndicator()),
            ),
          );
        } else if (snapshot.hasData) {
          return MaterialApp(
            routes: {
              '/login': (context) => const Loging(),
              '/home': (context) => const Home(),
            },
            title: 'Flutter Demo',
            theme: ThemeData(
              useMaterial3: true,
              appBarTheme: AppBarTheme(
                backgroundColor: custColors.mainColor[0], // Set AppBar background color for light mode
              ),
              navigationBarTheme: NavigationBarThemeData(
                indicatorColor: custColors.mainColor[0],
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: custColors.mainColor[0],
                  foregroundColor: custColors.mainColor[0],
                ),
              ),
              iconTheme: IconThemeData(
                color: custColors.mainColor[0],
              ),
            ),
            darkTheme: ThemeData(
              useMaterial3: true,
              appBarTheme: AppBarTheme(
                backgroundColor: custColors.mainColor[2], // Set AppBar background color for dark mode
              ),
              navigationBarTheme: NavigationBarThemeData(
                indicatorColor: custColors.mainColor[2],
              ),
              elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
                  backgroundColor: custColors.mainColor[3],
                  foregroundColor: custColors.mainColor[3],
                ),
              ),
              iconTheme: IconThemeData(
                color: custColors.mainColor[3],
              ),
              brightness: Brightness.dark,
            ),
            themeMode: themeMode,
            home: BlocProvider<LoginBlocs>.value(
              value: _loginBlocs,
              child: snapshot.data!,
            ),
          );
        } else {
          return const MaterialApp(
            home: Scaffold(
              body: Center(
                child: Text('Error loading authentication state'),
              ),
            ),
          );
        }
      },
    );
  }
}
