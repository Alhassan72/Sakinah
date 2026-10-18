part of 'main_nav_cubit.dart';

class MainNavState extends Equatable {
  final int index;
  final bool isBottomNavAppear;
  const MainNavState({required this.index, required this.isBottomNavAppear});

  MainNavState copyWith({int? index, bool? isBottomNavAppear}) {
    return MainNavState(
      index: index ?? this.index,
      isBottomNavAppear: isBottomNavAppear ?? this.isBottomNavAppear,
    );
  }

  @override
  List<Object> get props => [index, isBottomNavAppear];
}
