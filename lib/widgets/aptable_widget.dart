import 'package:flutter/material.dart';
import 'package:flyfi/notifiers/ap_selection_controller.dart';

class ApTable extends StatefulWidget {
  final List<Map> apList;
  const ApTable({Key? key, required this.apList}) : super(key: key);

  @override
  _ApTableState createState() => _ApTableState();
}

class _ApTableState extends State<ApTable> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Column(children: [
        Table(
          border: TableBorder.all(),
          children: <TableRow>[
            TableRow(children: [
              TableCell(
                child: Container(
                    color: Colors.blue,
                    child: Text(
                      'IP',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white),
                    )),
              ),
              TableCell(
                  child: Container(
                      color: Colors.blue,
                      child: Text(
                        'Modelo',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ))),
              TableCell(
                  child: Container(
                      color: Colors.blue,
                      child: Text(
                        'MAC',
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Colors.white),
                      ))),
            ]),
          ],
        ),
        Table(
          border: TableBorder.all(),
          children: widget.apList.map((item) {
            return TableRow(children: [
              TableCell(
                child: TextButton(
                  onPressed: () {
                    ApSelectionController.instance.changeIP(item['ip']);
                  },
                  child: Text(
                    item['ip'],
                    textAlign: TextAlign.center,
                  ),
                ),
                verticalAlignment: TableCellVerticalAlignment.middle,
              ),
              TableCell(
                child: Text(
                  item['model'],
                  textAlign: TextAlign.center,
                ),
                verticalAlignment: TableCellVerticalAlignment.middle,
              ),
              TableCell(
                child: Text(
                  item['mac'],
                  textAlign: TextAlign.center,
                ),
                verticalAlignment: TableCellVerticalAlignment.middle,
              )
            ]);
          }).toList(),
        )
      ]),
    );
  }
}
