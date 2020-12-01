import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';

class ImageDisplay extends StatelessWidget {

  final String photoURL;
  final Function(String filePath) addImage;
  final Color iconColor;

  ImageDisplay({this.photoURL, this.addImage, this.iconColor});

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      placeholder: (context, url) {
        return Icon(
          Icons.file_download,
          size: MediaQuery.of(context).size.height/8,
          color: iconColor.withOpacity(0.5),
        );
      },
      errorWidget: (context, url, error) {
        return Icon(
          Icons.error,
          size: MediaQuery.of(context).size.height/8,
          color: iconColor.withOpacity(0.5),
        );
      },
      imageUrl: photoURL,
      imageBuilder: (context, imageProvider) => InkWell(
        child: Image(
          image: imageProvider,
          fit: BoxFit.cover,
        ),
        onTap: () async {
          final file = await DefaultCacheManager().getSingleFile(photoURL);
          String filePath = file.path;
          addImage(filePath);
        },
      ),
    );
  }
}
