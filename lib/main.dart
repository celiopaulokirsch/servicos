import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:teste/endereco.dart';
import 'package:teste/homePage.dart';
import 'package:teste/novoServico.dart';

main(){

  Firestore.instance.collection("Teste").document("teste").setData({"teste": "teste"});
  runApp(MaterialApp(

    debugShowCheckedModeBanner: false,
    title: "Teste",
    home: HomePage(),
  ));
}