import 'dart:async';

import 'package:crypto_coins/crypto_coins_list_app.dart';
import 'package:crypto_coins/repositories/crypto_coins/abstract_coin_repo.dart';
import 'package:crypto_coins/repositories/crypto_coins/crypto_coins_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
import 'package:talker_dio_logger/talker_dio_logger.dart';
import 'package:talker_flutter/talker_flutter.dart';

void main() {
  final talker = TalkerFlutter.init();
  GetIt.I.registerSingleton(talker);
  GetIt.I<Talker>().debug("talker started...");

  final dio = Dio();
  dio.interceptors.add(
    TalkerDioLogger(
      settings: const TalkerDioLoggerSettings(
        printRequestHeaders: true,
        printResponseHeaders: true,
        printResponseMessage: true,
      ),
    ),
  );

  GetIt.I.registerLazySingleton<AbstractCoinsRepo>(
    () => CryptoCoinsRepository(dio: dio),
  );

  FlutterError.onError =
      ((details) => GetIt.I<Talker>().handle(details.exception, details.stack));

  runZonedGuarded(
    () => runApp(const CryptoCurenciesListApp()),
    (e, st) => GetIt.I<Talker>().handle(e, st),
  );
}
