import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

/// Service to extract dominant colors from background images
/// Uses caching to avoid reprocessing the same images
class ColorExtractionService {
  // Singleton pattern for efficiency
  static final ColorExtractionService _instance = ColorExtractionService._internal();
  factory ColorExtractionService() => _instance;
  ColorExtractionService._internal();

  // Cache extracted palettes by image path
  final Map<String, ExtractedColors> _colorCache = {};

  /// Extract colors from an asset image
  /// Returns cached result if available
  Future<ExtractedColors> extractColorsFromAsset(String assetPath) async {
    // Return cached colors if available
    if (_colorCache.containsKey(assetPath)) {
      return _colorCache[assetPath]!;
    }

    try {
      // Load image and generate palette
      final imageProvider = AssetImage(assetPath);
      final paletteGenerator = await PaletteGenerator.fromImageProvider(
        imageProvider,
        size: const Size(100, 100), // Small size for faster processing
        maximumColorCount: 8,
      );

      // Extract colors from palette
      final colors = ExtractedColors(
        primary: paletteGenerator.dominantColor?.color ?? const Color(0xFF2A5A7B),
        secondary: paletteGenerator.vibrantColor?.color ??
                   paletteGenerator.mutedColor?.color ??
                   const Color(0xFF1E4A63),
        accent: paletteGenerator.lightVibrantColor?.color ??
                paletteGenerator.lightMutedColor?.color ??
                const Color(0xFF4A8AAB),
        dark: paletteGenerator.darkVibrantColor?.color ??
              paletteGenerator.darkMutedColor?.color ??
              const Color(0xFF1A3A4A),
        light: paletteGenerator.lightMutedColor?.color ??
               paletteGenerator.lightVibrantColor?.color ??
               const Color(0xFF6AABCC),
        muted: paletteGenerator.mutedColor?.color ?? const Color(0xFF3A7A9B),
      );

      // Cache the result
      _colorCache[assetPath] = colors;
      return colors;
    } catch (e) {
      // Return default colors on error
      debugPrint('ColorExtractionService: Error extracting colors from $assetPath: $e');
      return ExtractedColors.defaultColors();
    }
  }

  /// Get colors for a subject based on its background image
  /// Falls back to default colors if no background or extraction fails
  Future<ExtractedColors> getColorsForSubject({
    String? backgroundImage,
    Color? fallbackColor,
  }) async {
    if (backgroundImage != null && backgroundImage.isNotEmpty) {
      return extractColorsFromAsset(backgroundImage);
    }

    // Return colors based on fallback color
    if (fallbackColor != null) {
      return ExtractedColors.fromBaseColor(fallbackColor);
    }

    return ExtractedColors.defaultColors();
  }

  /// Clear the cache (useful for memory management)
  void clearCache() {
    _colorCache.clear();
  }

  /// Remove a specific image from cache
  void removeFromCache(String assetPath) {
    _colorCache.remove(assetPath);
  }
}

/// Holds extracted color palette for UI theming
class ExtractedColors {
  final Color primary;
  final Color secondary;
  final Color accent;
  final Color dark;
  final Color light;
  final Color muted;

  const ExtractedColors({
    required this.primary,
    required this.secondary,
    required this.accent,
    required this.dark,
    required this.light,
    required this.muted,
  });

  /// Default metallic blue colors
  factory ExtractedColors.defaultColors() {
    return const ExtractedColors(
      primary: Color(0xFF2A5A7B),
      secondary: Color(0xFF1E4A63),
      accent: Color(0xFF4A8AAB),
      dark: Color(0xFF1A3A4A),
      light: Color(0xFF6AABCC),
      muted: Color(0xFF3A7A9B),
    );
  }

  /// Generate colors from a base color
  factory ExtractedColors.fromBaseColor(Color baseColor) {
    final hsl = HSLColor.fromColor(baseColor);

    return ExtractedColors(
      primary: baseColor,
      secondary: hsl.withLightness((hsl.lightness - 0.1).clamp(0.0, 1.0)).toColor(),
      accent: hsl.withLightness((hsl.lightness + 0.2).clamp(0.0, 1.0)).toColor(),
      dark: hsl.withLightness((hsl.lightness - 0.2).clamp(0.0, 1.0)).toColor(),
      light: hsl.withLightness((hsl.lightness + 0.3).clamp(0.0, 1.0)).toColor(),
      muted: hsl.withSaturation((hsl.saturation - 0.2).clamp(0.0, 1.0)).toColor(),
    );
  }

  /// Get frame colors for metallic UI
  Color get framePrimary => primary;
  Color get frameSecondary => secondary;
  Color get frameBorder => accent;

  /// Get button colors
  Color get buttonNormal => dark;
  Color get buttonSelected => primary;
  Color get buttonCorrect => const Color(0xFF2E7D32);
  Color get buttonIncorrect => const Color(0xFFC62828);

  /// Get text colors
  Color get textOnDark => Colors.white;
  Color get textOnLight => dark;
}
