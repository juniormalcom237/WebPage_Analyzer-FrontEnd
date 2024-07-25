import 'package:flutter/material.dart';
import 'package:web_page_analyzer/Feature/Parser/domain/entities/HtmlParse.dart';

class TableWidget extends StatefulWidget {
  TableWidget({super.key, required this.htmlModel});
  HtmlParse htmlModel;
  @override
  State<TableWidget> createState() => _TableWidgetState();
}

class _TableWidgetState extends State<TableWidget> {
  List<TableRow> tableRows = [];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // widget.htmlModel.linkValidation?.forEach((key, value) {
    //   tableRows.add(TableRow(children: [
    //     Text(key),
    //     Text("$value"),
    //   ]));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(maxWidth: 1024),
      child: Table(
          // textDirection: TextDirection.rtl,
          defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
          border: TableBorder.all(width: 2.0),
          children: [
            TableRow(children: [
              Text("Key", textScaleFactor: 1.5),
              Text("Value", textScaleFactor: 1.5),
            ]),
            TableRow(children: [
              Text("HTML Version", textScaleFactor: 1.5),
              Text(widget.htmlModel.htmlVersion ?? "", textScaleFactor: 1.5),
            ]),
            TableRow(children: [
              Text("Page Title", textScaleFactor: 1.5),
              Text(widget.htmlModel.pageTitle ?? "No Page Title",
                  textScaleFactor: 1.5),
            ]),
            TableRow(
              children: [
                Text("Login", textScaleFactor: 1.5),
                Text("${widget.htmlModel.isLoginForm!}", textScaleFactor: 1.5),
              ],
            ),
            TableRow(
              children: [
                Text("h1", textScaleFactor: 1.5),
                Text("${widget.htmlModel.headings?.h1 ?? 0}",
                    textScaleFactor: 1.5),
              ],
            ),
            TableRow(
              children: [
                Text("h2", textScaleFactor: 1.5),
                Text("${widget.htmlModel.headings?.h2}", textScaleFactor: 1.5),
              ],
            ),
            TableRow(
              children: [
                Text("h3", textScaleFactor: 1.5),
                Text("${widget.htmlModel.headings?.h3 ?? 0}",
                    textScaleFactor: 1.5),
              ],
            ),
            TableRow(
              children: [
                Text("h4", textScaleFactor: 1.5),
                Text("${widget.htmlModel.headings?.h4 ?? 0}",
                    textScaleFactor: 1.5),
              ],
            ),
            TableRow(
              children: [
                Text("h5", textScaleFactor: 1.5),
                Text("${widget.htmlModel.headings?.h5 ?? 0}",
                    textScaleFactor: 1.5),
              ],
            ),
            TableRow(
              children: [
                Text("h6", textScaleFactor: 1.5),
                Text("${widget.htmlModel.headings?.h6 ?? 0}",
                    textScaleFactor: 1.5),
              ],
            ),
            TableRow(
              children: [
                Text("Internal HyperLink", textScaleFactor: 1.5),
                Text("${widget.htmlModel.links?.internal ?? 0}",
                    textScaleFactor: 1.5),
              ],
            ),
            TableRow(
              children: [
                Text("External HyperLink", textScaleFactor: 1.5),
                Text("${widget.htmlModel.links?.external ?? 0}",
                    textScaleFactor: 1.5),
              ],
            ),
            // ...?widget.htmlModel.linkValidation?.entries.map((k, v) {
            //   return TableRow(children: [
            //     Text(k),
            //     Text(v),
            //   ]);
            // }).toList()
            // ...tableRows
            ...?widget.htmlModel.linkValidation?.map((w) {
              return TableRow(children: [
                Text(w.link ?? ""),
                Text("${w.available}"),
              ]);
            }).toList()
          ]),
    );
  }
}
