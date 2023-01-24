import 'dart:typed_data';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'model.dart';

class DBHelper {
  DBHelper._();
  static final DBHelper dbHelper = DBHelper._();

  final String dbName = 'demo.db';

  final String tableName = 'Student';
  final String colId = 'id';
  final String colName = 'name';
  final String colQua = 'quantity';

  final String colPrice = 'price';
  final String colImage = 'image';
  Database? db;
  // TODO: initDB();

  Future<void> initDB() async {
    String directory = await getDatabasesPath();
    String path = join(directory, dbName);

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        String query =
            "CREATE TABLE IF NOT EXISTS $tableName($colId INTEGER PRIMARY KEY AUTOINCREMENT,$colName TEXT,$colPrice INTEGER,$colQua INTEGER, $colImage BLOB);";

        await db.execute(query);
        print("----------------------------------");
        print("Table created successfully");
        print("------------------------------------");
      },
    );
  }

  // TODO: insertRecord();
  Future<int> insertRecord(
      {required String name,
      required int price,
      required int quantity,
      Uint8List? image}) async {
    await initDB();
    String query =
        "INSERT INTO $tableName($colName,$colPrice,$colQua, $colImage ) VALUES(?,?, ?,?);";

    List args = [name, price, quantity, image!];

    int id = await db!.rawInsert(query, args);
    print(args);
    return id;
  }

// TODO: fetchAllRecords();
  Future<List<Product>> fetchAllRecords() async {
    await initDB();
    String query = "SELECT * FROM $tableName";
    List<Map<String, dynamic>> allProducts = await db!.rawQuery(query);
    print(allProducts);
    List<Product> products =
        allProducts.map((e) => Product.fromMap(e)).toList();
    return products;
  }

// TODO: updateRecord();
  Future<int> updateRecord({
    required int quantity,
    required String name,
    required int id,
    required int price,
    Uint8List? image,
  }) async {
    await initDB();
    String query =
        "UPDATE $tableName SET  $colName=?,$colPrice=?,$colQua=?,$colImage=? WHERE $colId=?";

    List args = [name, price, quantity, image, id];
    return await db!.rawUpdate(query, args);
  }

// TODO: deleteRecords();
  Future<int> deleteRecord({required int id}) async {
    await initDB();
    String query = "DELETE FROM $tableName WHERE $colId=?";
    List args = [id];
    return await db!.rawDelete(query, args);
  }
}
