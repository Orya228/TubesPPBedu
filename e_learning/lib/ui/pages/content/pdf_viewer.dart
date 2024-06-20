import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:e_learning/styles/colors.dart';
import 'package:e_learning/styles/text_style.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';

class MyPdfViewer extends StatefulWidget {
  // const MyPdfViewer({super.key});
  final String? judul;
  final String? dir;
  final bool open;
  final String? sampul;
  final String? jenis;
  final String? buku;
  final String? docId;
  final int? halaman;

  // MyPdfViewer({required this.judul});
  const MyPdfViewer(
      {Key? key,
      this.judul,
      required this.dir,
      required this.open,
      this.sampul,
      this.jenis,
      this.buku,
      this.docId,
      this.halaman})
      : super(key: key);

  @override
  State<MyPdfViewer> createState() => _MyPdfViewerState();
}

class _MyPdfViewerState extends State<MyPdfViewer> {
  final user = FirebaseAuth.instance.currentUser?.uid;
  late PdfViewerController _pdfViewerController;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void initState() {
    super.initState();
    _pdfViewerController = PdfViewerController();

    // Add a delay to ensure the PDF is loaded before jumping to the page
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (widget.open) {
        _pdfViewerController.jumpToPage(widget.halaman!);
      } else {
        _pdfViewerController.jumpToPage(1);
      }
    });
  }

  Future<void> _sendPageInfoToFirestore() async {
    int currentPage = _pdfViewerController.pageNumber;
    try {
      if (widget.open) {
        await _firestore.collection('pdf_views').doc(widget.docId).update({
          'user': user,
          'page_number': currentPage,
          'directory': widget.dir,
          'sampul': widget.sampul,
          'jenis': widget.jenis,
          'judul': widget.buku,
          'timestamp': FieldValue.serverTimestamp(),
        });
      } else {
        await _firestore.collection('pdf_views').add({
          'user': user,
          'page_number': currentPage,
          'directory': widget.dir,
          'sampul': widget.sampul,
          'jenis': widget.jenis,
          'judul': widget.buku,
          'timestamp': FieldValue.serverTimestamp(),
        });
      }
    } catch (e) {
      print('Error sending data to Firestore: $e');
    }
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
          onTap: () async {
            await _sendPageInfoToFirestore();
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
