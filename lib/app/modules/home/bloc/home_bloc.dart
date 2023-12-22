import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rgt_test/app/modules/home/bloc/events.dart';
import 'package:rgt_test/app/modules/home/model/home_model.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  HomeBloc() : super(HomeState(isLoading: true)) {
    on<HomeEvent>((event, emit) async {
      if (event == HomeEvent.loadData) {
        emit(HomeState(isLoading: true));
        try {
          await Future.delayed(const Duration(seconds: 5));
          String jsonString =
              await rootBundle.loadString('assets/data/home_data.json');
          final jsonData = json.decode(jsonString);
          final homeData = HomeScreenModel.fromJson(jsonData);
          emit(HomeState(data: homeData));
        } catch (e) {
          emit(HomeState(errorMessage: e.toString()));
        }
      }
    });
  }
}
