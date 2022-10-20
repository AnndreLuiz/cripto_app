import 'package:criptomoedas_app/repositories/moeda_repository.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/models.dart';

class MoedasPage extends StatelessWidget {
  const MoedasPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tabela = MoedaRepository.tabela;
    NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
    List<Moeda> selecionadas = [];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Cripto Moedas'),
        centerTitle: true,
      ),
      body: ListView.separated(
        itemBuilder: (BuildContext context, int moeda) {
          return ListTile(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12),
              ),
            ),
            leading: SizedBox(
              width: 40,
              child: Image.asset(tabela[moeda].icone),
            ),
            title: Text(
              tabela[moeda].nome,
              style: const TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w500,
                color: Colors.indigo,
              ),
            ),
            trailing: Text(
              real.format(tabela[moeda].preco),
            ),
            selected: selecionadas.contains(tabela[moeda]),
            selectedTileColor: Colors.indigo[50],
            onLongPress: () {
              (selecionadas.contains(tabela[moeda]))
                  ? selecionadas.remove(tabela[moeda])
                  : selecionadas.add(tabela[moeda]);
              print(tabela[moeda].nome);
            },
          );
        },
        padding: EdgeInsets.all(10),
        separatorBuilder: (_, ___) => Divider(),
        itemCount: tabela.length,
      ),
    );
  }
}
