import 'package:basic_notions/bancodados/item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class itemHelper {


  static final String nomeTabela = 'items';
  static final String colunaId = 'id';
  static final String colunaTitulo = 'titulo';
  static final String colunaValor = 'valor';
  static final String colunaSaldo = 'saldo';

  static final itemHelper _itemHelper = itemHelper._internal();
  Database? _db;

  factory itemHelper() {
    return _itemHelper;
  }

  itemHelper._internal() {
    inicializarDB();
  }

  get db async {

    if (_db != null) {
      return _db;
    } else {
      _db = await inicializarDB();
      return _db;
    }
  }

  _onCreate(Database db, int version) async {
    String sql = 'CREATE TABLE $nomeTabela ($colunaId INTEGER PRIMARY KEY AUTOINCREMENT , $colunaTitulo VARCHAR, $colunaValor REAL, $colunaSaldo REAL)';
    await db.execute(sql); 
  }

  inicializarDB() async {

    final caminhoBancoDados = await getDatabasesPath();
    final localBancoDados = join(caminhoBancoDados, 'banco_items');

    var db = await openDatabase(localBancoDados, version: 1, onCreate: _onCreate);
    return db;

  }

  Future <int> salvarItem(Item item) async {

    var bancoDados = await db;

    int resultado = await bancoDados.insert(nomeTabela, item.toMap());
    return resultado;

  }

  recuperarItems() async {

    var bancoDados = await db;
    String sql = 'SELECT * FROM $nomeTabela';
    List items = await bancoDados.rawQuery(sql);
    return items;

  }

  Future<int> atualizarItem(Item item) async {

    var bancoDados = await db;
    return await bancoDados.update(
      nomeTabela,
      item.toMap(),
      where: 'id = ?',
      whereArgs: [item.id],
    );

  }

  Future<int> removerItem(int id) async {

    var bancoDados = await db;
    return await bancoDados.delete(
      nomeTabela,
      where: 'id = ?',
      whereArgs: [id],
    );

  }

  Future <int> salvarSaldo(double saldo) async {

    var bancoDados = await db;
    Map<String, dynamic> dados = {
    'saldo': saldo.toString(), // Converta o valor de saldo para uma string
    };
    int resultado = await bancoDados.insert(nomeTabela, dados);
    return resultado;

  }
  
  Future<double> recuperarSaldo() async {

    var bancoDados = await db;
    String sql = 'SELECT $colunaSaldo FROM $nomeTabela';
    double saldo = await bancoDados.rawQuery(sql);
    return saldo;

  }









}