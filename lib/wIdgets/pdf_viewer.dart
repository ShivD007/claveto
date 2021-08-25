import 'package:flutter/material.dart';
// import 'package:simple_pdf_viewer/simple_pdf_viewer.dart';
//
import 'package:advance_pdf_viewer/advance_pdf_viewer.dart';

class PdfViewer extends StatefulWidget {
  final String url;
  const PdfViewer({Key key, this.url}) : super(key: key);
  @override
  _PdfViewerState createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  bool _isLoading =true;
  PDFDocument doc ;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
     getPdf();

  }
  getPdf() async {
  doc = await PDFDocument.fromURL(widget.url);
  _isLoading = false;
  setState(() {

  });
}
  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? Container(
        color: Colors.white,
        child: Center(child: CircularProgressIndicator()))
        : PDFViewer(document: doc);
    //   SimplePdfViewerWidget(
    //   initialUrl: widget.url,completeCallback: (_){
    //     print(_);
    // },
    // );
  }
}
