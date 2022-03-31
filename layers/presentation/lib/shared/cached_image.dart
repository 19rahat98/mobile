import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:presentation/src/presentation.dart';

class CachedImage extends CachedNetworkImage {
  CachedImage(
    String url, {
    BoxFit? fit,
    Color? color,
    Key? key,
    Alignment alignment = Alignment.center,
  }) : super(
          imageUrl: url,
          key: key,
          fit: fit,
          color: color,
          alignment: alignment,
          fadeOutDuration: const Duration(milliseconds: 200),
          fadeInDuration: const Duration(milliseconds: 300),
          cacheKey: url,
          errorWidget: (context, url, dynamic error) {
            CachedNetworkImage.evictFromCache(url);

            return Center(
              child: Icon(
                Icons.error_outline,
                color: context.theme.colorScheme.error,
                size: 32,
              ),
            );
          },
        );
}
