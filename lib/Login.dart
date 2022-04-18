import 'package:banco_de_contrasenias/BackBank.dart';
import 'package:banco_de_contrasenias/CrearCuenta.dart';
import 'package:banco_de_contrasenias/FirstScreen.dart';
import 'package:banco_de_contrasenias/VerPass.dart';
import 'package:banco_de_contrasenias/database_helper.dart';
import 'package:banco_de_contrasenias/database_helper2.dart';
import 'package:banco_de_contrasenias/main.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget{

  final dbHelper = DatabaseHelper.instance;
  final dbHelper2 = DatabaseHelper2.instance;

  final myControllerUsu = TextEditingController();
  final myControllerPass = TextEditingController();

  void dispose(){

    myControllerUsu.dispose();
    myControllerPass.dispose();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    _query();
    _query2();
    datos.clear();
    final crearC = new InkWell(
      child: new Container(
        child: new Text("Crear cuenta",
          style: const TextStyle(
            fontSize: 20.0,
            color: Colors.black,
            fontWeight: FontWeight.normal,
            decoration: TextDecoration.underline,
          ),
        ),
      ),
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => new CrearCuenta()));
      },
    );

    final buttonIS = new InkWell(

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
            "Iniciar Sesión",
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.black,
              fontWeight: FontWeight.w600,)
          ),
        ),


      ),
      onTap: (){
        var flag = true;
        String usu = myControllerUsu.text.toString();
        String pass = myControllerPass.text.toString();
        for (var k in clientes){

          if(k["name"]==usu && k["pass"]==pass){
            flag= false;
            usuarioActual = k["name"];

            showDialog(context: context, builder: (context) {
              Future.delayed(Duration(seconds: 1), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new FirstScreen()));
              });
              return AlertDialog(
                title: new Container(
                  alignment: Alignment.centerLeft,
                  margin: new EdgeInsets.only(
                      top: 100.0,
                      left: 1.0,
                      bottom: 100.0
                  ),
                  child: new Column(
                    children: <Widget>[
                      new Text(
                          "Bienvenido "+usu,
                          style: const TextStyle(
                            fontSize: 30.0,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          )
                      )
                    ],
                  ),
                ),
              );
            });
          }
        }
        if (flag) {
          showDialog(context: context, builder: (context) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.of(context).pop(true);
            });
            return AlertDialog(
              title: new Container(
                alignment: Alignment.centerLeft,
                margin: new EdgeInsets.only(
                    top: 100.0,
                    left: 43.0,
                    bottom: 100.0
                ),
                child: new Column(
                  children: <Widget>[
                    new Text(
                        "Usuario no registrado",
                        style: const TextStyle(
                          fontSize: 30.0,
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                        )
                    )
                  ],
                ),
              ),
            );
          });
        }
      },


    );

    return new Scaffold(
      body: new Stack(
        children: <Widget>[
          new BackBank(),
          new Container(
            alignment: Alignment.center,
            margin: new EdgeInsets.only(
              top: 100.0
            ),
            child: new Column(
              children: <Widget>[
                new Text(
                  "Iniciar Sesión",
                  style: const TextStyle(
                    fontSize: 55.0,
                    color: Colors.black,
                    fontWeight: FontWeight.w600,
                  )
                )
              ],
            ),
          ),
          new Container(
            alignment: Alignment.centerLeft,
            margin: new EdgeInsets.only(
                top: 100.0,
                left: 43.0,
                bottom: 200,
                right: 20.0
            ),
            child: new TextField(
              controller: myControllerUsu,
              //obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Usuario',
              ),
            ),
          ),
          new Container(
            alignment: Alignment.centerLeft,
            margin: new EdgeInsets.only(
                top: 200.0,
                left: 43.0,
                bottom: 100,
                right: 20.0
            ),
            child: new TextField(
              controller: myControllerPass,
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Contraseña',
              ),
            ),
          ),
          new Container(
            alignment: Alignment.centerLeft,
            margin: new EdgeInsets.only(
            top: 310.0,
            left: 43.0
            ),
            child: buttonIS,
          ),
          new Container(
            alignment: Alignment.centerLeft,
            margin: new EdgeInsets.only(
                top: 500.0,
                left: 43.0
            ),
            child: new Row(

              children: <Widget>[
                new Text(
                    "¿No tienes cuenta? ",
                    style: const TextStyle(
                      fontSize: 20.0,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    )
                ),
                crearC,

              ],
            ),
          ),
        ]
      ),

    );
  }
  void _query() async {
    clientes.clear();
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row) => clientes.add(row));
    //allRows.forEach((row) => print(row));
  }
  void _query2() async {
    password.clear();
    final allRows = await dbHelper2.queryAllRows();
    allRows.forEach((row) => password.add(row));
    //allRows.forEach((row) => print(row));
  }

}