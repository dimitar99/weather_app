part of 'signal_check_bloc.dart';

@immutable
abstract class SignalCheckEvent {
  const SignalCheckEvent();
}

class AddConnection extends SignalCheckEvent {
  final ConnectivityResult connectionResult;
  const AddConnection(this.connectionResult);
}
