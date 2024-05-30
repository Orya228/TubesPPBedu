import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MyPdfViewer extends StatefulWidget {
  // const MyPdfViewer({super.key});
  final String? judul;
  final String? lib1;
  final String? lib2;

  // MyPdfViewer({required this.judul});
  const MyPdfViewer({Key? key, this.judul, this.lib1, this.lib2})
      : super(key: key);

  @override
  State<MyPdfViewer> createState() => _MyPdfViewerState();
}

class _MyPdfViewerState extends State<MyPdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Buku ${widget.judul}",
          style: kTitle2,
        ),
        backgroundColor: kPutih,
        leading: GestureDetector(
          child: Image.asset('assets/icons/backbutton.png'),
          onTap: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SfPdfViewer.asset('assets/buku/${widget.lib1}-${widget.lib2}.pdf'),
      // body: SfPdfViewer.asset('assets/buku/kelas_1-pkn.pdf'),
    );
  }
}
