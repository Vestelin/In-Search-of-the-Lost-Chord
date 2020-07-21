abstract class IDataManager<T> {
  void save(T data);
  Future load();
}
