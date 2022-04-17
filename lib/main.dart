// ignore_for_file: camel_case_types

import 'package:flutter/material.dart';

void main() {
  runApp(const myApp());
}

class myApp extends StatelessWidget {
  const myApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: "Flutter IMC",
      home: homePage(),
    );
  }
}

class homePage extends StatefulWidget {
  const homePage({Key? key}) : super(key: key);

  @override
  State<homePage> createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _tTotalConta = TextEditingController();
  final _tQtPessoas = TextEditingController();
  final _tComissao = TextEditingController();
  final ButtonStyle style = ElevatedButton.styleFrom(
      textStyle: const TextStyle(fontWeight: FontWeight.bold));

  var infoText = "informe seus dados";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Divisão de Contas"),
        centerTitle: true,
      ),
      body: body(),
    );
  }

  body() {
    return Container(
      padding: const EdgeInsets.all(15),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: Icon(Icons.attach_money),
                hintText: "Valor Total da Conta",
              ),
              controller: _tTotalConta,
              validator: (String? value) {
                return (value == null || value.isEmpty)
                    ? "Informe um Valor !"
                    : null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: "Quantidade de Pessoas",
              ),
              controller: _tQtPessoas,
              validator: (String? value) {
                return (value == null || value.isEmpty)
                    ? "Informe um valor !"
                    : null;
              },
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                icon: Icon(Icons.percent),
                hintText: "Comissão",
              ),
              controller: _tComissao,
              validator: (String? value) {
                return (value == null || value.isEmpty)
                    ? "Informe um valor !"
                    : null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  calcular();
                }
              },
              child: const Text("Calcular"),
              style: style,
            ),
            Text(
              infoText,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  } // body

  calcular() {
    setState(() {
      double valorTotal = double.parse(_tTotalConta.text);
      double qtPessoas = double.parse(_tQtPessoas.text);
      double comissao = double.parse(_tComissao.text) / 100;

      double valorComissao = valorTotal * comissao;
      double totalComComissao = valorTotal + valorComissao;
      double totalPorPessoa = totalComComissao / qtPessoas;

      infoText = "Parte do Garçom : " +
          valorComissao.toString() +
          "\n Total por Pessoa : " +
          totalPorPessoa.toString() +
          "\n Total a pagar : " +
          totalComComissao.toString();
    });
  } // calcular

}
