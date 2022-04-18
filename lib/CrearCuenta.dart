import 'package:banco_de_contrasenias/BackBank.dart';
import 'package:banco_de_contrasenias/Login.dart';
import 'package:banco_de_contrasenias/database_helper.dart';
import 'package:banco_de_contrasenias/main.dart';
import 'package:flutter/material.dart';

class CrearCuenta extends StatelessWidget{

  final dbHelper = DatabaseHelper.instance;

  final myControllerUsu = TextEditingController();
  final myControllerPass = TextEditingController();
  final myControllerPass2 = TextEditingController();

  void dispose(){

    myControllerUsu.dispose();
    myControllerPass.dispose();
    myControllerPass2.dispose();

  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final buttonCancelar = new InkWell(

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
              "Cancelar",
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,)
          ),
        ),


      ),
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => new Login()));
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
              "Aceptar",
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,)
          ),
        ),


      ),
      onTap: (){

        showDialog(context: context, builder: (context) {

          String usu = myControllerUsu.text.toString();
          String pass1 = myControllerPass.text.toString();
          String pass2 = myControllerPass2.text.toString();



          for (var j in clientes){
            if(usu != j["name"]){
              continue;
            }else{
              Future.delayed(Duration(seconds: 1), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Login()));
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
                          "Usuario ya existente",
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
            }
          }

          if (pass1 != pass2) {
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
                        "Las contraseñas no coinciden",
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
          }else{

            if(usu == "" || pass1 == "" || pass2 == "" ){
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
                          "No puede dejar campos vacios",
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
            }else {

              _insert(usu, pass1);
              _query();

              Future.delayed(Duration(seconds: 1), () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Login()));
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
                          "Usuario Guardado Exitosamente",
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
            }
          }
        });
      },

    );

    return new Scaffold(

      appBar: AppBar(
        title: Text("Crear Cuenta"),

      ),
        body: new Stack(
            children: <Widget>[
              new BackBank(),
              new Container(
                alignment: Alignment.centerLeft,
                margin: new EdgeInsets.only(
                    top: 50.0,
                    left: 43.0,
                    bottom: 400,
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
                    top: 150.0,
                    left: 43.0,
                    bottom: 300,
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
                    top: 250.0,
                    left: 43.0,
                    bottom: 200,
                    right: 20.0
                ),
                child: new TextField(
                  controller: myControllerPass2,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirmar Contraseña',
                  ),
                ),
              ),
              new Container(
                alignment: Alignment.centerLeft,
                margin: new EdgeInsets.only(
                    top: 210.0,
                    left: 43.0
                ),
                child: buttonIS,
              ),
              new Container(
                alignment: Alignment.centerLeft,
                margin: new EdgeInsets.only(
                    top: 360.0,
                    left: 43.0
                ),
                child: buttonCancelar,
              ),
            ],
        ),
    );
  }

  void _insert(String usu, String pass1) async {
    Map<String, dynamic> row = {
      DatabaseHelper.columnName : usu,
      DatabaseHelper.columnPass  : pass1
    };
    final id = await dbHelper.insert(row);

    //clientes.add(row);
  }
  void _query() async {
    clientes.clear();
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row) => clientes.add(row));
    allRows.forEach((row) => print(row));
  }
  void _delete() async {
    // Assuming that the number of rows is the id for the last row.
    final id = await dbHelper.queryRowCount();
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
  void _update() async {
    // row to update
    Map<String, dynamic> row = {
      DatabaseHelper.columnId   : 1,
      DatabaseHelper.columnName : 'Mary',
      DatabaseHelper.columnPass  : 32
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

}