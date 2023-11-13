import 'package:basic_notions/bancodados/helper.dart';

class Item {

  int? id;
  late String titulo;
  late double valor;
  late double saldo;

  Item(this.titulo, this.valor, this.saldo);

  Item.fromMap(Map map) {
    this.id = map[itemHelper.colunaId];
    this.titulo = map[itemHelper.colunaTitulo];
    this.valor = map[itemHelper.colunaValor];
    this.saldo = map[itemHelper.colunaSaldo];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      'titulo': this.titulo,
      'valor': this.valor,
      'saldo': this.saldo,
    };

    if (this.id != null) {
      map['id'] = this.id;
    }

    return map;

  }


}