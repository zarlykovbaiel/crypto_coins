part of 'bloc_bloc.dart';

abstract class BlocEvent extends Equatable {}

class LoadCryptoLis extends BlocEvent {
  LoadCryptoLis({this.completer});

  final Completer? completer;

  @override
  List<Object?> get props => [completer];
}
