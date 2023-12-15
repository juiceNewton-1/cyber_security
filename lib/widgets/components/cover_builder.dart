import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CoverBuilder extends StatelessWidget {
  final double width;
  final double height;
  final double radius;
  final BoxFit? fit;
  const CoverBuilder({
    super.key,
    required this.url,
     this.width = 70,
     this.height = 70,
    this.radius = 12,
    this.fit = BoxFit.cover,
  });

  final String url;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      clipBehavior: Clip.hardEdge,
      child: CachedNetworkImage(
        width: width,
        height: height,
        imageUrl: url,
        placeholder: (context, url) =>Container(
          alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), 
          color: Theme.of(context).colorScheme.surface
        ),
        child: CupertinoActivityIndicator(),
        ) ,
        fit: fit,
        errorWidget: (context, url, error) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(radius), 
          color: Theme.of(context).colorScheme.surface
        ),
        ),
      ),
    );
  }
}