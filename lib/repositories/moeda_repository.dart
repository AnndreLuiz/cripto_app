import 'package:criptomoedas_app/models/models.dart';

class MoedaRepository {
  static List<Moeda> tabela = [
    Moeda(
      icone: 'images/bitcoin.png',
      nome: 'Bitcoin',
      sigla: 'BTC',
      preco: 101287.85,
    ),
    Moeda(
      icone: 'images/cardano.png',
      nome: 'Cardano',
      sigla: 'ADA',
      preco: 1.90,
    ),
    Moeda(
      icone: 'images/Ethereum.png',
      nome: 'Ethereum',
      sigla: 'ETH',
      preco: 6859.65,
    ),
    Moeda(
      icone: 'images/litecoin.png',
      nome: 'Litecoin',
      sigla: 'LTC',
      preco: 270.33,
    ),
    Moeda(
      icone: 'images/usdcoin.png',
      nome: 'Usdcoin',
      sigla: 'USD',
      preco: 0.99,
    ),
    Moeda(
      icone: 'images/xrp.png',
      nome: 'Xrp',
      sigla: 'XRP',
      preco: 2.52,
    ),
  ];
}
