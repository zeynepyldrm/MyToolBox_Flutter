import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_compass/flutter_compass.dart';
import 'package:provider/provider.dart';
import 'package:yapilacaklar_listesi/theming/ThemeModel.dart';
export 'package:yapilacaklar_listesi/compass/Compass.dart';

class Compass extends StatefulWidget {
  const Compass({Key? key}) : super(key: key);

  @override
  _CompassState createState() => _CompassState();
}

class _CompassState extends State<Compass> {
  double _direction = 0;
  @override
  void initState() {
    super.initState();
    FlutterCompass.events!.listen((direction) {
      setState(() {
        _direction = direction.heading!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer(builder: (context, ThemeModel themeNotifier, child) {
      Color bcColor =
          themeNotifier.isDark ? Colors.grey.shade700 : Colors.white;

      return Scaffold(
        appBar: AppBar(
            title: const Text(
              'Pusula',
              style: TextStyle(color: Colors.purple),
            ),
            backgroundColor: bcColor),
        body: Container(
          alignment: Alignment.center,
          color: bcColor,
          child: Transform.rotate(
            angle: (_direction * (pi / 180) * -1),
            child: Image.asset('assets/compass.png'),
          ),
        ),
      );
    });
  }
}
