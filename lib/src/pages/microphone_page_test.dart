import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_audio_recorder/flutter_audio_recorder.dart';
import 'dart:io';

class RecorderPage extends StatefulWidget{

  @override
  _RecorderPageState createState() => _RecorderPageState();
}

enum RecordingState{
  Unset,
  Set,
  Recording,
  Stopped
}

class _RecorderPageState extends State<RecorderPage>{
  IconData _recordIcon = Icons.mic_none;
  String _recordText = 'Presione para Grabar';
  RecordingState _recordingState = RecordingState.Unset;

  FlutterAudioRecorder audioRecorder;

  @override
  void initState(){
    super.initState();
    
    FlutterAudioRecorder.hasPermissions.then((hasPermission){
      if(hasPermission){
        _recordingState = RecordingState.Set;
        _recordIcon = Icons.mic;
        _recordText = 'Presione para Grabar';
      }
    });
  }

  @override
  void dispose() {
    _recordingState = RecordingState.Unset;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          alignment: Alignment.center,
          children: [
            MaterialButton(
              onPressed: () async{
                await _onRecordButtonPressed();
                setState(() {});
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(50),
              ),
              child: Container(
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
        ),
      )
    );
  }

  Future<void> _onRecordButtonPressed() async{
    switch(_recordingState){
      case RecordingState.Set:
      case RecordingState.Stopped:
        await _recordVoice();
        break;
      case RecordingState.Recording:
        await _stopRecording();
        _recordingState = RecordingState.Stopped;
        _recordIcon = Icons.fiber_manual_record;
        _recordText = 'Grabar de nuevo';
        break;
      case RecordingState.Unset:
        _recordIcon = Icons.warning;
        _recordText = 'Por favor conceda permisos para acceder al micrófono';
    }
  }

  _initRecorder() async{
    Directory directory = await getExternalStorageDirectory();
    String filePath = directory.path + '/' + DateTime.now().millisecondsSinceEpoch.toString() + '.wav';
    audioRecorder = FlutterAudioRecorder(filePath,audioFormat: AudioFormat.WAV);
    await audioRecorder.initialized;
  }

  _startRecording() async{
    await audioRecorder.start();
  }

  _stopRecording() async{
    await audioRecorder.stop();
  }

  Future<void> _recordVoice() async{
    final hasPermission = await FlutterAudioRecorder.hasPermissions;
    if (hasPermission ?? false){
      await _initRecorder();
      await _startRecording();
      _recordingState = RecordingState.Recording;
      _recordIcon = Icons.stop;
      _recordText = 'Grabando';
    } else{
      _recordIcon = Icons.warning;
      _recordText = 'Por favor conceda permisos para acceder al micrófono';
    }
  }
}