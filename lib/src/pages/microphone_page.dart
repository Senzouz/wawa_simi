import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'package:http/http.dart' as http;

class Words{
var words = [
  'Alfombra',
  'Auto',
  'Bufanda',
  'Caperucita',
  'Edificio',
  'Foca',
  'Guante',
  'Helicóptero',
  'Indio',
  'Mariposa',
  'Pantalón',
  'Plátano',
  'Plato',
  'Telefono',
  'Tren'
];

var images = [
  'assets/images/alfombra.png',
  'assets/images/auto.png',
  'assets/images/bufanda.png',
  'assets/images/caperusita.png',
  'assets/images/edificio.png',
  'assets/images/foca.png',
  'assets/images/guante.png',
  'assets/images/helicoptero.png',
  'assets/images/indio.png',
  'assets/images/mariposa.png',
  'assets/images/pantalon.png',
  'assets/images/platano.png',
  'assets/images/plato.png',
  'assets/images/telefono.png',
  'assets/images/tren.png'
];
}


var nword = 0;
var end = false;
var type = 0;
var selected = false;
var showResults = false;

class RecorderPage extends StatefulWidget{

  @override
  _RecorderPageState createState() => _RecorderPageState();
}

enum RecordingState{
  unset,
  set,
  recording,
  stopped
}

class _RecorderPageState extends State<RecorderPage>{
  IconData _recordIcon = Icons.mic_none;
  String _recordText = 'Presione para Grabar';
  RecordingState _recordingState = RecordingState.unset;
  var palabras = Words();

  final List<String> wordsMP = <String>[];
  final List<String> pp = <String>[];

  FlutterAudioRecorder audioRecorder;

  Widget numWord(){
    return Container(
      alignment: Alignment.topCenter,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
              'Palabra ${nword +1} de ${palabras.words.length}',
              style: const TextStyle(fontSize: 16.0)),
        ],
      ),
    );
  }

  void updateWord() async{
    setState(() {
      if(nword == palabras.words.length - 1) {
        end = true;
        _predictLanguageLevel();
      }
      else{
        nword++;
      }
    });
  }

  Future<void> deleteFiles() async{
    final directory = await getExternalStorageDirectory();
    final lista = directory.listSync();
    for (final file in lista){
      await file.delete();
    }
  }

  Widget btnSelection(double width, Color color, int age, String ageText){
    return MaterialButton(
        minWidth: width, color: color,
        onPressed: () {
          setState(() {
            type = age;
            selected = true;
          });
        },
        child: Text(ageText,
            style: const TextStyle(color: Colors.white)
        )
    );
  }

  @override
  void initState() {
    super.initState();
    nword = 0;
    end = false;
    deleteFiles();
    type = 0;
    selected = false;
    showResults = false;

    FlutterAudioRecorder.hasPermissions.then((hasPermission){
      if(hasPermission) {
        _recordingState = RecordingState.set;
        _recordIcon = Icons.mic;
        _recordText = 'Presione para Grabar';
      }
    });
  }

  Widget btnEnd(double width, Color color){
    return MaterialButton(
      minWidth: width,
      color: color,
      onPressed: () {
        setState(() {
          _predictLanguageLevel();
          showResults = true;
        });
      },
      child: const Text(
        'Finalizar Prueba',
        style:  TextStyle(color: Colors.white),
      ),
    );
  }

  @override
  void dispose() {
    _recordingState = RecordingState.unset;
    super.dispose();
  }

  Future<void> _predictLanguageLevel() async{
    final appDirec = await getExternalStorageDirectory();
    final fileList = appDirec.listSync();

    const url = 'http://3.82.200.121:5000/phonological';
    final request = http.MultipartRequest('POST',Uri.parse(url));
    var i = 0;
    request.fields['type'] = type.toString();
    for (final File file in fileList){
      request.files.add(
          await http.MultipartFile.fromPath(
              palabras.words[i],
              file.path
          )
      );
      i++;
    }

    http.Response response = await http.Response.fromStream(await request.send());
    if (response.statusCode == 200){
      final Map<String, dynamic> answers = json.decode(response.body);
      for (final entry in answers.entries) {
          wordsMP.add(entry.key.substring(0,entry.key.indexOf('.')));
          pp.add(entry.value);
      }
      setState(() {
        showResults = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Procesos Fonológicos'),
        centerTitle: true,
        backgroundColor: Colors.indigo,
      ),
      body: SafeArea(
        child: selected ? Column(
          children: [
            const Padding(padding: EdgeInsets.all(10.0)),
            numWord(),
            const SizedBox(height: 20),
            !end ? Column(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Image(
                        image: AssetImage(palabras.images[nword]),
                        height: 250, width: 250),
                    const SizedBox(height: 10),
                    Text(
                      palabras.words[nword],
                      style: const TextStyle(fontSize: 25.0)
                    )
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    MaterialButton(
                      onPressed: () async{
                        await _onRecordButtonPressed();
                        setState(() {});
                      },
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: SizedBox(
                        width: 150,
                        height: 150,
                        child: Icon(_recordIcon, size: 50),
                      ),
                    ),
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Padding(
                        child: Text(_recordText),
                        padding: const EdgeInsets.all(8),
                      ),
                    )
                  ],
                )
              ],
            )
            : showResults ? Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(8.0),
                itemCount: wordsMP.length,
                itemBuilder: (BuildContext context, int index){
                  return Container(
                    height: 60.0,
                    margin: const EdgeInsets.all(2.0),
                    child: Center(
                      child: Text('En la palabra ${wordsMP[index]} se encontró'
                          ' un proceso fonológico de tipo ${pp[index]}',
                      style: const TextStyle(fontSize: 18.0)
                      ),
                    ),
                  );
                }
              ),
            )
            : const Center(
              child: CircularProgressIndicator(),
            ),
            const Text(
              'El resultado predicho no es 100% preciso, para una '
                  'opinión más informada, consultar con un especialista',
              style: TextStyle(color: Colors.red),
            )
          ],
        )
        : Container(
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
        )
      )
    );
  }

  Future<void> _onRecordButtonPressed() async{
    switch(_recordingState){
      case RecordingState.set:
      case RecordingState.stopped:
        await _recordVoice();
        break;
      case RecordingState.recording:
        _stopRecording();
        _recordingState = RecordingState.stopped;
        _recordIcon = Icons.fiber_manual_record;
        _recordText = 'Grabar de nuevo';
        break;
      case RecordingState.unset:
        _recordIcon = Icons.warning;
        _recordText = 'Por favor conceda permisos para acceder al micrófono';
    }
  }

  void _initRecorder() async{
    final directory = await getExternalStorageDirectory();
    var filePath = '${directory.path}/${palabras.words[nword]}.wav';
    audioRecorder = FlutterAudioRecorder(filePath,audioFormat: AudioFormat.WAV);
    await audioRecorder.initialized;
  }

  void _startRecording() async{
    await audioRecorder.start();
  }

  void _stopRecording() async{
    updateWord();
    await audioRecorder.stop();
  }

  Future<void> _recordVoice() async{
    final hasPermission = await FlutterAudioRecorder.hasPermissions;
    if (hasPermission ?? false){
      await _initRecorder();
      await _startRecording();
      _recordingState = RecordingState.recording;
      _recordIcon = Icons.stop;
      _recordText = 'Grabando';
    } else{
      _recordIcon = Icons.warning;
      _recordText = 'Por favor conceda permisos para acceder al micrófono';
    }
  }
}