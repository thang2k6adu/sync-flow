import 'package:flutter_riverpod/flutter_riverpod.dart';

abstract class BaseAsyncNotifier<T> extends AsyncNotifier<T> {
  /// Concrete class implement để fetch dữ liệu
  Future<T> fetchData();

  @override
  Future<T> build() async {
    try {
      return await fetchData();
    } catch (e) {
      // AsyncNotifier sẽ set state = AsyncError
      throw e;
    }
  }

  /// Manual refresh
  Future<void> refresh() async {
    state = const AsyncLoading();
    try {
      final data = await fetchData();
      state = AsyncData(data);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
}
