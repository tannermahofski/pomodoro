part of 'main_bloc.dart';

abstract class MainState extends Equatable {
  const MainState({required this.index});

  final int index;

  @override
  List<Object> get props => [index];
}

class MainStateHome extends MainState {
  const MainStateHome({super.index = 0});
}

class MainStatePlanner extends MainState {
  const MainStatePlanner({super.index = 2});
}
