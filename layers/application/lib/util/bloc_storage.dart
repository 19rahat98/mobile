import 'package:hive/hive.dart';
import 'package:logger/logger.dart';

abstract class BlocStorage {
  Future<Map?> read(String key);
  Future<void> write(String key, Map value);
  Future<void> delete(String key);
  Future<void> clear();
}

class LocalStorage implements BlocStorage {
  LocalStorage(this.db, {Logger? logger}) : logger = logger ?? Logger();

  final Box<Map> db;
  final Logger logger;

  @override
  Future<Map?> read(String key) async {
    final _result = db.get(key);
    logger.d(
      '[HYDRATE] | READ: $key = $_result',
    );
    return _result;
  }

  @override
  Future<void> write(String key, Map value) async {
    logger.d(
      '[HYDRATE] | WRITE: $key = $value',
    );
    await db.put(key, value);
  }

  @override
  Future<void> delete(String key) async {
    logger.d('[HYDRATE] | DELETE: $key');
    await db.delete(key);
  }

  @override
  Future<void> clear() async {
    logger.v('[HYDRATE] | CLEAR ALL');
    await db.clear();
  }
}
