part of 'signal_check_bloc.dart';

class SignalCheckState {
  final ConnectivityResult connectivityResultState;

  SignalCheckState({this.connectivityResultState = ConnectivityResult.none});

  SignalCheckState copyWith({required ConnectivityResult connectivityResult}) {
    return SignalCheckState(connectivityResultState: connectivityResult);
  }
}
