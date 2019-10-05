import 'package:flutter/material.dart';
import 'package:teste/novoServico.dart';

class CabRod extends StatefulWidget {
  @override
  _CabRodState createState() => _CabRodState();
}

class _CabRodState extends State<CabRod> {
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
                      color: Colors.black54)
              ),

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
                      color: Colors.black54)
              ),
            ),
          ],

        ),
        floatingActionButton: FloatingActionButton(
            onPressed: (){Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => NovoServico()),
            );},
            tooltip: 'Incrementar',
            child: Icon(Icons.add),backgroundColor: Colors.green)
    );
  }
}