import 'package:flutter/material.dart';
import 'package:flutter_quill/flutter_quill.dart' as q;
import 'package:snote/utils/logger_util.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const TextEditor(),
    );
  }
}

class TextEditor extends StatefulWidget {
  const TextEditor({super.key});

  @override
  State<TextEditor> createState() => TextEditorState();
}

class TextEditorState extends State<TextEditor> {
  final q.QuillController _quillController = q.QuillController.basic();
  bool editMode = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Test Quill'),
        actions: [
          GestureDetector(
            onTap: () {
              logger.i('save icon diklik');
            },
            child: const Icon(Icons.save),
          ),
          const SizedBox(width: 20),
          GestureDetector(
            onTap: () {
              setState(() {
                editMode = !editMode;
              });
            },
            child: editMode ? const Icon(Icons.edit) : const Icon(Icons.remove_red_eye),
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: Column(
        children: [
          q.QuillToolbar.basic(controller: _quillController),
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(9),
                border: Border.all(
                  color: editMode ? Colors.black12 : Colors.blue,
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 10),
              margin: const EdgeInsets.all(10),
              child: q.QuillEditor.basic(
                controller: _quillController,
                readOnly: editMode,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
