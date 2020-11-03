import 'package:flutter/cupertino.dart';
import 'package:flutter_internship_v2/bloc/blocs/task_list.dart';

class BlocProvider extends InheritedWidget{
  final TaskListBloc taskListBloc;

  const BlocProvider({
    Key key,
    @required Widget child,
    this.taskListBloc,
  })  : assert(child != null),
        super(key: key, child: child);

  static BlocProvider of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<BlocProvider>();
  }

  @override
  bool updateShouldNotify(BlocProvider old) {
    return true;
  }

}