import 'dart:convert' as convert;
import 'package:http/http.dart' as http;
import '../models/row_data.dart';

class FormController {
  final void Function(String) callback;
  static const String URL = "https://script.google.com/macros/s/AKfycbzIZBmQo4RhQKWsomQfBgPaJfd9Fv6S1lttMLb5HVYr0J44ta00/exec";
  static const STATUS_SUCCESS = "SUCCESS";

  FormController(this.callback);

  void submitForm(RowData feedbackForm) async {
    try {
      await http.get(
        URL + feedbackForm.toParams()
      ).then((response){
        print(URL + feedbackForm.toParams());
        callback(convert.jsonDecode(response.body)['status']);
      });    
    } catch (e) {
      print(e);
    }
  }
}