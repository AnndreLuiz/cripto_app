import 'package:criptomoedas_app/configs/app_settings.dart';
import 'package:criptomoedas_app/models/moeda.dart';
import 'package:criptomoedas_app/repositories/conta_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class MoedasDetalhesPage extends StatefulWidget {
  Moeda moeda;
  MoedasDetalhesPage({super.key, required this.moeda});

  @override
  State<MoedasDetalhesPage> createState() => _MoedasDetalhesPageState();
}

class _MoedasDetalhesPageState extends State<MoedasDetalhesPage> {
  NumberFormat real = NumberFormat.currency(locale: 'pt_BR', name: 'R\$');
  final TextEditingController _valor = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  double quantidade = 0;
  late ContaRepository conta;

  comprar() async {
    if (_formKey.currentState!.validate()) {
      //salvar a comprar
      await conta.comprar(widget.moeda, double.parse(_valor.text));

      Navigator.pop(context);

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('comprar realizada com sucesso!'),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    readNumberFormat();
    conta = Provider.of<ContaRepository>(context, listen: false);
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moeda.nome),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(bottom: 24),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 50,
                    child: Image.asset(widget.moeda.icone),
                  ),
                  Container(width: 10),
                  Text(
                    real.format(widget.moeda.preco),
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w600,
                      letterSpacing: -1,
                      color: Colors.grey[800],
                    ),
                  ),
                ],
              ),
            ),
            (quantidade > 0)
                ? SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: Container(
                      child: Text(
                        '$quantidade ${widget.moeda.sigla}',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.black,
                        ),
                      ),
                      margin: EdgeInsets.only(bottom: 24),
                      padding: EdgeInsets.all(12),
                      alignment: Alignment.center,
                      // decoration: BoxDecoration(
                      //   color: Colors.teal.withOpacity(0.05),
                      // ),
                    ),
                  )
                : Container(
                    margin: EdgeInsets.only(bottom: 24),
                  ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Form(
                key: _formKey,
                child: TextFormField(
                  controller: _valor,
                  style: const TextStyle(fontSize: 22),
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Valor',
                    prefixIcon: Icon(Icons.monetization_on_outlined),
                    suffix: Text(
                      'reais',
                      style: TextStyle(fontSize: 14),
                    ),
                  ),
                  keyboardType: TextInputType.number,
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'informe o valor da compra';
                    } else if (double.parse(value) < 50) {
                      return 'compra mínima é R\$ 50,00';
                    } else if (double.parse(value) > conta.saldo) {
                      return 'voce nao tem saldo suficiente';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      quantidade = (value.isEmpty)
                          ? 0
                          : double.parse(value) / widget.moeda.preco;
                    });
                  },
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              margin: EdgeInsets.only(top: 24),
              child: ElevatedButton(
                onPressed: comprar,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.check),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: Text(
                        'Comprar',
                        style: TextStyle(
                          fontSize: 20,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  readNumberFormat() {
    final loc = context.watch<AppSettings>().locale;
    real = NumberFormat.currency(locale: loc['locale'], name: loc['name']);
  }
}
