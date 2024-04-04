import 'package:crypto_coins/repositories/crypto_coins/models/crypto_coin.dart';

abstract class AbstractCoinsRepo {
  Future<List<CryptoCoin>> getCoinsList();
}
