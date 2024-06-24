import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:x/business_logic/blocs/cubit/auth_cubit.dart';
import 'package:x/data/repos/auth_repo.dart';
import 'package:x/presentation/screens/register_screen.dart';
import 'package:x/presentation/screens/single_post_screen.dart';
import 'package:x/presentation/screens/wrapper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  HydratedBloc.storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),

  );

  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<AuthCubit>(
      create: (context) => AuthCubit(authRepository: AuthRepository(dio: Dio())),
      child: MaterialApp(
              theme: ThemeData(
  brightness: Brightness.dark,
  primaryColor: Color(0xFF1DA1F2), // Twitter's blue
  scaffoldBackgroundColor: Color(0xFF15202B), // Dark blue background
  appBarTheme: AppBarTheme(
    backgroundColor: Color(0xFF15202B), // Dark blue
    titleTextStyle: TextStyle(color: Colors.white, fontSize: 20),
    iconTheme: IconThemeData(color: Colors.white),
  ),
  colorScheme: ColorScheme.dark().copyWith(
    primary: Color(0xFF1DA1F2), // Twitter's blue
    secondary: Color(0xFF1DA1F2), // Twitter's blue for secondary elements
    background: Color(0xFF15202B), // Dark blue background
    surface: Color(0xFF192734), // Slightly lighter blue for cards and surfaces
  ),
  textTheme: TextTheme(
    bodySmall: TextStyle(color: Colors.white),
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.white),
    headlineLarge: TextStyle(color: Colors.white),
    headlineMedium: TextStyle(color: Colors.white),
    headlineSmall: TextStyle(color: Colors.white),
    titleLarge: TextStyle(color: Colors.white),
    titleMedium: TextStyle(color: Colors.white),
    titleSmall: TextStyle(color: Colors.white),
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Color(0xFF1DA1F2), // Twitter's blue
    textTheme: ButtonTextTheme.primary,
  ),
  floatingActionButtonTheme: FloatingActionButtonThemeData(
    backgroundColor: Color(0xFF1DA1F2), // Twitter's blue
    foregroundColor: Colors.white,
  ),
  iconTheme: IconThemeData(color: Colors.white),
),
       home: Wrapper(),
        
      ),
    );
  }
}
