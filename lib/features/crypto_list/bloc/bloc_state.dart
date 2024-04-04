part of 'bloc_bloc.dart';

abstract class CryptoListState extends Equatable {}

final class BlocInitial extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoCoinsLoading extends CryptoListState {
  @override
  List<Object?> get props => [];
}

class CryptoListLoaded extends CryptoListState {
  CryptoListLoaded({
    required this.coinsList,
  });

  final List<CryptoCoin> coinsList;

  @override
  List<Object?> get props => coinsList;
}

class CryptoListLoadFailure extends CryptoListState {
  CryptoListLoadFailure({required this.exteption});

  final Object? exteption;

  @override
  List<Object?> get props => [exteption];
}
