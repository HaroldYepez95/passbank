import 'package:banco_de_contrasenias/BackBank.dart';
import 'package:banco_de_contrasenias/FirstScreen.dart';
import 'package:banco_de_contrasenias/Login.dart';
import 'package:banco_de_contrasenias/SavePass.dart';
import 'package:banco_de_contrasenias/database_helper2.dart';
import 'package:flutter/material.dart';
import 'package:banco_de_contrasenias/main.dart';
import 'package:editable/editable.dart';

List datos = [];


class VerPass extends StatefulWidget{



  @override
  _verPassState createState() => _verPassState();

}

class _verPassState extends State<VerPass> {

  final dbHelper = DatabaseHelper2.instance;
  var temp2;

  List headers = [
    {"title":'Aplicación','index':1,'key':'app'},
    {"title":'Usuario','index':2,'key':'usu'},
    {"title":'Contraseña','index':3,'key':'pass'},

  ];

  @override
  Widget build(BuildContext context) {
    /*password.clear();*/
    datos.clear();
    for (var i in password){

      if(i["name"]==usuarioActual && !datos.contains(i) ){
        datos.add(i);
      }
    }
    //print(datos);


    // TODO: implement build

    return Scaffold(
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
                      icon: Icon(Icons.input),
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => new SavePass()));
                      }
                  ),
                  Text('Ingresar Datos'),]
            ),


          ],
        ),

      ),
        appBar: AppBar(
          title: Text("Contraseñas Guardadas"),
          automaticallyImplyLeading: false,
        ),
      body: Editable(
        columns: headers,
        rows: datos,
        showCreateButton: false,
        tdStyle: TextStyle(fontSize: 18),
        thStyle: TextStyle(fontSize: 18),
        showSaveIcon: true,
        columnRatio: 0.27,
        borderColor: Colors.grey.shade300,
        onRowSaved: (value) {
          var flag = true;
          if (value == "no edit") {
            print(value);
          } else {
            var bool1;
            var bool2;
            var bool3;
            for (var i in datos) {
              if (value["app"] == null) {
                bool1 = true;
              }else{
                bool1 = (i["app"] == value["app"]);
              }
              if (value["usu"] == null) {
                bool2 = true;
              }else{
                bool2 = (i["usu"] == value["usu"]);
              }
              if (value["pass"] == null) {
                bool3 = true;
              }else{
                bool3 = false;
              }

              if ((bool1 && bool2 && bool3) == false) {
                continue;
              } else {
                flag=false;
                showDialog(context: context, builder: (context) {
                  Future.delayed(Duration(seconds: 1), () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => new VerPass()));
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
                              "Conjunto de Aplicacion y Usuario ya existente",
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
              Map<String, dynamic> temp = datos.elementAt(value["row"]);

              if (value["app"] != null) {
                //temp["app"] = value["app"];
                temp2 = {"_id": temp.values.first,"name": temp["name"], "app": value["app"],"usu": temp["usu"],"pass": temp["pass"]};

              }

              if (value["usu"] != null) {
                //temp["usu"] = value["usu"];
                temp2 = {"_id": temp["_id"],"name": temp["name"], "app": temp["app"],"usu": value["usu"],"pass": temp["pass"]};
              }
              if (value["pass"] != null) {
                //temp["pass"] = value["pass"];
                temp2 = {"_id": temp["_id"],"name": temp["name"], "app": temp["app"],"usu": temp["usu"],"pass": value["pass"]};
              }



              if (value["pass"] == "" && value["usu"] == "" && value["app"] == ""){
                //datos.remove(temp);
                _delete(temp2["_id"]);
                //password.remove(temp);
                _query();
              }else{

                _update(temp2["_id"], temp2["name"], temp2["usu"], temp2["pass"], temp2["app"]);
                _query();
                //password.remove(temp);
                //datos.remove(temp);
                //password.add(temp);
                //datos.add(temp);
              }
              //print(temp);
              showDialog(context: context, builder: (context) {
                Future.delayed(Duration(seconds: 1), () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => new VerPass()));
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
                            "Guardado",
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

        },
        saveIconSize: 30.0,
        saveIconColor: Colors.blue,



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
    allRows.forEach((row) => print(row));
  }
  void _delete(int id) async {
    // Assuming that the number of rows is the id for the last row.
    final rowsDeleted = await dbHelper.delete(id);
    print('deleted $rowsDeleted row(s): row $id');
  }
  void _update(int id,String name, String usu, String pass, String app) async {
    // row to update

    Map<String, dynamic> row = {
      DatabaseHelper2.columnId: id,
      DatabaseHelper2.columnName: name,
      DatabaseHelper2.columnApp: app,
      DatabaseHelper2.columnUsu: usu,
      DatabaseHelper2.columnPass: pass
    };
    final rowsAffected = await dbHelper.update(row);
    print('updated $rowsAffected row(s)');
  }


}