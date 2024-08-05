abstract class IDatasource<T>
    implements
        IGetDatasource<T>,
        IAddDatasource,
        IDeleteDatasource<T>,
        IUpdateDatasource {}

abstract class IGetDatasource<T> {
  Future<List<T>> get(
      String path, T Function(Map<String, dynamic> map) fromMap);
}

abstract class IAddDatasource {
  Future<void> add(String path, data);
}

abstract class IDeleteDatasource<T> {
  Future<bool> delete(String path, int id);
}

abstract class IUpdateDatasource {
  Future<void> update(String path, data);
}
