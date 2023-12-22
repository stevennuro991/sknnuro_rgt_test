import 'package:rgt_test/app/modules/home/model/home_model.dart';

enum HomeEvent { loadData }

class HomeState {
  final bool isLoading;
  final HomeScreenModel? data;
  final String? errorMessage;

  HomeState({this.isLoading = false, this.data, this.errorMessage});
}
