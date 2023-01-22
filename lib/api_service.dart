import 'dart:convert';
import 'package:http/http.dart' as http;
import 'model.dart';
import 'third_screen.dart';
 
class ApiService {
  
  static const String baseUrl1 = 'https://reqres.in/api/users?page=';  
    
 
  Future<DataModel> loadList1(int page) async {
    final response = await http.get(Uri.parse("${baseUrl1}${page}"));
    if (response.statusCode == 200) {
      return DataModel.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load list');
    }
  } 
}