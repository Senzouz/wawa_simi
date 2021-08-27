import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';

class Words{
var words = [
  'alfombra',
  'auto',
  'bufanda',
  'caperusita',
  'edificio',
  'foca',
  'guante',
  'helicoptero',
  'indio',
  'mariposa',
  'pantalon',
  'platano',
  'plato',
  'telefono',
  'tren'
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

  void updateWord(){
    setState(() {
      if(nword == palabras.words.length - 1) {
        end = true;
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

  @override
  void initState() {
    super.initState();
    nword = 0;
    end = false;
    //deleteFiles();

    FlutterAudioRecorder.hasPermissions.then((hasPermission){
      if(hasPermission) {
        _recordingState = RecordingState.set;
        _recordIcon = Icons.mic;
        _recordText = 'Presione para Grabar';
      }
    });
  }

  @override
  void dispose() {
    _recordingState = RecordingState.unset;
    super.dispose();
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
        child: Column(
          children: [
            const Padding(padding: EdgeInsets.all(10.0)),
            numWord(),
            const SizedBox(height: 20),
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image(
                    image: AssetImage(palabras.images[nword]),
                    height: 250, width: 250),
                const SizedBox(height: 10),
                Text(palabras.words[nword])
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
        ),
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