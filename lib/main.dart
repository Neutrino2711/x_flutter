import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:x/business_logic/blocs/cubit/auth_cubit.dart';
import 'package:x/data/repos/auth_repo.dart';
import 'package:x/presentation/screens/register_screen.dart';

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
        home: BlocProvider<AuthCubit>(
        create: (context) => AuthCubit(authRepository: AuthRepository(dio: Dio())),
        child: RegisterScreen(),
      ),
        
      ),
    );
  }
}
