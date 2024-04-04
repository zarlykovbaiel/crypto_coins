import 'package:crypto_coins/features/crpto_scoin/view/crypto_coin_screen.dart';
import 'package:crypto_coins/features/crypto_list/view/crypto_list_screen.dart';

final routes = {
  "/": (context) => const CryptoListScreen(),
  "/coin": (context) => const CryptoCoinScreen(),
};
