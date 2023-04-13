part of 'main_bloc.dart';

abstract class MainEvent extends Equatable {
  const MainEvent({required this.index});

  final int index;

  @override
  List<Object> get props => [index];
}

class MainEventHomeTapped extends MainEvent {
  const MainEventHomeTapped({super.index = 0});
}

class MainEventPlannerTapped extends MainEvent {
  const MainEventPlannerTapped({super.index = 2});
}
