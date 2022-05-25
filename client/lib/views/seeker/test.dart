import 'package:flutter/material.dart';
import 'package:fmij/utilities/global.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class Pdf extends StatefulWidget {
  final String path;
  Pdf({Key? key, required this.path}) : super(key: key);

  @override
  State<Pdf> createState() => _PdfState();
}

class _PdfState extends State<Pdf> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 3,
        title: const Text("CV"),
      ),
      body: SafeArea(
        child: Center(
          child: SizedBox(
            child: SfPdfViewer.network("$api/${widget.path}"),
          ),
        ),
      ),
    );
  }
}
