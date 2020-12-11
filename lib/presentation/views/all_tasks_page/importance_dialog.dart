import 'package:flutter/material.dart';

class ImportanceDialog extends StatefulWidget {

  final int importance;
  final Function(int value) changeImportance;

  ImportanceDialog({this.importance, this.changeImportance});

  @override
  _ImportanceDialogState createState() => _ImportanceDialogState();
}

class _ImportanceDialogState extends State<ImportanceDialog> {


  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        for (int i = 0; i<3; i++)
          _displayImportanceButton(i),
      ],
    );
  }

  Widget _displayImportanceButton(int indexButton) {
    return InkWell(
      onTap: () {
        widget.changeImportance(indexButton);
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(24),
          color: _displaySelectedColor(indexButton),
            border: Border.all(color: Colors.black12)
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
          child: Builder(
            builder: (_) {
              if (indexButton == 0)
                return Text(
                    'Не горит',
                    style: TextStyle(
                      fontSize: 15,
                      color: _textColor(indexButton),
                    )
                );
              else if (indexButton == 1)
                return Text(
                    'Важно',
                    style: TextStyle(
                      fontSize: 15,
                      color: _textColor(indexButton),
                    )
                );
              return Text(
                  'Очень Важно',
                  style: TextStyle(
                    fontSize: 15,
                    color: _textColor(indexButton),
                  )
              );
            },
          ),
        ),
      ),
    );
  }

  Color _displaySelectedColor(int indexButton) {
    if (indexButton == widget.importance){
      if (indexButton == 0)
        return Colors.green;
      if (indexButton == 1)
        return Colors.orange;
      if (indexButton == 2)
        return Colors.red;
    }
    return Colors.transparent;
  }

  Color _textColor(int indexButton) {
    if (indexButton == widget.importance)
      return Colors.white;
    return Colors.black87;
  }
}
