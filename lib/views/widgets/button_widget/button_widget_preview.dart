import 'package:flutter/material.dart';
import 'button_widget.dart'; 

void main() {
  runApp(PreviewWidgetApp());
}

class PreviewWidgetApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Widget Preview'),
        ),
        body: Center(
          // Instantiate your widget for preview
          child: ButtonWidget(
            title: 'Press Me',
            onPressed: () {
              print('Button pressed!');
            },
          ),
        ),
      ),
    );
  }
}
