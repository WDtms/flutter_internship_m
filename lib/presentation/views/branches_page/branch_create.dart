import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/presentation/constants/my_themes_colors.dart';
import 'package:flutter_internship_v2/presentation/views/all_tasks_page/selected_circle.dart';


class CreateBranchForm extends StatefulWidget {

  final Function(String branchName, Map<Color, Color> theme) createBranch;

  CreateBranchForm({this.createBranch});

  @override
  _CreateBranchFormState createState() => _CreateBranchFormState();
}

class _CreateBranchFormState extends State<CreateBranchForm> {

  final _key = GlobalKey<FormState>();
  int _selectedTheme;

  @override
  void initState() {
    _selectedTheme = 0;
    super.initState();
  }

  _setSelectedTheme(int value) {
    setState(() {
      _selectedTheme = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: SimpleDialog(
        contentPadding: EdgeInsets.all(16),
        children: <Widget>[
          Text(
            'Создать список',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Color(0xff424242),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: TextFormField(
              key: ValueKey('create branch TextField'),
              onSaved: (String value) {
                widget.createBranch(value, themes[_selectedTheme]);
              },
              validator: (value) {
                if(value.length > 10){
                  return 'Превышена допустимая длина названия ветки задач';
                }
                return null;
              },
              decoration: InputDecoration(
                hintText: "Введите название списка",
                border: InputBorder.none,
                hintStyle: TextStyle(
                  fontSize: 18
                )
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 12),
            child: SizedBox(
              height: 70,
              width: MediaQuery.of(context).size.width,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 6,
                itemBuilder: (context, index) {
                  return themeButton(index);
                },
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                SimpleDialogOption(
                  child: Text(
                    'ОТМЕНА',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff424242),
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
                SimpleDialogOption(
                  child: Text(
                    'СОЗДАТЬ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xff424242),
                    ),
                  ),
                  onPressed: () {
                    if (_key.currentState.validate()){
                      _key.currentState.save();
                      Navigator.of(context).pop();
                    }
                  },
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget themeButton(int index) {
    return SizedBox(
      key: ValueKey('Index: $index'),
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Container(
          height: 30,
          width: 30,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: themes[index].keys.toList().first,
          ),
          child: Theme(
            data: ThemeData(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
            ),
            child: InkWell(
              onTap: () {
                _setSelectedTheme(index);
              },
              child: Builder(
                builder: (context) {
                  if (_selectedTheme == index){
                    return SelectedCircle(
                      radius: 30/4,
                    );
                  }
                  return SelectedCircle(
                    radius: 0.0,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
