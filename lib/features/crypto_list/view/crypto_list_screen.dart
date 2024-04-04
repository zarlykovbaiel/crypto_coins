import 'dart:async';

import 'package:crypto_coins/features/crypto_list/bloc/bloc_bloc.dart';
import 'package:crypto_coins/features/crypto_list/widgets/crypto_coin_tile.dart';
import 'package:crypto_coins/repositories/crypto_coins/abstract_coin_repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';

class CryptoListScreen extends StatefulWidget {
  const CryptoListScreen({super.key});

  @override
  State<CryptoListScreen> createState() => _CryptoListScreenState();
}

class _CryptoListScreenState extends State<CryptoListScreen> {
  final _crytoListBloc = CryptoLisBloc(GetIt.I<AbstractCoinsRepo>());
  @override
  void initState() {
    _crytoListBloc.add(LoadCryptoLis());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        // elevation: -1,
        backgroundColor: theme.appBarTheme.backgroundColor,
        title: const Text("Crypto Currencies"),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          final completer = Completer();
          _crytoListBloc.add(LoadCryptoLis(completer: completer));
          return completer.future;
        },
        child: BlocBuilder<CryptoLisBloc, CryptoListState>(
          bloc: _crytoListBloc,
          builder: (context, state) {
            if (state is CryptoListLoaded) {
              return ListView.separated(
                padding: const EdgeInsets.only(top: 16),
                itemCount: state.coinsList.length,
                separatorBuilder: (context, index) =>
                    const Divider(color: Colors.white12),
                itemBuilder: (context, i) {
                  final coin = state.coinsList[i];
                  return CryptoCoinTile(coin: coin);
                },
              );
            }
            if (state is CryptoListLoadFailure) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      "Something went wrong",
                      style: TextStyle(color: Colors.white),
                    ),
                    Text(
                      "Please try againg later",
                      style: theme.textTheme.labelSmall?.copyWith(fontSize: 16),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    TextButton(
                        onPressed: () {
                          _crytoListBloc.add(LoadCryptoLis());
                        },
                        child: const Text("Try again"))
                  ],
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
