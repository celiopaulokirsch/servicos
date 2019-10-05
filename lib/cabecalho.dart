import 'package:flutter/material.dart';
import 'package:teste/homePage.dart';
import 'package:teste/novoServico.dart';

class Cabecalho extends StatefulWidget {
  @override
  _CabecalhoState createState() => _CabecalhoState();
}

class _CabecalhoState extends State<Cabecalho> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Builder(builder: (BuildContext context) {
          return IconButton(
            icon: Image.asset(
              "icones/lupa.png",
              height: 35,
            ),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );},
          );
        }),
        title: Text(
          "Todos os Serviços",
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        actions: <Widget>[
          IconButton(
              icon: Image.asset(
                "icones/informacao.png",
                height: 45,
              ),
              onPressed: () {})
        ],
      ),


    );
  }
}
