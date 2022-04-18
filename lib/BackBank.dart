import 'package:flutter/material.dart';

class BackBank extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Stack(
      children: <Widget>[
        new Gradient(),


      ],
    );
  }
}

class Gradient extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Container(
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
            colors: [
              Colors.white,
              Colors.blue
            ],
          begin: const FractionalOffset(1.0, 0.1),
          end: const FractionalOffset(1.0, 0.9)
        )
      )
    );
  }
  
}