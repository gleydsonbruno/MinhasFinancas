import 'package:basic_notions/bancodados/helper.dart';
import 'package:basic_notions/bancodados/item.dart';
import 'package:basic_notions/funcoes/historico.dart';
import 'package:flutter/material.dart';

class Gastos extends StatefulWidget {
  const Gastos({super.key});

  @override
  State<Gastos> createState() => _GastosState();
}

class _GastosState extends State<Gastos> {

  double saldo = 0;
  List<Item> _items = [];
  var _db = itemHelper();
  bool fixo = false;
  TextEditingController _addlistaController = TextEditingController();
  TextEditingController _valorController = TextEditingController();
  TextEditingController _editTitleController = TextEditingController();
  TextEditingController _addSaldoController = TextEditingController();
  TextEditingController _razaoController = TextEditingController();
  TextEditingController _newValor = TextEditingController();
  //Map<String, double> mapTeste = {};
  List<dynamic> _historicoGastos = [];
  List<dynamic> _historicoGanhos = [];
  


  _telaItems({Item? item}) {

    String txtsalvarAtualizar = '';
    if (item == null) {
      _addlistaController.text = '';
      _valorController.text = '';
      txtsalvarAtualizar = 'Salvar';
    } else {
      _addlistaController.text = item.titulo;
      _valorController.text = item.valor.toString();
      txtsalvarAtualizar = 'Atualizar';
    }

    showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              title: Text('$txtsalvarAtualizar a lista: '),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _addlistaController,
                    decoration: InputDecoration(labelText: 'Nome da dívida'),
                  ),
                   TextField(
                    controller: _valorController,
                    decoration: InputDecoration(labelText: 'Valor (R\$)'),
                    keyboardType: TextInputType.number,
                   ),
                ],
              ),
              
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context), 
                      child: Text('Cancelar')
                      ),
                    TextButton(
                      onPressed: () {
                        if (_addlistaController.text.isNotEmpty) {
                          String chave = _addlistaController.text;
                          double valor = double.tryParse(_valorController.text) ?? 0.0;
                          setState(() {
                            //mapTeste[chave] = valor;
                            item?.saldo -= valor;
                            _historicoGastos.add([chave, valor]);
                          });
                          _salvarAtualizarItem(itemSelecionado: item);
                          _addlistaController.clear();
                          _valorController.clear();
                          Navigator.pop(context);
                        }
                      },
                      child: Text(txtsalvarAtualizar),
                    )
              ],
            );
           }
          );


  }


  _recuperarItems() async {

    List itemsRecuperados = await _db.recuperarItems();

    List<Item> listaTemporaria = [];
    for (var produto in itemsRecuperados) {

      Item item = Item.fromMap(produto);
      listaTemporaria.add(item);

    }

    setState(() {
      _items = listaTemporaria;
    });
    listaTemporaria = [];

  }

  _salvarAtualizarItem({Item? itemSelecionado}) async {
  
    String valorTexto = _valorController.text;
    double valorConvertido = 0.0;
    String titulo = _addlistaController.text;
    double valor = 0.0;
    double saldo = 0.0;

    if (valorTexto.isNotEmpty) {
      try {
        valorConvertido = double.parse(valorTexto);
        valor = valorConvertido;
      } catch (e) {
        print('Erro: O valor digitado não é um número!');
      }
    } else {
      print('Esse campo está vazio!');
    }

    if (itemSelecionado == null) {
      Item item = Item(titulo, valor, saldo);
      int resultado = await _db.salvarItem(item);
    } else {
      itemSelecionado.titulo = titulo;
      itemSelecionado.valor = valor;
      itemSelecionado.saldo -= valor;
      int resultado = await _db.atualizarItem(itemSelecionado);
    }

    _addlistaController.clear();
    _valorController.clear();
    _recuperarItems();

  }

  _removerItem(int id) async {

    await _db.removerItem(id);
    _recuperarItems();

  }

  _recuperarSaldo() async {
    try {
      return _recuperarSaldo();  
    } catch(e) {
      print('Deu $e');
    }
    
  }

  @override
  void initState() {
    super.initState();
    _recuperarItems();
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          //Tela do Perfil (estática)
          Padding(
            padding: const EdgeInsets.only(top: 50, left: 10, right: 10),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: 100,
              decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 88, 88, 88), width: 2),
                color: Color.fromARGB(255, 185, 184, 184),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Row(
                
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children:  [
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                     icon: Icon(Icons.arrow_back_ios),
                    ),
                  Text('R\$ '),
                  IconButton(
                    onPressed: (){
                      showDialog(
                        context: context, 
                        builder: (context) {
                          return AlertDialog(
                            title: Text('Adicione dinheiro ao seu saldo'),
                            content: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextField(
                                  keyboardType: TextInputType.number,
                                  controller: _addSaldoController,
                                  decoration: InputDecoration(
                                    labelText: 'Valor a adicionar'
                                  ),
                                ),
                                TextField(
                                  controller: _razaoController,
                                  decoration: InputDecoration(
                                    labelText: 'Motivo (ex.: Salário, Rendimentos, Achei na rua, etc...)'
                                  ),
                                ) 
                              ],
                            ),
                            actions: [                           
                              TextButton(
                                onPressed: () => Navigator.pop(context), 
                                child: Text('Cancelar')
                              ),
                              TextButton(
                                onPressed: () {
                                  double valor = double.tryParse(_addSaldoController.text) ?? 0.0;
                                  setState(() {
                                    
                                    _historicoGanhos.add([_razaoController.text, valor]);
                                  });
                                  _db.salvarSaldo(valor);
                                  _addSaldoController.clear();
                                  _razaoController.clear();
                                  Navigator.pop(context);
                                }, 
                                child: Text('Adicionar')
                              ),
                            ],
                          );
                        }
                      );
                    },
                     icon: Icon(Icons.add),
                     
                    ),
                    IconButton(
                    onPressed: () {
                      Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => Historico(_historicoGanhos, _historicoGastos)
                        )
                      );
                    },
                     icon: Icon(Icons.history),
                    ),
                ],
              ),
            ),
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Container(
                decoration: BoxDecoration(
                border: Border.all(color: const Color.fromARGB(255, 88, 88, 88), width: 2),
                color: Color.fromARGB(255, 185, 184, 184),
                borderRadius: BorderRadius.circular(10),
              ),
                child: ListView.builder(
                  itemCount: _items.length,//mapTeste.length,
                  itemBuilder: (context, index) {

                    final item = _items[index];
                    
                    //String? chave = //mapTeste.keys.elementAt(index);
                    //double valor = //mapTeste[chave]!;
                    //List<String> lista = //mapTeste.keys.toList();

                    return Card(
                      color: const Color.fromARGB(255, 151, 163, 168),
                      shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(12.0)
                      ),
                      child: ListTile(                                       
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.titulo,
                               style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                ),
                              ),
                            IconButton(
                              onPressed: (){
                                _removerItem(item.id!);
                              },
                               icon: Icon(Icons.delete,)
                              ),
                            
                          ],
                        ),
                        subtitle: GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  title: Text('Alterar valor'),
                                  content: TextField(
                                    controller: _newValor,
                                  ),
                                  actions: [
                                    TextButton(
                                      onPressed: () => Navigator.pop(context), 
                                      child: Text('Cancelar')
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        setState(() {
                                          item.valor = double.parse(_newValor.text);  
                                        });                                 
                                        Navigator.pop(context);
                                        _newValor.clear();
                                        
                                      }, 
                                      child: Text('Alterar')
                                    ),
                                  ],
                                );
                              });
                          },
                          child: Text(
                            'R\$ ${item.valor}',
                            style: TextStyle(
                              color: Color.fromARGB(255, 212, 9, 9),
                              fontWeight: FontWeight.bold,
                            ),
                            ),
                        ),                     
                      ),
                    );
                  }
                ),
              ),
            )
          )

        ]
      ),
     floatingActionButton: FloatingActionButton(
      backgroundColor: Color.fromARGB(255, 88, 88, 88),
      onPressed: (){
        _telaItems();
        },
      child: Icon(Icons.add, ),
      tooltip: 'Adicionar um item à lista',
      ),
    );
  }
}