import 'package:flutter/material.dart';

class ImageAppBarConstants {
  static final Key titleImage = Key("imgTitle");
}

class ImageAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
        toolbarHeight: 80,
        automaticallyImplyLeading: false,
        title: Container(
            padding: EdgeInsets.only(top: 0, right: 20),
            alignment: Alignment.centerRight,
            child: Image.asset(
                "lib/infrastructure/presentation/resources/RoamABZ.png",
                fit: BoxFit.contain,
                height: 52)),
        flexibleSpace: Center(
          key: ImageAppBarConstants.titleImage,
          child: Container(
            height: 350,
            child: Image.asset(
              'lib/infrastructure/presentation/resources/titleImage.jpg',
              fit: BoxFit.cover,
            ),
          ),

          // Image.asset(
          //     "lib/infrastructure/presentation/resources/RoamABZ.png")
        ));
  }
}
