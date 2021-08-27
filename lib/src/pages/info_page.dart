import 'package:flutter/material.dart';
import 'package:wawa_simi/src/pages/home_page.dart';
import 'package:wawa_simi/src/pages/pp_info_page.dart';

class InfoPage extends StatelessWidget{

  InfoPage({Key key, @required this.info}) : super(key : key);

  final Info info;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info.titulo),
        backgroundColor: Colors.indigo,
        actions: [
          info.tipo == 1 ? IconButton(
              icon: const Icon(Icons.info),
              onPressed:() => Navigator.push(
                  context, MaterialPageRoute(builder: (context) => InfoPP())))
              : Container()
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(info.descripcion,style: const TextStyle(fontSize: 18.0))),
    );
  }
}