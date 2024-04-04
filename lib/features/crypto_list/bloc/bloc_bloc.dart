import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:crypto_coins/repositories/crypto_coins/abstract_coin_repo.dart';
import 'package:crypto_coins/repositories/crypto_coins/models/crypto_coin.dart';
import 'package:equatable/equatable.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_flutter/talker_flutter.dart';

part 'bloc_event.dart';
part 'bloc_state.dart';

class CryptoLisBloc extends Bloc<BlocEvent, CryptoListState> {
  CryptoLisBloc(this.coinsRepositoory) : super(BlocInitial()) {
    on<LoadCryptoLis>(
      (event, emit) async {
        try {
          if (state is! CryptoListLoaded) {
            emit(CryptoCoinsLoading());
          }
          final coinsList = await coinsRepositoory.getCoinsList();
          emit(CryptoListLoaded(coinsList: coinsList));
        } catch (e, st) {
          emit(CryptoListLoadFailure(exteption: e));
          GetIt.I<Talker>().handle(e, st);
        } finally {
          event.completer?.complete();
        }
      },
    );
  }
  final AbstractCoinsRepo coinsRepositoory;
  @override
  void onError(Object error, StackTrace stackTrace) {
    super.onError(error, stackTrace);
    GetIt.I<Talker>().handle(error, stackTrace);
  }
}
