import 'package:ap1/config/theme/theme.dart';
import 'package:ap1/modules/home/home.module.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Application extends StatefulWidget {
  const Application({Key? key}) : super(key: key);

  @override
  State createState() {
    return ApplicationState();
  }
}

class ApplicationState extends State<Application> {
  ApplicationState();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => ThemeCubit(),
      child: BlocBuilder<ThemeCubit, ThemeData>(
        builder: _build,
      ),
    );
  }

  Widget _build(BuildContext context, ThemeData state) {
    return MaterialApp(
      theme: state,
      title: 'Application',
      debugShowCheckedModeBanner: false,
      home: const HomeScreen(),
    );
  }
}
