import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_internship_v2/pages/all_tasks.dart';
import 'cubit/theme/theme_cubit.dart';
import 'models/theme_list.dart';


void main() {

  runApp(
    MyApp()
  );
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => ThemeCubit(ThemeList())),
      ],
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'test_app',
          home: TaskPage(),
        ),
    );
  }
}

