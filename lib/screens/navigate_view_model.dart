import 'package:flutter_bloc/flutter_bloc.dart';

class NavigateViewModel extends Cubit {
  NavigateViewModel() : super(MainInitialState());
  int currentTabIndex = 0;

  void changeSelectedTab(int newIndex) {
    currentTabIndex = newIndex;
    emit(MainInitialState());
  }
}

class MainInitialState {}