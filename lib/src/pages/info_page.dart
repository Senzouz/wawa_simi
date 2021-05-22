import 'package:flutter/material.dart';
import 'package:wawa_simi/src/pages/home_page.dart';
import 'package:wawa_simi/src/utils/utils.dart';

class InfoPage extends StatelessWidget{

  final Info info;
  
  InfoPage({Key key, @required this.info}) : super(key : key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(info.titulo),
        backgroundColor: Colors.indigo,
        /*actions: [
          info.tipo == 1 ? IconButton(
              icon: Icon(Icons.info),
              onPressed:() async{
                launchURL(context,'https://www.diloasist.com/single-post/2017/06/02/qu-c3-a9-son-los-procesos-fonol-c3-b3gicos');})
              : null
        ],*/
      ),
      body: Padding(padding: EdgeInsets.all(16.0), child: Text(info.descripcion,style: TextStyle(fontSize: 18.0))),
    );
  }
  
}