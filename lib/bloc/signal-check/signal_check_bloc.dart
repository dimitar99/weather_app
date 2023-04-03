import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'signal_check_event.dart';
part 'signal_check_state.dart';

class SignalCheckBloc extends Bloc<SignalCheckEvent, SignalCheckState> {
  SignalCheckBloc() : super(SignalCheckState()) {
    on<AddConnection>(_addConnectionToBloc);
  }

  _addConnectionToBloc(AddConnection event, Emitter<SignalCheckState> emit) {
    emit(state.copyWith(connectivityResult: event.connectionResult));
  }
}
