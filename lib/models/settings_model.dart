// ==========================================
// نموذج الإعدادات - Settings Model
// ==========================================

class SettingsModel {
  final bool unlockAllLessons;
  final bool soundEnabled;
  final bool notificationsEnabled;
  final String language;
  final bool darkMode;
  final bool hapticFeedback;
  final bool autoPlayAudio;

  const SettingsModel({
    this.unlockAllLessons = false,
    this.soundEnabled = true,
    this.notificationsEnabled = true,
    this.language = 'ar',
    this.darkMode = false,
    this.hapticFeedback = true,
    this.autoPlayAudio = false,
  });

  /// الإعدادات الافتراضية
  factory SettingsModel.defaults() {
    return const SettingsModel();
  }

  SettingsModel copyWith({
    bool? unlockAllLessons,
    bool? soundEnabled,
    bool? notificationsEnabled,
    String? language,
    bool? darkMode,
    bool? hapticFeedback,
    bool? autoPlayAudio,
  }) {
    return SettingsModel(
      unlockAllLessons: unlockAllLessons ?? this.unlockAllLessons,
      soundEnabled: soundEnabled ?? this.soundEnabled,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      language: language ?? this.language,
      darkMode: darkMode ?? this.darkMode,
      hapticFeedback: hapticFeedback ?? this.hapticFeedback,
      autoPlayAudio: autoPlayAudio ?? this.autoPlayAudio,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'unlockAllLessons': unlockAllLessons,
      'soundEnabled': soundEnabled,
      'notificationsEnabled': notificationsEnabled,
      'language': language,
      'darkMode': darkMode,
      'hapticFeedback': hapticFeedback,
      'autoPlayAudio': autoPlayAudio,
    };
  }

  factory SettingsModel.fromJson(Map<String, dynamic> json) {
    return SettingsModel(
      unlockAllLessons: json['unlockAllLessons'] as bool? ?? false,
      soundEnabled: json['soundEnabled'] as bool? ?? true,
      notificationsEnabled: json['notificationsEnabled'] as bool? ?? true,
      language: json['language'] as String? ?? 'ar',
      darkMode: json['darkMode'] as bool? ?? false,
      hapticFeedback: json['hapticFeedback'] as bool? ?? true,
      autoPlayAudio: json['autoPlayAudio'] as bool? ?? false,
    );
  }
}
