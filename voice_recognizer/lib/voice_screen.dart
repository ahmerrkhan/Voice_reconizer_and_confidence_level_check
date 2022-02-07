import 'package:flutter/material.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import 'package:avatar_glow/avatar_glow.dart';
import 'package:highlight_text/highlight_text.dart';

class voiceScreen extends StatefulWidget {
  const voiceScreen({Key? key}) : super(key: key);

  @override
  _voiceScreenState createState() => _voiceScreenState();
}

class _voiceScreenState extends State<voiceScreen> {

  final Map<String,HighlightedWord> _highlights = {
    'flutter' : HighlightedWord(
      onTap: ()=>print("DONE 1"),
      textStyle: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
    ),
    'Ahmer' : HighlightedWord(
      onTap: ()=>print("DONE 1"),
      textStyle: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
    ),
    '' : HighlightedWord(
      onTap: ()=>print("DONE 1"),
      textStyle: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
    ),
    'back' : HighlightedWord(
      onTap: ()=>print("DONE 1"),
      textStyle: const TextStyle(color: Colors.blue,fontWeight: FontWeight.bold),
    ),
  };



  bool _isListening = false;
  String _text = "Press the button and start speaking";
  double _confidence = 1.0;
  stt.SpeechToText? _speech;
  //stt.SpeechToText

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        centerTitle: true,
        title:
            Text('Confidence : ${(_confidence * 100.0).toStringAsFixed(1)}%'),
      ),
      body: _customBody(),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate:_isListening,
       endRadius: 75.0,
        glowColor: Colors.grey,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        child: FloatingActionButton(
          backgroundColor: Colors.redAccent,
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
    );
  }

  SingleChildScrollView _customBody(){
    return  SingleChildScrollView(
      reverse: true,
      padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
      child: TextHighlight(
        text: _text,
        words: _highlights,
        textStyle: const TextStyle(color: Colors.black,fontSize: 32.0,fontWeight: FontWeight.w400),
      ),
    );
  }

  void _listen()async{
    if(!_isListening){
      bool available = await _speech!.initialize(
        onStatus: (val)=>print('on status $val'),
        onError: (val)=>print('on error $val'),
      );
      if(available){
        setState(() {
          _isListening = true;
        });
        _speech!.listen(
          onResult: (val)=>setState(() {
            _text = val.recognizedWords;
            if(val.hasConfidenceRating && val.confidence > 0){
              _confidence = val.confidence;
            }

          }),
        );
      }
    }
    else{
      setState(() {
        _isListening = false;
      });
      _speech!.stop();
    }
  }

}
