import 'package:banco_de_contrasenias/BackBank.dart';
import 'package:banco_de_contrasenias/Login.dart';
import 'package:banco_de_contrasenias/SavePass.dart';
import 'package:banco_de_contrasenias/VerPass.dart';
import 'package:flutter/material.dart';


class FirstScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final buttonSavePass = new InkWell(

      child: new Container(

        margin: new EdgeInsets.only(
            top: 30.0,
            left: 20.0,
            right: 20.0
        ),

        height: 50.0,
        width: 300.0,
        decoration: new BoxDecoration(
          boxShadow: [new BoxShadow(
              color: Colors.black,
              offset: new Offset(10.0, 10.0),
              blurRadius: 30.0
          )
          ],
          borderRadius: new BorderRadius.circular(30.0),
          color: Colors.lightBlueAccent,

        ),
        child: new Center(
          child: new Text(
              "Guardar Nueva Contraseña",
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,)
          ),
        ),


      ),
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => new SavePass()));
      },

    );

    final buttonSeePass = new InkWell(

      child: new Container(

        margin: new EdgeInsets.only(
            top: 30.0,
            left: 20.0,
            right: 20.0
        ),

        height: 50.0,
        width: 300.0,
        decoration: new BoxDecoration(
          boxShadow: [new BoxShadow(
              color: Colors.black,
              offset: new Offset(10.0, 10.0),
              blurRadius: 30.0
          )
          ],
          borderRadius: new BorderRadius.circular(30.0),
          color: Colors.lightBlueAccent,

        ),
        child: new Center(
          child: new Text(
              "Ver Contraseñas",
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,)
          ),
        ),


      ),
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => new VerPass()));
      },

    );

    return new Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[

            new Column(
                mainAxisSize: MainAxisSize.min,
                children:  <Widget>[
                  IconButton(
                      icon: Icon(Icons.people),
                      onPressed: (){
                        datos.clear();
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => new Login()));
                      }
                  ),
                  Text('Cerrar Sesión'),]
            ),

          ],
        ),

      ),
      appBar: AppBar(
        title: Text("Banco de Contraseñas"),
        automaticallyImplyLeading: false,
      ),
      body: new Stack(
          children: <Widget>[
            new BackBank(),
            new Container(
              alignment: Alignment.centerLeft,
              margin: new EdgeInsets.only(
                  top: 100.0,
                  left: 43.0,
                  bottom: 300.0
              ),
              child: buttonSavePass,
            ),
            new Container(
              alignment: Alignment.centerLeft,
              margin: new EdgeInsets.only(
                  top: 200.0,
                  left: 43.0,
                  bottom: 100.0
              ),
              child: buttonSeePass,
            ),
          ],

      ),
    );
  }


}