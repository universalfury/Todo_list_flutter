import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:cubit_flutter/Cubit/todo_cubit.dart';
import 'package:cubit_flutter/todoItem_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => TodoCubit(),
      child: MaterialApp(
        home: TodoItemList(),
      ),
    );
  }
}
    // return MaterialApp(
    //   title: 'Cubit Demo',
    //   theme: ThemeData(
    //     primarySwatch: Colors.blue,
    //   ),
    //   home: const MyHomePage(title: 'Cubit Home'),
    // );
//   }
// }
