import 'dart:io';
import 'package:flutter/material.dart';
import 'package:teste/endereco.dart';
import 'package:image_picker/image_picker.dart';
import 'package:teste/pages/pageHistorico.dart';
import 'package:teste/codigo/contact_helper.dart';
import 'codigo/content.dart';

class NovoServico extends StatefulWidget {
  final Contact servico;
  NovoServico({this.servico});

  @override
  _NovoServicoState createState() => _NovoServicoState();
}

class _NovoServicoState extends State<NovoServico> {
  int _currentIndex = 0;

  final List<Widget> _children = [
    ContentPage(title: "Perfil"),
    ContentPage(title: "Mensagem"),
    ContentPage(title: "Solicitações"),
    Historico(),
    ContentPage(title: "Serviço"),
  ];

  void _onBottomNavBarTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();

  final _nameFocus = FocusNode();

  bool _userEdited = false;

  Contact _editedContact;

  @override
  void initState() {
    super.initState();

    if (widget.servico == null) {
      _editedContact = Contact();
    } else {
      _editedContact = Contact.fromMap(widget.servico.toMap());

      _nameController.text = _editedContact.name;
      _emailController.text = _editedContact.email;
      _phoneController.text = _editedContact.phone;
    }
  }

  ContactHelper helper = ContactHelper();

  final _pgController = PageController();
  String tipoServico = 'Selecione o tipo de Serviço';
  String solicitaPrestaServio = 'Selecione Prestar/Solicitar';

//  @override
//  void initState() {
//    super.initState();
//  if(widget.servico == null){
//  _editedContact = Contact();
//  } else {
//  _editedContact = Contact.fromMap(widget.servico.toMap());
//
//  _nameController.text = _editedContact.name;
//  _emailController.text = _editedContact.email;
//  _phoneController.text = _editedContact.phone;
//
//
////     Contact c = Contact();
////
////    c.name = "Paulo";
////    c.email = "paulo@aa.com.br";
////    c.phone = "8888888888";
////    c.img = "imagem.teste";
////
////    helper.saveContact(c);
//
////    helper.getAllContacts().then((list){
////      print(list);
////    });
//  }
//  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: _requestPop,
        child: Scaffold(
          appBar: AppBar(
            title: Text(
              _editedContact.name ?? "Todos os Serviços",
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
//            body: _children[_currentIndex],
          bottomNavigationBar: BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: Image.asset("icones/pessao.png", height: 45),
                title: Text("Perfil",
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 13,
                        color: Colors.black54)),
              ),
              BottomNavigationBarItem(
                icon: Image.asset("icones/correio.png", height: 45),
                title: Text("Mensagem",
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 15,
                        color: Colors.black54)),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "icones/carrinhoVazio.png",
                  height: 45,
                ),
                title: Text("Solicitações",
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 15,
                        color: Colors.black54)),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "icones/carrinhoCheio.png",
                  height: 45,
                ),
                title: Text("Histórico",
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 15,
                        color: Colors.black54)),
              ),
              BottomNavigationBarItem(
                icon: Image.asset(
                  "icones/prancheta.png",
                  height: 45,
                ),
                title: Text("Serviços",
                    style: TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 15,
                        color: Colors.black54)),
              ),
            ],
          ),
          backgroundColor: Colors.white,
          body: _formulario(),
        ));
  }

  Widget _formulario() {
    return SingleChildScrollView(
      padding: EdgeInsets.all(10.0),
      child: Column(
//        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          GestureDetector(
            child: Container(
              width: 140,
              height: 140,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: _editedContact.img != null
                        ? FileImage(File(_editedContact.img))
                        : AssetImage("icones/foto.png"),
                    fit: BoxFit.cover),
              ),
            ),
            onTap: () {
              ImagePicker.pickImage(source: ImageSource.camera).then((file) {
                if (file == null) return;
                setState(() {
                  _editedContact.img = file.path;
                });
              });
            },
          ),
          TextField(
            controller: _nameController,
            focusNode: _nameFocus,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: "Titulo do Serviço",
                labelStyle: TextStyle(color: Colors.black54)),
            onChanged: (text) {
              _userEdited = true;
              setState(() {
                _editedContact.name = text;
              });
            },
          ),

          TextField(
            controller: _emailController,
            keyboardType: TextInputType.text,
            decoration: InputDecoration(
                labelText: "Descrição do Serviço",
                labelStyle: TextStyle(color: Colors.black54)),
            onChanged: (text) {
              _userEdited = true;
              setState(() {
                _editedContact.email = text;
              });
            },
          ),

//              TextField(
//                keyboardType: TextInputType.number,
//                decoration: InputDecoration(
//                    labelText: "CEP Local do Serviço",
//                    labelStyle: TextStyle(color: Colors.black54)),
//                controller: cepControlador,
//
//              ),

          RaisedButton(
              color: Colors.blue,
              child: Text(
                "Encontrar Endereço",
                style: TextStyle(color: Colors.white, fontSize: 25.0),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Endereco()),
                );
              }),

          DropdownButton<String>(
            value: tipoServico,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black54),
            underline: Container(
              height: 2,
              color: Colors.black54,
            ),

            onChanged: (String newValue) {
              setState(() {
                tipoServico = newValue;
                _userEdited = true;
                setState(() {
                  _editedContact.phone = newValue;
                });
              });
            },
            items: <String>[
              'Selecione o tipo de Serviço',
              'Pedreiro',
              'Chaveiro',
              'Diarista',
              'Mecânico'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          DropdownButton<String>(
            value: solicitaPrestaServio,
            icon: Icon(Icons.arrow_downward),
            iconSize: 24,
            elevation: 16,
            style: TextStyle(color: Colors.black54),
            underline: Container(
              height: 2,
              color: Colors.black54,
            ),
            onChanged: (String newValue) {
              setState(() {
                solicitaPrestaServio = newValue;
              });
            },
            items: <String>[
              'Selecione Prestar/Solicitar',
              'Prestar Serviço',
              'Solicitar Serviço'
            ].map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
          Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0),
            child: Container(
              height: 50.0,
              child: RaisedButton(
                onPressed: () {
                  if (_editedContact.name != null &&
                      _editedContact.name.isNotEmpty) {
                    Navigator.pop(context, _editedContact);
                  } else {
                    FocusScope.of(context).requestFocus(_nameFocus);
                  }
                },
                child: Text(
                  "Confirmar Serviço",
                  style: TextStyle(color: Colors.white, fontSize: 25.0),
                ),
                color: Colors.blue,
              ),
            ),
          )
        ],
      ),
    );
  }

  Future<bool> _requestPop() {
    if (_userEdited) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text("Descartar Alterações?"),
              content: Text("Se sair as alterações serão perdidas."),
              actions: <Widget>[
                FlatButton(
                  child: Text("Cancelar"),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                FlatButton(
                  child: Text("Sim"),
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                ),
              ],
            );
          });
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }
}
