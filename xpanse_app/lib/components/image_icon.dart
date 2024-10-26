import 'package:flutter/material.dart';

class CustomIcon extends StatelessWidget {
  final String imagePath;
  final double size;
  final bool isRounded;
  final bool isAsset; // New parameter to specify if it's an asset
  final VoidCallback? onTap;
  final BoxFit fit;
  final Widget? errorWidget;
  final Widget? loadingWidget;

  const CustomIcon({
    super.key,
    required this.imagePath,
    this.size = 24.0,
    this.isRounded = false,
    this.isAsset = true, // Default to true for asset images
    this.onTap,
    this.fit = BoxFit.cover,
    this.errorWidget,
    this.loadingWidget,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          shape: isRounded ? BoxShape.circle : BoxShape.rectangle,
          borderRadius: isRounded ? null : BorderRadius.circular(8.0),
        ),
        child: isAsset
            ? Image.asset(
                imagePath,
                width: size,
                height: size,
                fit: fit,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: child,
                  );
                },
                errorBuilder: (context, error, stackTrace) {
                  return errorWidget ??
                      Container(
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.error_outline,
                          size: size * 0.5,
                          color: Colors.grey[600],
                        ),
                      );
                },
              )
            : Image.network(
                imagePath,
                width: size,
                height: size,
                fit: fit,
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) {
                  if (wasSynchronouslyLoaded) return child;
                  return AnimatedOpacity(
                    opacity: frame == null ? 0 : 1,
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeOut,
                    child: child,
                  );
                },
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return loadingWidget ??
                      Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded /
                                  loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                },
                errorBuilder: (context, error, stackTrace) {
                  return errorWidget ??
                      Container(
                        color: Colors.grey[300],
                        child: Icon(
                          Icons.error_outline,
                          size: size * 0.5,
                          color: Colors.grey[600],
                        ),
                      );
                },
              ),
      ),
    );
  }
}
