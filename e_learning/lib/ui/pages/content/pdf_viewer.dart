import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MyPdfViewer extends StatefulWidget {
  // const MyPdfViewer({super.key});
  final String? judul;
  final String? dir;
  final bool open;

  // MyPdfViewer({required this.judul});
  const MyPdfViewer(
      {Key? key, this.judul, required this.dir, required this.open})
      : super(key: key);

  @override
  State<MyPdfViewer> createState() => _MyPdfViewerState();
}

class _MyPdfViewerState extends State<MyPdfViewer> {
  late PdfViewerController _pdfViewerController;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();

    // Add a delay to ensure the PDF is loaded before jumping to the page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.open) {
        _pdfViewerController.jumpToPage(2);
      } else {
        _pdfViewerController.jumpToPage(1);
      }
    });
  }

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
      body: SfPdfViewer.asset(
        '${widget.dir}',
        controller: _pdfViewerController,
      ),
      // body: SfPdfViewer.asset('${widget.dir}'),
      // body: SfPdfViewer.asset('assets/buku/kelas_1-pkn.pdf'),
    );
  }
}
