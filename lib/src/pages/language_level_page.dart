import 'package:flutter/material.dart';

class Quiz{
  var questions3 = [
    "¿Emplea correctamente 'es' y 'está' al iniciar una pregunta?",
    '¿Presta atención durante 5 minutos mientras se le lee un cuento?',
    '¿Lleva a cabo una serie de 2 ordenes/acciones que no se relacionan entre sí?',
    '¿Dice su nombre completo cuando se le pide?',
    "Responde a preguntas simples de '¿Cómo?'",
    '¿Emplea los verbos regulares en tiempo pasado? (Por ejemplo salto -> saltaba)',
    '¿Relata experiencias inmediatas?',
    '¿Dice cómo se emplean objetos comunes? (Vasos, lápices de colores, sillas)',
    "¿Expresa acciones futuras empleando 'ir a', 'tener que', 'querer'?",
    "¿Cambia apropiadamente el orden de las palabras para formular preguntas? (Por ejemplo '¿Puedo yo?')",
    '¿Usa la forma imperativa de los verbos cuando pide favores?',
    '¿Cuenta 2 sucesos en el orden que ocurrieron?',
  ];

  var questions4 = [
    '¿Obedece una serie de ordenes de 3 etapas?',
    "¿Demuestra comprensión de los verbos reflexivos y los usa al hablar? (Por ejemplo 'Me...', 'Te...', 'Se...')",
    '¿Puede encontrar un par de objetos/ilustraciones cuando se le pide?',
    '¿Emplea el futuro al hablar?',
    '¿Emplea oraciones compuestas? (Le pegué a la pelota y rodó a la pista)',
    "¿Cuando se le pide, puede encontrar la parte de 'arriba' y la de 'abajo' de los objetos?",
    '¿Emplea el condicional? (Podría, sería, haría)',
    '¿Puede nombrar cosas absurdas en una ilustración?',
    "¿Emplea las palabras 'hermano, hermana, abuelito, abuelita'?",
    '¿Dice la última palabra en analogías opuestas?',
    '¿Relata un cuento conocido sin la ayuda de ilustraciones?',
    '¿En una imagen nombra el objeto que no pertenece a una clase determinada? (un objeto que no sea un animal, etc)',
    '¿Dice si 2 palabras riman o no?',
    '¿Dice oraciones complejas? (Ella quiere que yo entre porque...)',
    "¿Dice si un sonido es 'fuerte' o 'suave'?",
  ];

  var questions5 = [
    '¿Puede señalar algunos, muchos o varios objetos de un conjunto cuando se le pide?',
    '¿Puede decir su dirección?',
    '¿Dice el número de su teléfono?',
    '¿Puede señalar el grupo que tiene más, menos o pocos objetos?',
    '¿Cuenta chistes sencillos?',
    '¿Relata experiencias diarias?',
    "¿Describe ubicación o movimiento? ('A través de...', 'Lejos de...', 'Desde...', 'Hacia...', 'Encima de...')",
    "¿Responde a preguntas de '¿Por qué?' dando una explicación?",
    '¿Pone en orden las partes y relata un cuanto de 3 a 5 partes si se le dan estas desordenadas?',
    '¿Define palabras?',
    "¿Responde acertadamente al pedirle: 'Dime lo opuesto de...'?",
    "¿Responde a preguntas del estilo '¿Qué pasa si...?'?",
    "¿Emplea 'ayer' y 'mañana' de manera correcta?",
    '¿Pregunta el significado de palabras nuevas o que desconoce?',
  ];

  var options = [
    'Iniciado', 'En Proceso', 'Conseguido'
  ];
}

var answers = [];
var answersQualitative = [];
var naiveText = '';
var nquestion = 0;
var quiz = Quiz();
var selection = [];
var chosen = false;
var end = false;

class LanguageLevelPage extends StatefulWidget{

  @override
  _LanguageLevelPageState createState() => _LanguageLevelPageState();
}

class _LanguageLevelPageState extends State<LanguageLevelPage> {

  @override
  void initState() {
    chosen = false;
    end = false;
    naiveText = '';
    answers.clear();
    answersQualitative.clear();
    nquestion = 0;
    super.initState();
  }

  void updateQuestion(int answer){
    setState(() {
      if(nquestion == selection.length - 1) {
        answers.add(answer);
        answersQualitative.add(quiz.options[answer]);
        end = true;

      }
      else{
        answers.add(answer);
        answersQualitative.add(quiz.options[answer]);
        nquestion++;
      }
    });
  }

  void selectQuiz(int election){
    switch(election){
      case 0:
        selection = quiz.questions3;
        break;
      case 1:
        selection = quiz.questions4;
        break;
      case 2:
        selection = quiz.questions5;
        break;
    }
    setState(() =>chosen = true);
  }

  Widget btnSelection(double width, Color color, int age, String ageText){
    return MaterialButton(
        minWidth: width, color: color,
        onPressed: () {
          selectQuiz(age);
        },
        child: Text(ageText,
        style: const TextStyle(color: Colors.white)
        )
    );
  }

  Widget btnAnswer(double width, Color color, int answer){
    return MaterialButton(
        minWidth: width, color: color,
        onPressed: () {
          updateQuestion(answer);
        },
        child: Text(
            quiz.options[answer],
            style: const TextStyle(color: Colors.white)
        )
    );
  }

  Widget btnEnd(double width, Color color){
    return MaterialButton(
      minWidth: width,
      color: color,
      onPressed: () {
        setState(() {
          debugPrint(answers.toString());
          naiveText = answersQualitative.toString();
        });
      },
      child: const Text(
        'Finalizar Prueba',
        style:  TextStyle(color: Colors.white),
      ),
    );
  }

  Widget numQuestion(){
    return Container(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              'Pregunta ${nquestion +1} de ${selection.length}',
              style: const TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }

  Widget question(){
    return Container(
      padding: const EdgeInsets.all(20.0),
      child: Text(
          selection[nquestion],
          style: const TextStyle(fontSize: 18.0)
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Nivel de Lenguaje'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SafeArea(
        child: chosen ? Column(
          children: [
            const Padding(padding: EdgeInsets.all(10.0)),
            numQuestion(),
            const SizedBox(height: 20),
            question(),
            const SizedBox(height: 50),
            end ? Column(
              children: [
                btnEnd(120.0, Colors.blue),
                Text(naiveText)
              ],
            )
            : Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    btnAnswer(120.0, Colors.black12, 0),
                    btnAnswer(120.0, Colors.indigo, 1),
                  ],
                ),
                const SizedBox(height: 20),
                btnAnswer(120.0, Colors.deepPurpleAccent, 2)
              ],
            ),

          ]
        ) : Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const Text(
                  'Elige la edad del niño por favor:',
                  style: TextStyle(fontSize: 18.0)),
              btnSelection(120.0, Colors.indigo, 0, '3 años'),
              btnSelection(120.0, Colors.indigo, 1, '4 años'),
              btnSelection(120.0, Colors.indigo, 2, '5 años')
            ],
          ),
        ),
      ),
    );
  }
}