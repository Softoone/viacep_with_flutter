import 'dart:async';
import 'package:crud_viacep/components/utils.dart';
import 'package:crud_viacep/database/dao/person_dao.dart';
import 'package:crud_viacep/models/person.dart';
import 'package:crud_viacep/webAPI/cep_requests.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:lottie/lottie.dart';

//TODO: CRIAR DIALOG PARA EXIBIR DADOS SALVOS

class SignUp extends StatelessWidget {
  SignUp({Key? key}) : super(key: key);

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _nameFieldController = TextEditingController();
  final TextEditingController _emailFieldController = TextEditingController();
  final TextEditingController _nicknameFieldController = TextEditingController();
  final TextEditingController _zipCodeFieldController = TextEditingController();

  final _lograd = ValueNotifier<TextEditingController>(TextEditingController());
  final _district = ValueNotifier<TextEditingController>(TextEditingController());
  final _city = ValueNotifier<TextEditingController>(TextEditingController());
  final _uf = ValueNotifier<TextEditingController>(TextEditingController());
  final _btnStatus = ValueNotifier<int>(0);

  final _webClient = CEPWebClient();

  static const Color primaryColor = Colors.black87;
  static const Color inputTextColor = Colors.white;
  static const Color hintTextColor = Colors.white70;
  static const Color disabledTextColor = Colors.white24;

