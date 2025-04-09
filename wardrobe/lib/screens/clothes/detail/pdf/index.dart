import 'package:flutter/material.dart';
import 'package:wardrobe/modules/api/clothes/model/queries.dart';
import 'package:wardrobe/molecules/m_top_bar.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';

class PdfGeneratedPage extends StatefulWidget {
  const PdfGeneratedPage(
      {Key? key,
      required this.items,
      required this.filePath,
      required this.context})
      : super(key: key);
  final List<UsedHistoryClothesDetailModel?> items;
  final String filePath;
  final String context;

  @override
  StateUsedPageState createState() => StateUsedPageState();
}

class StateUsedPageState extends State<PdfGeneratedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
            preferredSize: const Size.fromHeight(kToolbarHeight),
            child: MoleculesTopBar(
                title: "${widget.context} Document Preview Page")),
        body: PDFView(
          filePath: widget.filePath,
        ));
  }
}
