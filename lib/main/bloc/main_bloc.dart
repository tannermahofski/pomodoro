import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

part 'main_event.dart';
part 'main_state.dart';

class MainBloc extends Bloc<MainEvent, MainState> {
  MainBloc() : super(const MainStateHome()) {
    on<MainEventHomeTapped>(_onMainEventHomeTapped);
    on<MainEventPlannerTapped>(_onMainEventPlannerTapped);
  }

  void _onMainEventHomeTapped(
      MainEventHomeTapped event, Emitter<MainState> emit) {
    emit(const MainStateHome());
  }

  void _onMainEventPlannerTapped(
      MainEventPlannerTapped event, Emitter<MainState> emit) {
    emit(const MainStatePlanner());
  }
}
