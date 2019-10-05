import 'package:flutter/material.dart';
import 'package:teste/novoServico.dart';
import 'package:teste/codigo/content.dart';
import 'package:teste/pages/mensagem.dart';
import 'package:teste/pages/pageHistorico.dart';
import 'package:teste/codigo/contact_helper.dart';
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  ContactHelper helper = ContactHelper();
  final _pgController = PageController();
  List<Contact> servico = List();

  int _currentIndex = 0;

  final List<Widget> _children = [
    ContentPage(title: "Perfil"),
    Mensagem(),
    ContentPage(title: "Solicitações"),
    Historico(),
    ContentPage(title: "Serviço"),
  ];

  void _onBottomNavBarTab(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return PageView(controller: _pgController, children: <Widget>[
      Scaffold(
        appBar: AppBar(
          leading: Builder(builder: (BuildContext context) {
            return IconButton(
              icon: Image.asset(
                "icones/lupa.png",
                height: 35,
              ),
              onPressed: () {},
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
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onBottomNavBarTab,
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
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              _novoServico();

            },
            tooltip: 'Incrementar',
            child: Icon(Icons.add),
            backgroundColor: Colors.green),
      ),
    ]);
  }
  void _novoServico({Contact servico}) async {
    final recContact = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => NovoServico(servico: servico,))
    );
    if(recContact != null){
      if(servico != null){
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
}
