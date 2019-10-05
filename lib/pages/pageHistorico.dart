import 'dart:io';

import 'package:flutter/material.dart';
import 'package:teste/codigo/contact_helper.dart';
import 'package:teste/novoServico.dart';
import 'package:url_launcher/url_launcher.dart';

enum OrderOptions {orderaz, orderza}


class Historico extends StatefulWidget {
  @override
  _HistoricoState createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {
  List<Contact> servico = List();
  ContactHelper helper = ContactHelper();

  @override
  void initState() {
    super.initState();
    helper.getAllContacts().then((list) {
      setState(() {
        servico = list;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemCount: servico.length,
          itemBuilder: (context, index) {
           return _servico(context, index);
          }),
    );
  }
Widget _servico(BuildContext context, int index){
  return GestureDetector(
    child: Card(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          children: <Widget>[
            Container(
              width: 80.0,
              height: 80.0,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: servico[index].img != null ?
                    FileImage(File(servico[index].img)) :
                    AssetImage("icones/foto.png"),
                    fit: BoxFit.cover
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(servico[index].name ?? "",
                    style: TextStyle(fontSize: 22.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(servico[index].email ?? "",
                    style: TextStyle(fontSize: 18.0),
                  ),
                  Text(servico[index].phone ?? "",
                    style: TextStyle(fontSize: 18.0),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    ),
    onTap: (){
      _showOptions(context, index);
    },
  );

}
  Widget _contactCard(BuildContext context, int index){
    return GestureDetector(
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: <Widget>[
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: servico[index].img != null ?
                      FileImage(File(servico[index].img)) :
                      AssetImage("images/person.png"),
                      fit: BoxFit.cover
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 10.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(servico[index].name ?? "",
                      style: TextStyle(fontSize: 22.0,
                          fontWeight: FontWeight.bold),
                    ),
                    Text(servico[index].email ?? "",
                      style: TextStyle(fontSize: 18.0),
                    ),
                    Text(servico[index].phone ?? "",
                      style: TextStyle(fontSize: 18.0),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
      onTap: (){
        _showOptions(context, index);
      },
    );
  }

  void _showOptions(BuildContext context, int index){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return BottomSheet(
            onClosing: (){},
            builder: (context){
              return Container(
                padding: EdgeInsets.all(10.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text("Mensagem",
                          style: TextStyle(color: Colors.yellow, fontSize: 20.0),
                        ),
                        onPressed: (){
//                          launch("tel:${servico[index].phone}");
//                          Navigator.pop(context);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text("Editar",
                          style: TextStyle(color: Colors.yellow, fontSize: 20.0),
                        ),
                        onPressed: (){
                          Navigator.pop(context);
                          _showContactPage(contact: servico[index]);
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10.0),
                      child: FlatButton(
                        child: Text("Excluir",
                          style: TextStyle(color: Colors.yellow, fontSize: 20.0),
                        ),
                        onPressed: (){
                          helper.deleteContact(servico[index].id);
                          setState(() {
                            servico.removeAt(index);
                            Navigator.pop(context);
                          });
                        },
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        }
    );
  }

  void _showContactPage({Contact contact}) async {
    final recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => NovoServico(servico: contact,))
    );
    if(recContact != null){
      if(contact != null){
        await helper.updateContact(recContact);
      } else {
        await helper.saveContact(recContact);
      }
      _getAllContacts();
    }
  }

  void _getAllContacts(){
    helper.getAllContacts().then((list){
      setState(() {
        servico = list;
      });
    });
  }

  void _orderList(OrderOptions result){
    switch(result){
      case OrderOptions.orderaz:
        servico.sort((a, b) {
          return a.name.toLowerCase().compareTo(b.name.toLowerCase());
        });
        break;
      case OrderOptions.orderza:
        servico.sort((a, b) {
          return b.name.toLowerCase().compareTo(a.name.toLowerCase());
        });
        break;
    }
    setState(() {

    });
  }
}
