import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:file_picker/file_picker.dart';

void main() => runApp(XylophoneApp());

class XylophoneApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Xylophone App',
      debugShowCheckedModeBanner: false,
      home: XylophonePage(),
    );
  }
}

class XylophonePage extends StatefulWidget {
  @override
  _XylophonePageState createState() => _XylophonePageState();
}

class _XylophonePageState extends State<XylophonePage> {
  // Initialize _colors with default colors
  int _numBars = 1;
  List<Color> _colors = [    Colors.red,    Colors.orange,    Colors.yellow,    Colors.green,    Colors.teal,    Colors.blue,    Colors.purple,  ];

  // Initialize _notes with default notes
  final List<String> _notes = [    'note1.wav',    'note2.wav',    'note3.wav',    'note4.wav',    'note5.wav',    'note6.wav',    'note7.wav',  ];

  List<String> _musicFiles = [];

  void _selectMusicFiles() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav'],
      allowMultiple: true,
    );

    if (result != null) {
      List<String> paths = result.paths.map((path) => path!).toList();
      setState(() {
        _musicFiles = paths;
      });
    }
  }


  void _playSound(int note) {
    AudioCache player = AudioCache();
    player.play(_notes[note - 1]);
  }

  void _playMusic(String path) {
    AudioPlayer player = AudioPlayer();
    player.play(path, isLocal: true);
  }

  Widget _buildKey(int note) {
    return Expanded(
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: _colors[note - 1],
        ),
        onPressed: () => _playSound(note),
        child: SizedBox(),
      ),
    );
  }

  void _incrementBars() {
    setState(() {
      _numBars++;
    });
  }

  void _decrementBars() {
    setState(() {
      _numBars--;
    });
  }

  void _selectColor(int index, Color color) {
    setState(() {
      _colors[index] = color;
    });
  }

  List<Widget> _buildKeys() {
    List<Widget> keys = [];
    for (int i = 1; i <= _numBars; i++) {
      keys.add(
          Row(
              children: [
              _buildKey(i),
          IconButton(
          onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select Color'),
              content: SingleChildScrollView(
                child: ColorPicker(
                  pickerColor: _colors[i - 1],
                  onColorChanged: (Color color) {
                    _selectColor(i - 1, color);
                  },
                  showLabel: true,
                  pickerAreaHeightPercent: 0.8,
                ),
              ),
            );
          },
        );
      },
    icon: Icon(Icons.color_lens),
    ),
    IconButton(          onPressed: () {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Select Music'),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  ElevatedButton(
                    onPressed: _selectMusicFiles,
                    child: Text('Select Files'),
                  ),
                  SizedBox(height: 16.0),
                  if (_musicFiles.isNotEmpty)
                    ListView.builder(
                      shrinkWrap: true,
                      itemCount: _musicFiles.length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          title: Text(_musicFiles[index]),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                _musicFiles.removeAt(index);
                              });
                            },
                            icon: Icon(Icons.delete),
                          ),
                          onTap: () {
                            _playMusic(_musicFiles[index]);
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          );
        },
      );
    },
      icon: Icon(Icons.music_note),
    ),
              ],
          ),
      );
    }
    return keys;}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Xylophone App'),
        backgroundColor: Colors.black,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ..._buildKeys(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  onPressed: _decrementBars,
                  icon: Icon(Icons.remove),
                ),
                Text(_numBars.toString()),
                IconButton(
                  onPressed: _incrementBars,
                  icon: Icon(Icons.add),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

