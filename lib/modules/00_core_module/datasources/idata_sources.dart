abstract class IDatasource<T> implements IGetDatasource<T> {}

abstract class IGetDatasource<T> {
  Future<List<T>> get(String path, List<T> Function(String) fromJson);
}
