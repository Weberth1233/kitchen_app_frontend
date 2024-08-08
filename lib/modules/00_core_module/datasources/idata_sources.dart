abstract class IDatasource<T>
    implements IGetDatasource<T>, IGetPaginationDatasource<T> {}

abstract class IGetDatasource<T> {
  Future<List<T>> get(String path, List<T> Function(String) fromJson);
}

abstract class IGetPaginationDatasource<T> {
  Future<List<T>> getPaginated(String path, List<T> Function(String) fromJson,
      Map<String, dynamic> params);
}

abstract class IGetPaginationFilterDatasource<T> {
  Future<List<T>> getFilterPaginated(
    String path,
    List<T> Function(String) fromJson,
    Map<String, dynamic> params,
    String text,
  );
}
