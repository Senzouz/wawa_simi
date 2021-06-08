import 'package:flutter/material.dart';

class _Info {
  final String titulo;
  final String descripcion;

  _Info(this.titulo,this.descripcion);
}

final List<_Info> infos = new List<_Info>();

class InfoPP extends StatefulWidget{
  @override
  _InfoPPState createState() => _InfoPPState();
}

class _InfoPPState extends State<InfoPP> {

  int currentindex = 0;

  @override
  void initState() {
    startList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(infos[currentindex].titulo),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(infos[currentindex].descripcion,
                      style: TextStyle(fontSize: 18.0),)
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        onTap: (int i) { currentindex = i; setState(() {}); },
        currentIndex: currentindex,
        elevation: 0,
        selectedItemColor: Colors.indigo,
        items: <BottomNavigationBarItem>[
          _navigationBarItem('Procesos', Icons.phone),
          _navigationBarItem('Estructura', Icons.account_tree_sharp),
          _navigationBarItem('Sustitución', Icons.alt_route_outlined),
          _navigationBarItem('Asimilación', Icons.audiotrack_sharp),
        ],
      ),
    );
  }
}

BottomNavigationBarItem _navigationBarItem(String label,IconData icono){
  return BottomNavigationBarItem(
      icon: Icon(icono),
      label: label
  );
}

void startList(){
  infos.add(_Info('Procesos Fonológicos','Los procesos fonológicos son aquellos patrones que los niños más pequeños usan para simplificar el habla adulta.'
      ' Todos los niños hacen uso de estos procesos mientras se desarrolla su habla y lenguaje.\n'
      "Por ejemplo, los más pequeños pueden decir 'wawa' para pedir agua o decir 'ato' para decir gato."
      " Otros niños pueden omitir el último sonido en las palabras como decir 'so' para sol"));

  infos.add(_Info('Estructura Silabar','Son cambios en los sonidos que causan que los sonidos o sílabas sean reducidos en cantidad, eliminados o repetidos.\n'
      "\n· Omisión de consonantes finales: Es la eliminación de la consonante final o un grupo de consonantes en una sílaba o palabra.\n"
      "\n· Simplificación de grupos de consonantes: Es la eliminación de una o más consonantes de un grupo de consonantes de 2 o 3.\n"
      "\n· Omisión de sílabas débiles : Es la eliminación de una sílaba de una palabra que contiene 2 o más sílabas. La eliminación suele ocurrir en la sílaba no acentuada."));

  infos.add(_Info('Sustitución','Son cambios de los sonidos en los que una clase de sonido reemplaza otra.\n'
      "\n· Semi-consonantización: Ocurre cuando la letra 'r' se pronuncia como 'w' o la 'l' como 'j' por ejemplo.\n"
      "\n· Frontalización: Es la sustitución de sonidos en el frente de la boca, por ejemplo decir 'buante' en vez de 'guante'.\n"
      "\n· Posteriorización: Así como la frontalización, es la sustitución de sonidos en la parte posterior de la boca, por ejemplo decir 'equificio' en vez de 'edificio'.\n"));

  infos.add(_Info('Asimilación','Son cambios en los sonidos en el que un sonido o sílaba influencia otro sonido o sílaba.\n'
      "\n· Idéntica: Es el cambio de una sílaba por una muy similar, por ejemplo decir 'bubanda' en vez de 'bufanda.\n"
      "\n· Labial: Cambio de una sílaba por una que emplee los labios, como ejemplo decir 'platamo' en vez de 'platano'.\n"
      "\n· Dental: Cambio de una sílaba por una que emplee los dientes, por ejemplo decir 'madiposa' en vez de 'mariposa'."));
}