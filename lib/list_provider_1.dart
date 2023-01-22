import 'dart:async';
import 'api_service.dart';
import 'model.dart';
import 'package:flutter/material.dart';
enum ResultState1 { loading, noData, hasData, error, noConnection }

class ListUser1Provider extends ChangeNotifier {
  final ApiService apiService;
  final int page;

  ListUser1Provider({required this.apiService, required this.page}) {
    fetchListUser1(page);
  }

  late DataModel _listUser;
  late ResultState1 _state;
  String _message = '';

  String get message => _message;
  DataModel get result => _listUser;
  ResultState1 get state => _state;

  Future<dynamic> fetchListUser1(int page) async {
    try {
      _state = ResultState1.loading;
      notifyListeners();
      final listUser = await apiService.loadList1(page);
      if (listUser.data.isEmpty) {
        _state = ResultState1.noData;
        notifyListeners();
        return _message = 'Empty Data';
      } else {
        _state = ResultState1.hasData;
        notifyListeners();
        return _listUser = listUser;
      }
    } catch (e) {
      _state = ResultState1.error;
      notifyListeners();
      return _message = 'Check your internet connection!';
    }
  }
}