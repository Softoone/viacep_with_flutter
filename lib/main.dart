import 'package:crud_viacep/views/sign_up.dart';
import 'package:crud_viacep/views/start.dart';
import 'package:flutter/material.dart';
import 'components/app_theme.dart';

//TODO: PESQUISAR SOBRE SPLASH SCREEN

void main() async{
  runApp(const MyApp());
  // PersonDao().save(Person(name: 'Jim',nickname: 'Softoone'));
  // final persons = await PersonDao().get();
  // print(persons[persons.length - 1].nickname);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: appTheme,
      initialRoute:  '/',
      routes: {
        '/' : (context) => const  Start(),
        '/signup' : (context) => SignUp(),
      },
    );
  }
}
