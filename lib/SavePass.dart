import 'package:banco_de_contrasenias/BackBank.dart';
import 'package:banco_de_contrasenias/FirstScreen.dart';
import 'package:banco_de_contrasenias/Login.dart';
import 'package:banco_de_contrasenias/VerPass.dart';
import 'package:banco_de_contrasenias/database_helper2.dart';
import 'package:flutter/material.dart';
import 'package:banco_de_contrasenias/main.dart';

class SavePass extends StatelessWidget{

  final dbHelper = DatabaseHelper2.instance;

  final myControllerApp = TextEditingController();
  final myControllerUsu = TextEditingController();
  final myControllerPass = TextEditingController();



  void dispose(){
    myControllerApp.dispose();
    myControllerUsu.dispose();
    myControllerPass.dispose();

  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    final btnGuardar = new InkWell(

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
              "Guardar",
              style: const TextStyle(
                fontSize: 20.0,
                color: Colors.black,
                fontWeight: FontWeight.w600,)
          ),
        ),


      ),
      onTap: (){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => new FirstScreen())
        );
        showDialog(context: context, builder: (context) {
          Future.delayed(Duration(seconds: 1), () {
            Navigator.of(context).pop(true);
          });
          String app = myControllerApp.text.toString();
          String usu = myControllerUsu.text.toString();
          String pass = myControllerPass.text.toString();
          for (var i in password){
            var bool1 = (i["aplicacion"]==app);
            var bool2 = (i["usuario"]==usu);
            var bool3 = (i["contraseña"]==pass);
            if ((bool1 && bool2) == false){
              continue;
            }else{
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
                          "Conjunto de Aplicacion, Usuario ya existente",
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
          if(usu == "" || app == "" || pass == "" ){
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
          }else{
            _insert(usuarioActual, usu, pass, app);
            _query();
          }

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
                      "Guardado Exitosamente",
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
      },

    );


    return new Scaffold(
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 4.0,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            new Column(
                mainAxisSize: MainAxisSize.min,
                children:  <Widget>[
                  IconButton(
                      icon: Icon(Icons.home),
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => new FirstScreen()));
                      }
                  ),
                  Text('Home'),]
            ),
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
            new Column(
                mainAxisSize: MainAxisSize.min,
                children:  <Widget>[
                  IconButton(
                      icon: Icon(Icons.folder_special_outlined),
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => new VerPass()));
                      }
                  ),
                  Text('Ver Contraseñas'),]
            ),


          ],
        ),

      ),
      appBar: AppBar(
        title: Text("Guardar Nueva Contraseña"),
        automaticallyImplyLeading: false,
      ),
      body: new Stack(
          children: <Widget>[
            new BackBank(),
            new Container(
              alignment: Alignment.centerLeft,
              margin: new EdgeInsets.only(
                  top: 0.0,
                  left: 43.0,
                  bottom: 300,
                  right: 20.0
              ),
              child: new TextField(
                  controller: myControllerApp,
                //obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'Plataforma o Aplicación',
                ),
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
                  top: 350.0,
                  left: 43.0
              ),
              child: btnGuardar,
            ),

          ]
      ),
    );
  }
  void _insert(String name, String usu, String pass, String app) async {
    Map<String, dynamic> row = {
      DatabaseHelper2.columnName : name,
      DatabaseHelper2.columnApp : app,
      DatabaseHelper2.columnUsu : usu,
      DatabaseHelper2.columnPass  : pass,

    };
    final id = await dbHelper.insert(row);

    //clientes.add(row);
  }
  void _query() async {
    password.clear();
    final allRows = await dbHelper.queryAllRows();
    allRows.forEach((row) => password.add(row));
    //allRows.forEach((row) => print(row));
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
      DatabaseHelper2.columnId   : 1,
      DatabaseHelper2.columnName : 'Mary',
      DatabaseHelper2.columnPass  : 32
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }

}