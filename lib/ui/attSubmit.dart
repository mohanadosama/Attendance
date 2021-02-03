import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class attSubmit extends StatefulWidget {
  _attSubmit createState() => _attSubmit();
}

class _attSubmit extends State<attSubmit> {
  @override
  Widget build(BuildContext context) {

    final background = Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.5, 0.5],
              colors: [Colors.brown[50], Colors.white])),
    );

    final subCircle = Center(
      child: Container(
        height: 300.0,
        width: 300.0,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.white,
          border: Border.all(color: Theme.of(context).primaryColor),
        ),
        child: Stack(
          children: <Widget>[
            Container(
              // child: Column(
              //   children: [
              //     Text(
              //       'الساعةالآن',
              //       style: TextStyle(fontSize: 12, color: Colors.black12),
              //     ),
              //     Text(
              //       '12:03',
              //       style: TextStyle(fontSize: 16, color: Colors.black12),
              //     ),
              //   ],
              // ),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
              ),
            ),
            ClipRect(
              child: Align(
                alignment: Alignment.bottomCenter,
                heightFactor: 0.5,
                child: Container(
                  decoration: BoxDecoration(
                    color: Theme.of(context).primaryColor,
                    shape: BoxShape.circle,
                  ),
                  // child: Column(
                  //   children: [
                  //     Icon(
                  //       Icons.camera_alt,
                  //       color: Colors.white,
                  //     ),
                  //   ],
                  // ),
                ),
              ),
            ),
          ],
        ),
      ),
    );

    //image picker
    //geo-location
    //submit both to firestore

    return Scaffold(
        body: Center(
          child: Stack(
            children: [
              background,
              subCircle,
            ],
          ),
        ));
  }
}
