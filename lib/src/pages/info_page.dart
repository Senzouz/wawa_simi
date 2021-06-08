import 'package:flutter/material.dart';
import 'package:wawa_simi/src/pages/home_page.dart';
import 'package:wawa_simi/src/pages/pp_info_page.dart';

class InfoPage extends StatelessWidget{

  final Info info;
  
  InfoPage({Key key, @required this.info}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info.titulo),
        backgroundColor: Colors.indigo,
        actions: [
          info.tipo == 1 ? IconButton(
              icon: Icon(Icons.info),
              onPressed:() => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => InfoPP())))
              : Container()
        ],
      ),
      body: Padding(padding: EdgeInsets.all(16.0), child: Text(info.descripcion,style: TextStyle(fontSize: 18.0))),
    );
  }
}