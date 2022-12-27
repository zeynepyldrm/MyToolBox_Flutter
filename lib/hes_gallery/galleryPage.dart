import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'imageDetailsPage.dart';
export 'package:yapilacaklar_listesi/hes_gallery/galleryPage.dart';

import 'package:yapilacaklar_listesi/theming/ThemeModel.dart';

List<Images> _images = [
  Images(imagePath: 'assets/cizgiler.png'),
  Images(imagePath: 'assets/images.png'),
  Images(imagePath: 'assets/baloon.png'),
  Images(imagePath: 'assets/flash.png'),
  Images(imagePath: 'assets/flower.png'),
  Images(imagePath: 'assets/grape.png'),
  Images(imagePath: 'assets/image2.png'),
  Images(imagePath: 'assets/image3.png'),
  Images(imagePath: 'assets/peoples.png'),
  Images(imagePath: 'assets/sunset.png'),
  Images(imagePath: 'assets/star.png'),
  Images(imagePath: 'assets/moon.png'),
];

class GalleryPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      Color bcColor =
          themeNotifier.isDark ? Colors.grey.shade700 : Colors.white;
      return Scaffold(
        //backgroundColor: Colors.green,
        appBar: AppBar(
            backgroundColor: bcColor,
            title: Text(
              'Galeri',
              style: TextStyle(
                color: themeNotifier.isDark ? Colors.white : Colors.deepPurple,

              ),
            )),
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Expanded(
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 20,
                  ),
                  decoration: BoxDecoration(
                    color: bcColor,
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemBuilder: (context, index) {
                      return RawMaterialButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ImageDetailsPage(
                                imagePath: _images[index].imagePath,
                              ),
                            ),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: AssetImage(_images[index].imagePath),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                    itemCount: _images.length,
                  ),
                ),
              ),
            ],
          ),
        ),
      );
    });
  }
}

class Images {
  final String imagePath;
  Images({required this.imagePath});
}
