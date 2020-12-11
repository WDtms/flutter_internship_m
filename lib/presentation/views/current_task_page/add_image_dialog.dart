import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/presentation/pages/flickr_page.dart';
import 'package:image_picker/image_picker.dart';

class AddImageDialog extends StatelessWidget {

  final Function(String value) addImage;
  final Map<Color, Color> theme;

  AddImageDialog({this.addImage, this.theme});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Center(child: Text('Добавить картинку')),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: InkWell(
                onTap: () {
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context1) => FlickrPage(
                    theme: theme,
                    addImage: addImage,
                  )));
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: Text(
                          'Интернет',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff424242),
                          ),
                        )
                    ),
                    Icon(
                      Icons.wifi,
                      size: 28,
                      color: Color(0xff424242),
                    )
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: InkWell(
                onTap: () {
                  _openGallery(context);
                },
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                          'Галерея',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff424242),
                          ),
                        )
                    ),
                    Icon(
                      Icons.photo,
                      size: 25,
                      color: Color(0xff424242),
                    ),
                  ],
                ),
              ),
            ),
            Divider(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4),
              child: InkWell(
                onTap: () {
                  _openCamera(context);
                },
                child: Row(
                  children: [
                    Expanded(
                        child: Text(
                          'Сфотографировать самостоятельно',
                          style: TextStyle(
                            fontSize: 18,
                            color: Color(0xff424242),
                          ),
                        )
                    ),
                    Icon(
                        Icons.photo_camera_outlined,
                        size: 28,
                        color: Color(0xff424242)
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _openGallery(BuildContext context) async {
    Navigator.pop(context);
    PickedFile picture = await ImagePicker().getImage(source: ImageSource.gallery);
    if (picture != null) {
      addImage(picture.path);
    }
  }

  void _openCamera(BuildContext context) async {
    Navigator.pop(context);
    PickedFile picture = await ImagePicker().getImage(source: ImageSource.camera);
    if (picture != null) {
      addImage(picture.path);
    }
  }
}
