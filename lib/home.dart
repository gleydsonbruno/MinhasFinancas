import 'package:basic_notions/funcoes/gastos.dart';
import 'package:flutter/material.dart';
import 'package:basic_notions/bancodados/helper.dart';
import 'package:basic_notions/bancodados/item.dart';

class Home extends StatefulWidget {
  
  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 39, 37, 37),
      
      body: Column(
        children: [
          
          //Tela do Perfil (estática)
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 250,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 88, 88, 88), width: 2),
                color: Color.fromARGB(255, 185, 184, 184),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [

                  Text('Seja bem-vindo, nome'),
                  Text('Gastos de hoje:  '),
                  Padding(
                    padding: EdgeInsets.only(top: 10, bottom: 10),
                    child: Container(
                      padding: EdgeInsets.only(left: 40, right: 40),
                      height: 150,
                      width: 300,
                      decoration: BoxDecoration(
                        border: Border.all(color: const Color.fromARGB(255, 88, 88, 88), width: 2),
                        borderRadius: BorderRadius.circular(10),
                        color:  Color.fromARGB(255, 138, 137, 137),
                      ),
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20, left: 10, right: 10),
                          child: Column(
                            children: [
                              Text('Contagem de gastos')
                            ],
                          ),
                        ),
                      ),
                      
                    ),
                  ),
                  Text('Seu saldo:')
                  
                ],
              ),
            ),
          ),
          
          //A partir daqui é funcionalidade
          GestureDetector(
            onTap: () {
              Navigator.push(
                context, MaterialPageRoute(
                  builder: (context) => Gastos(),
                )
              );
            },
            child: Padding(
              padding: EdgeInsets.only(top: 20, left: 10, right: 10),
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 100,
                decoration: BoxDecoration(
                  border: Border.all(color: const Color.fromARGB(255, 88, 88, 88), width: 2),
                  color: Color.fromARGB(255, 185, 184, 184),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('GASTOS')
                  ],
                )
              ), 
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 88, 88, 88), width: 2),
                color: Color.fromARGB(255, 185, 184, 184),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('COFRE')
                  ],
                )
            ), 
          ),

          Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 88, 88, 88), width: 2),
                color: Color.fromARGB(255, 185, 184, 184),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('----------------')
                  ],
                )
            ), 
          ),

          Padding(
            padding: EdgeInsets.only(top: 20, left: 10, right: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 88, 88, 88), width: 2),
                color: Color.fromARGB(255, 185, 184, 184),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('CONFIGURAÇÕES')
                  ],
                )
            ), 
          ),

        ],
      ),
    );
  }
}