import 'package:basic_notions/bancodados/helper.dart';
import 'package:basic_notions/bancodados/item.dart';
import 'package:basic_notions/funcoes/gastos.dart';
import 'package:basic_notions/home.dart';
import 'package:flutter/material.dart';



class Historico extends StatefulWidget {
  
  List _historicoGanhos = [];
  List _historicoGastos = [];
  Historico(this._historicoGanhos, this._historicoGastos);

  @override
  State<Historico> createState() => _HistoricoState();
}

class _HistoricoState extends State<Historico> {

  List<Item> _items = [];
  var _db = itemHelper();

  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 50,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 88, 88, 88), width: 2),
                color: Color.fromARGB(255, 185, 184, 184),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                     icon: Icon(Icons.arrow_back_ios),
                    ),
                  Text('HISTÓRICO'),

                  ],
                ),
              ),
            ),
          Padding(
            padding: EdgeInsets.only(left: 12.0, right: 12, top: 24),
            child: Container(
              height: 325,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                    border: Border.all(color: const Color.fromARGB(255, 88, 88, 88), width: 2),
                    color: Color.fromARGB(255, 185, 184, 184),
                    borderRadius: BorderRadius.circular(10),
                  ),
              child: ListView.builder(
                itemCount: widget._historicoGastos.length,
                itemBuilder: (context, index) {
                  
                  List historicoGastosReverso = widget._historicoGastos.reversed.toList();
      
                  String item1 = historicoGastosReverso[index][0].toString();
                  String item2 = historicoGastosReverso[index][1].toString();
                  
                  return ListTile(
                    title: Text(
                      item1,
                      style: TextStyle(
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    subtitle: Text(
                      'R\$ -$item2',
                      style: TextStyle(
                        color: Color.fromARGB(255, 212, 9, 9),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                }
              ),
            ),
          ),

          Padding(
              padding: EdgeInsets.only(left: 12.0, right: 12, top: 20),
              child: Container(
                height: 325,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                      border: Border.all(color: Color.fromARGB(255, 2, 97, 26), width: 2),
                      color: Color.fromARGB(255, 185, 184, 184),
                      borderRadius: BorderRadius.circular(10),
                    ),
                child: ListView.builder(
                  itemCount: widget._historicoGanhos.length,
                  itemBuilder: (context, index) {
                    
                    List historicoGanhosReverso = widget._historicoGanhos.reversed.toList();
        
                    String item3 = historicoGanhosReverso[index][0].toString();
                    String item4 = historicoGanhosReverso[index][1].toString();
                    
                    return ListTile(
                      title: Text(
                        item3,
                        style: TextStyle(
                          fontWeight: FontWeight.bold
                        ),
                      ),
                      subtitle: Text(
                        'R\$ +$item4',
                        style: TextStyle(
                          color: Color.fromARGB(255, 2, 97, 26),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    );
                  }
                ),
              ),
          ),

        ],
      ),
    );
  }
}