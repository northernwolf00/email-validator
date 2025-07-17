import 'package:email_app/blocs/email_bloc.dart';
import 'package:email_app/presentation/main_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Email Проверка',
      home: BlocProvider(
        create: (_) => EmailBloc(),
        child: MainScreen(),
      ),
    );
  }
}
