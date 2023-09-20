import 'package:e_commerce_app/data/network/error_handler.dart';
import 'package:e_commerce_app/data/response/responses.dart';

const cacheHomeKey = "CACHE_HOME_KEY";
const cacheHomeinterval = 60 * 1000; // one minute cache in millis

abstract class LocalDataSource {
  Future<HomeResponse> getHomeData();
  Future<void> saveHomeCache(HomeResponse homeResponse);
  void clearCache();
  void removeFromCache(String key);
}

class LocalDataSourceImpl implements LocalDataSource {
  Map<String, CachedItem> cacheMap = {};

  @override
  Future<HomeResponse> getHomeData() async {
    CachedItem? cachItem = cacheMap[cacheHomeKey];
    if (cachItem != null && cachItem.isValid(cacheHomeinterval)) {
      //return the response from cache
      return cachItem.data;
    } else {
      // return an error that cache not valid or there is no data in cache
      throw ErrorHandler.handler(DataSource.CACHE_ERROR);
    }
  }

  @override
  Future<void> saveHomeCache(HomeResponse homeResponse) async {
    cacheMap[cacheHomeKey] = CachedItem(homeResponse);
  }
  
  @override
  void clearCache() {
    cacheMap.clear();
  }
  
  @override
  void removeFromCache(String key) {
    cacheMap.remove(key);
  }
}

class CachedItem {
  CachedItem(this.data);
  dynamic data;
  int cacheTime = DateTime.now().millisecondsSinceEpoch;
}

extension CachedItemExtension on CachedItem {
  bool isValid(int expirationTimeInMillis) {
    int currentTimeInMillis = DateTime.now().millisecondsSinceEpoch;
    bool isValid = currentTimeInMillis - cacheTime <= expirationTimeInMillis;
    return isValid;
  }
}
