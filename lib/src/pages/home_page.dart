import 'package:flutter/material.dart';
import 'package:wawa_simi/src/pages/info_page.dart';

import 'language_level_page.dart';
import 'microphone_page.dart';

class Info {
	Info(this.titulo,this.descripcion, this.tipo);

	final String titulo;
	final String descripcion;
	final int tipo;

}
final List<Info> infos = <Info>[];

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
				title: const Text('WawaSimi'),
				centerTitle: true,
				backgroundColor: Colors.indigo,
				actions: [
					IconButton(
						icon: const Icon(Icons.info_outline),
						onPressed: () => Navigator.push(
								context, MaterialPageRoute(
								builder: (context) => InfoPage(info: infos[currentindex]))
						),
					)
				],
			),
			body: Center(
				child: Column(
					mainAxisAlignment: MainAxisAlignment.center,
					children: [
						IconButton(icon: const Icon(Icons.add_box_rounded),
								onPressed:()  => currentindex == 1 ? Navigator.push(
										context,
										MaterialPageRoute(builder: (context) => RecorderPage())) :
								Navigator.push(
										context,
										MaterialPageRoute(builder: (context) => LanguageLevelPage())
								),
								iconSize: 50),
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
	infos..add(Info('Desarrollo de Lenguaje',
      'Para poder utilizar esta herramienta,'
			' haga click en el botón presente en el centro de la pantalla,'
      ' luego se le pediran algunos datos del infante para permitir al sistema'
			' clasificar el nivel de desarrollo de lenguaje del mismo.',
      0))
	..add(Info('Procesos Fonológicos',
      'Para poder utilizar esta herramienta,'
			' haga click en el botón presente en el centro de la pantalla,'
      ' unas palabras apareceran en la pantalla y se activará el micrófono.',
			1));
}