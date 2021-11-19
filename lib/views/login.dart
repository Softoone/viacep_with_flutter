import 'package:crud_viacep/components/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';

//TODO: Criar acesso via nickname ou email
//TODO: Executar funções de chamada no banco
class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final maxHeight = Utils().maxHeight(context);
    final maxWidth = Utils().maxWidth(context);
    const Color statusBarColor = Color(0xFF062136);
    const Color navBarColor = Color(0xFF062136);

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        statusBarColor:statusBarColor,
        systemNavigationBarColor: navBarColor,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: maxWidth,
            height: maxHeight,
            decoration: const BoxDecoration(
                gradient: LinearGradient(
                    colors: [statusBarColor, navBarColor],
                    stops: [0.75,0.25],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomLeft)),
            child: Column(
              children: [
                const TextField(),
                OutlinedButton(
                  onPressed: () {},
                  child: const Text('LOGIN'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

