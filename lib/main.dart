import 'package:creative_status/cubit/status_cubit.dart';
import 'package:creative_status/helper/contstants/my_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => StatusCubit()..loadLoaclTextStatus(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: MyColors.primary),
            useMaterial3: true,
          ),
          home: HomePage()),
    );
  }
}
