import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_nav_state.dart';

class MainNavCubit extends Cubit<MainNavState> {
  MainNavCubit() : super(MainNavState(index: 0, isBottomNavAppear: true));

  void changeIndex(int index) {
    emit(state.copyWith(index: index));
  }

  void changeBottomNavAppear(bool isBottomNavAppear) {
    emit(state.copyWith(isBottomNavAppear: isBottomNavAppear));
  }
}
