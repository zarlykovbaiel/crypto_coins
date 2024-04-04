import 'package:equatable/equatable.dart';

class CryptoCoin extends Equatable {
  CryptoCoin(
      {required this.name, required this.priceInUSD, required this.imageUrl});
  final String name;
  final double priceInUSD;
  final String imageUrl;

  @override
  // TODO: implement props
  List<Object?> get props => [name, priceInUSD, imageUrl];
}
