import 'package:flutter/material.dart';
import 'package:wawa_simi/src/pages/info_page.dart';

class Info {
	final String titulo;
	final String descripcion;
	final int tipo;

	Info(this.titulo,this.descripcion, this.tipo);
}
final List<Info> infos = new List<Info>();

class HomePage extends StatefulWidget{
	@override
	_HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
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
				title: Text('WawaSimi'),
				centerTitle: true,
				backgroundColor: Colors.indigo,
				actions: [
					IconButton(
						icon: Icon(Icons.info_outline),
						onPressed: () => Navigator.push(
								context, MaterialPageRoute(builder: (context) => InfoPage(info: infos[currentindex]))
						),
					)
				],
			),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						IconButton(icon: Icon(Icons.add_box_rounded), onPressed:()  => null, iconSize: 50),
						Text(currentindex.toString()),
					],
				),
			),
			bottomNavigationBar: BottomNavigationBar(
				onTap: (int i) { currentindex = i; setState(() {}); },
				currentIndex: currentindex,
				elevation: 0,
				selectedItemColor: Colors.indigo,
				items: <BottomNavigationBarItem>[
					_navigationBarItem('Nivel de Lenguaje', Icons.account_tree_rounded),
					_navigationBarItem('Procesos Fonológicos', Icons.phone)
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
	infos.add(Info('Nivel de Desarrollo de Lenguaje',
      'Para poder utilizar esta herramienta, haga click en el botón presente en el centro de la pantalla,'
      ' luego se le pediran algunos datos del infante para permitir al sistema  clasificar el nivel de desarrollo de lenguaje del mismo.',
      0));
	infos.add(Info('Procesos Fonológicos',
      'Para poder utilizar esta herramienta, haga click en el botón presente en el centro de la pantalla,'
      ' unas palabras apareceran en la pantalla y se activará el micrófono.',1));
}