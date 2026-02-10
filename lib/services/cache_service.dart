// ==========================================
// خدمة التخزين المؤقت - Cache Service
// ==========================================
// TODO: سيتم استخدامها مع cached_network_image

class CacheService {
  static final CacheService _instance = CacheService._internal();
  factory CacheService() => _instance;
  CacheService._internal();

  // تخزين مؤقت في الذاكرة
  final Map<String, dynamic> _memoryCache = {};
  final Map<String, DateTime> _cacheTimestamps = {};

  // مدة صلاحية التخزين المؤقت (بالدقائق)
  static const int defaultCacheDuration = 30;

  // ==========================================
  // عمليات التخزين المؤقت في الذاكرة
  // ==========================================

  // تخزين قيمة
  void set<T>(String key, T value, {int? durationMinutes}) {
    _memoryCache[key] = value;
    _cacheTimestamps[key] = DateTime.now();
  }

  // استرجاع قيمة
  T? get<T>(String key, {int durationMinutes = defaultCacheDuration}) {
    if (!_memoryCache.containsKey(key)) return null;

    final timestamp = _cacheTimestamps[key];
    if (timestamp == null) return null;

    // التحقق من انتهاء الصلاحية
    final now = DateTime.now();
    if (now.difference(timestamp).inMinutes > durationMinutes) {
      remove(key);
      return null;
    }

    return _memoryCache[key] as T?;
  }

  // التحقق من وجود قيمة
  bool has(String key) {
    return _memoryCache.containsKey(key);
  }

  // حذف قيمة
  void remove(String key) {
    _memoryCache.remove(key);
    _cacheTimestamps.remove(key);
  }

  // مسح كل التخزين المؤقت
  void clear() {
    _memoryCache.clear();
    _cacheTimestamps.clear();
  }

  // ==========================================
  // تخزين الصور المؤقت
  // ==========================================

  // مسح ذاكرة الصور المؤقتة
  Future<void> clearImageCache() async {
    // TODO: استخدام cached_network_image
    // await CachedNetworkImage.evictFromCache(url);
    // أو
    // DefaultCacheManager().emptyCache();
  }

  // الحصول على حجم التخزين المؤقت
  Future<int> getCacheSize() async {
    // TODO: حساب حجم التخزين المؤقت
    return 0;
  }

  // ==========================================
  // تخزين البيانات المؤقت
  // ==========================================

  // تخزين بيانات المواد
  void cacheSubjectsData(List<dynamic> subjects) {
    set('subjects_data', subjects, durationMinutes: 60);
  }

  // استرجاع بيانات المواد
  List<dynamic>? getCachedSubjectsData() {
    return get<List<dynamic>>('subjects_data', durationMinutes: 60);
  }

  // تخزين بيانات لوحة المتصدرين
  void cacheLeaderboardData(String type, List<dynamic> entries) {
    set('leaderboard_$type', entries, durationMinutes: 5);
  }

  // استرجاع بيانات لوحة المتصدرين
  List<dynamic>? getCachedLeaderboardData(String type) {
    return get<List<dynamic>>('leaderboard_$type', durationMinutes: 5);
  }
}
