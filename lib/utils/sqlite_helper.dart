import 'package:sqflite/sqflite.dart';
import 'package:book/domins.dart' show DbModel;
import 'package:path/path.dart';

/// 数据库帮助类
class DbHelper {
  Database _database;
  final String columnId = 'id';
  final String columnType = 'type';
  final String columnTitle = 'title';
  final String columnUrl = 'url';
  final String columnMovieId = 'movie_id';

  final String tableCollection = 'collection';
  final String path = 'book_path';

  Future _openDb([String path = ""]) async {
    if (path.isEmpty) {
      var dbPath = await getDatabasesPath();
      path = join(dbPath, 'book.db');
    }
    print("path------>${path}");

    if (_database == null) {
      _database =
          await openDatabase(path, version: 1, onCreate: (db, version) async {
        await db.execute("""create table $tableCollection ( 
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnType text not null,
  $columnUrl text not null,
  $columnMovieId integer not null)""");
      });
    }
  }

  Future closeDb() async {
    if (_database != null) {
      _database.close();
    }
  }

  /// 插入
  Future<DbModel> insert(DbModel item) async {
    await _openDb(path);
    item.id = await _database.insert(tableCollection, item.toJson());
    return item;
  }

  /// 删除
  Future<int> delete(int id) async {
    await _openDb(path);
    return await _database
        .delete(tableCollection, where: "$columnId = ?", whereArgs: [id]);
  }

   Future<int> deleteByUrl(String url) async {
    await _openDb(path);
    return await _database
        .delete(tableCollection, where: "$columnUrl = ?", whereArgs: [url]);
  }

  /// 更新
  Future<int> update(DbModel item) async {
    await _openDb(path);
    return await _database.update(tableCollection, item.toJson(),
        where: '$columnId = ?', whereArgs: [item.id]);
  }

  /// 查询 单个
  Future<DbModel> getModel(int id) async {
    await _openDb(path);
    List<Map> maps = await _database.query(tableCollection,
        columns: [columnId, columnTitle, columnType, columnUrl, columnMovieId],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.length > 0) {
      return DbModel.fromJson(maps.first);
    }
    return null;
  }

  /// 查询全部
  Future<List<DbModel>> getModels() async {
    await _openDb(path);
    List<Map<String, dynamic>> results = await _database.query(tableCollection,
        columns: [columnId, columnTitle, columnType, columnUrl, columnMovieId]);
    print("object----getModels----->retults.length........${results.length}");
    List<DbModel> list = [];
    if (results != null) {
      for (int i = 0; i < results.length; i++) {
        list.add(DbModel.fromJson(results[i]));
      }
    }
    return list;
  }
}
