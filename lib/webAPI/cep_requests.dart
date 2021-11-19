import 'package:crud_viacep/models/person.dart';
import 'package:http/http.dart' as http;

class CEPWebClient {

    getAddress(String cep) async{
    Uri baseUrl = Uri.parse('http://viacep.com.br/ws/$cep/json/');
    final response = await http.get(baseUrl);
    if (response.statusCode == 200 && response.body.length > 18){
      return Person.fromJson(response.body);
    }else if (response.statusCode != 200){
      responseHandling(response.statusCode);
    }else {
      throw HttpException('CEP INVÁLIDO');
    }
  }

  void responseHandling(int statusCode) {
    switch (statusCode) {
      case 500:
        throw HttpException('Cant communicate with API...Try again later');

      default:
        throw HttpException('Unhandled error');
    }
  }
}

class HttpException implements Exception {
  final String message;

  HttpException(this.message);
}