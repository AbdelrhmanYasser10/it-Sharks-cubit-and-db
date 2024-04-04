import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:untitled6/cubits/app_cubit/app_cubit.dart';
import 'package:untitled6/database/db_helper.dart';
import 'package:untitled6/screens/home_screen.dart';

void main() async{

  WidgetsFlutterBinding.ensureInitialized();

  await DatabaseHelper.initializeDatabase();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AppCubit()..getAllData(),
      child: MaterialApp(
        title: 'Material App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          useMaterial3: false, // Android 12
        ),
        // display increment counter screen
        home: const HomeScreen(),
      ),
    );
  }
}