  @override
  Widget build(BuildContext context) {
    final maxHeight = Utils().maxHeight(context);
    final maxWidth = Utils().maxWidth(context);

    return AnnotatedRegion(
      value: const SystemUiOverlayStyle(
        statusBarColor: primaryColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarColor: primaryColor,
      ),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: maxWidth,
            height: maxHeight,
            color: primaryColor,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  SizedBox(
                      height: maxHeight / 5,
                      child: Lottie.asset(
                        'assets/location_signup_view.json',
                      )),
                  const Padding(
                    padding: EdgeInsets.only(left: 20),
                    child: SizedBox(
                      child: Text(
                        'REGISTER',
                        style: TextStyle(
                          fontSize: 30,
                          color: inputTextColor,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 2.5,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            validator: (value) => validateFields(value),
                            controller: _nameFieldController,
                            decoration: const InputDecoration(
                              hintText: 'Nome',
                              hintStyle: TextStyle(color: hintTextColor),
                            ),
                            style: const TextStyle(color: inputTextColor),
                          ),
                          TextFormField(
                            validator: (value) => validateFields(value),
                            controller: _emailFieldController,
                            decoration: const InputDecoration(
                              hintText: 'Email',
                              hintStyle: TextStyle(color: hintTextColor),
                            ),
                            style: const TextStyle(color: inputTextColor),
                          ),
                          TextFormField(
                            validator: (value) => validateFields(value),
                            controller: _nicknameFieldController,
                            decoration: const InputDecoration(
                              hintText: 'Apelido',
                              hintStyle: TextStyle(color: hintTextColor),
                            ),
                            style: const TextStyle(color: inputTextColor),
                          ),
                          TextFormField(
                            validator: (value) => validateCEP(value),
                            controller: _zipCodeFieldController,
                            keyboardType: TextInputType.number,
                            maxLength: 8,
                            onChanged: (text) => (text.length == 8)
                                ? getCEP(_zipCodeFieldController.text)
                                : clearFields(context),
                            decoration: const InputDecoration(
                              counterText: '',
                              hintText: 'CEP',
                              hintStyle: TextStyle(color: hintTextColor),
                            ),
                            style: const TextStyle(color: inputTextColor),
                          ),
                          ValueListenableBuilder(
                            valueListenable: _lograd,
                            builder: (context,
                                    TextEditingController logradController,
                                    child) =>
                                TextFormField(
                              validator: (value) => validateFields(value),
                              style: const TextStyle(color: inputTextColor),
                              controller: logradController,
                              enabled: false,
                              decoration: const InputDecoration(
                                hintText: 'Rua',
                                hintStyle: TextStyle(color: disabledTextColor),
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: _district,
                            builder: (context,
                                    TextEditingController districtController,
                                    child) =>
                                TextFormField(
                              validator: (value) => validateFields(value),
                              style: const TextStyle(color: inputTextColor),
                              controller: districtController,
                              enabled: false,
                              decoration: const InputDecoration(
                                hintText: 'Bairro',
                                hintStyle: TextStyle(color: disabledTextColor),
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: _city,
                            builder: (context,
                                    TextEditingController cityController,
                                    child) =>
                                TextFormField(
                              validator: (value) => validateFields(value),
                              style: const TextStyle(color: inputTextColor),
                              controller: cityController,
                              enabled: false,
                              decoration: const InputDecoration(
                                hintText: 'Cidade',
                                hintStyle: TextStyle(color: disabledTextColor),
                              ),
                            ),
                          ),
                          ValueListenableBuilder(
                            valueListenable: _uf,
                            builder: (context,
                                    TextEditingController ufController,
                                    child) =>
                                TextFormField(
                              validator: (value) => validateFields(value),
                              style: const TextStyle(color: inputTextColor),
                              controller: ufController,
                              enabled: false,
                              decoration: const InputDecoration(
                                hintText: 'UF',
                                hintStyle: TextStyle(color: disabledTextColor),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          OutlinedButton(
                            style: OutlinedButton.styleFrom(
                              primary: inputTextColor,
                              backgroundColor: primaryColor,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5),
                              ),
                              minimumSize: const Size(200, 60),
                            ),
                            onPressed: () {
                              FocusScope.of(context).unfocus();
                              if (_formKey.currentState!.validate()) {
                                //  save in database
                                _btnStatus.value = 1;
                                Timer(const Duration(milliseconds: 1500), () {
                                  saveRegisterData(
                                    Person(
                                      name: _nameFieldController.text,
                                      email: _emailFieldController.text,
                                      nickname: _nicknameFieldController.text,
                                      logradouro: _lograd.value.text,
                                      bairro: _district.value.text,
                                      localidade: _city.value.text,
                                      uf: _uf.value.text,
                                    ),
                                  );
                                  _btnStatus.value = 2;
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      duration: Duration(milliseconds: 1800),
                                      content: Text(
                                          'Your register is completed...wait for redirect'),
                                    ),
                                  );
                                  Timer(const Duration(milliseconds: 2000), () {
                                    Navigator.popAndPushNamed(context, '/');
                                  });
                                });
                              }

                            },
                            child: ValueListenableBuilder(
                              valueListenable: _btnStatus,
                              builder: (context, int status, child) {
                                switch(status) {
                                  case 1:
                                    return const CircularProgressIndicator();
                                  case 2:
                                    return const Icon(Icons.check,color: Colors.green,);
                                  default:
                                    return const Text('CREATE ACCOUNT');
                                }
                              }
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  void saveRegisterData(Person person) {
    PersonDao().save(person);
  }

  void getCEP(String cep) async {
    try {
      Person newAddress = await _webClient.getAddress(cep);
      completeFields(newAddress);
    } on HttpException catch (e) {
      showToast(e.message);
    }
  }

  validateCEP(value) {
    if (value.toString().length < 8) {
      return 'Incomplete Field';
    }
  }

  validateFields(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  void completeFields(Person address) {
    _lograd.value.text = address.logradouro!;
    _uf.value.text = address.uf!;
    _city.value.text = address.localidade!;
    _district.value.text = address.bairro!;
  }

  void clearFields(context) {
    _lograd.value.text = '';
    _uf.value.text = '';
    _city.value.text = '';
    _district.value.text = '';
  }

  void showToast(message) {
    Fluttertoast.showToast(msg: message, backgroundColor: Colors.red);
    Timer(const Duration(milliseconds: 700), () => Fluttertoast.cancel());
  }

  // void showDataSaved() {}
}
