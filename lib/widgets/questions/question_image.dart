import 'package:flutter/material.dart';

// ==========================================
// ودجت صورة السؤال - Question Image Widget
// ==========================================

class QuestionImage extends StatelessWidget {
  final String? imageUrl;
  final double height;
  final BoxFit fit;
  final BorderRadius? borderRadius;

  const QuestionImage({
    super.key,
    this.imageUrl,
    this.height = 200,
    this.fit = BoxFit.cover,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    if (imageUrl == null || imageUrl!.isEmpty) {
      return const SizedBox.shrink();
    }

    return ClipRRect(
      borderRadius: borderRadius ?? BorderRadius.circular(12),
      child: Container(
        height: height,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.grey[200],
          borderRadius: borderRadius ?? BorderRadius.circular(12),
        ),
        child: _buildImage(),
      ),
    );
  }

  Widget _buildImage() {
    // TODO: استخدام cached_network_image للتخزين المؤقت
    // return CachedNetworkImage(
    //   imageUrl: imageUrl!,
    //   fit: fit,
    //   placeholder: (context, url) => _buildPlaceholder(),
    //   errorWidget: (context, url, error) => _buildError(),
    // );

    // مؤقتاً نستخدم Image.network
    return Image.network(
      imageUrl!,
      fit: fit,
      loadingBuilder: (context, child, loadingProgress) {
        if (loadingProgress == null) return child;
        return _buildLoading(loadingProgress);
      },
      errorBuilder: (context, error, stackTrace) {
        return _buildError();
      },
    );
  }

  Widget _buildLoading(ImageChunkEvent loadingProgress) {
    final progress = loadingProgress.expectedTotalBytes != null
        ? loadingProgress.cumulativeBytesLoaded /
            loadingProgress.expectedTotalBytes!
        : null;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CircularProgressIndicator(
            value: progress,
            strokeWidth: 2,
          ),
          const SizedBox(height: 8),
          Text(
            'جاري التحميل...',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildError() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.broken_image,
            size: 48,
            color: Colors.grey[400],
          ),
          const SizedBox(height: 8),
          Text(
            'فشل تحميل الصورة',
            style: TextStyle(
              fontSize: 12,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }
}
