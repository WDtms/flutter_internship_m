import 'package:flutter/material.dart';
import 'package:flutter_internship_v2/bloc/bloc_provider.dart';
import 'package:flutter_internship_v2/bloc/blocs/task_list.dart';
import 'package:flutter_internship_v2/views/current_task_page/my_card.dart';
import 'package:flutter_internship_v2/views/current_task_page/popup_appbar/popup_appbar.dart';

class CurrentTask1 extends StatefulWidget {

  final appBarColor;
  final backGroundColor;
  final int index;

  CurrentTask1({this.index, this.appBarColor, this.backGroundColor});

  @override
  _CurrentTask1State createState() => _CurrentTask1State();
}

class _CurrentTask1State extends State<CurrentTask1>{

  ScrollController _scrollController;

  @override
  void initState(){
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of(context).taskListBloc;
    return Scaffold(
      backgroundColor: widget.backGroundColor,
      body: Stack(
        children: <Widget>[
          CustomScrollView(
            controller: _scrollController,
            slivers: <Widget>[
              SliverAppBar(
                actions: [
                  PopupMenu1(index: widget.index),
                ],
                expandedHeight: 150,
                floating: false,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  centerTitle: true,
                  title: StreamBuilder(
                    stream: bloc.tasks,
                    builder: (context, snapshot) {
                      if (!snapshot.hasData) {
                        return CircularProgressIndicator();
                      }

                      if (snapshot.data.isEmpty) {
                        return Container();
                      }

                      return Text(
                        snapshot.data[widget.index].title,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 16
                        ),
                      );
                    },
                  ),
                  background: Container(
                    color: widget.appBarColor,
                  ),
                ),
                backgroundColor: widget.appBarColor,
              ),
              SliverList(
                delegate: SliverChildListDelegate(
                    [
                      MyCard1(index: widget.index, backGroundColor: widget.backGroundColor),
                    ]
                ),
              )
            ],
          ),
          buildFab(),
        ],
      ),
      );
  }

  Widget buildFab(){
    final bloc = BlocProvider.of(context).taskListBloc;

    final double defaultTopMargin = 150;
    final double scaleStart = 96;
    final double scaleEnd = scaleStart/2;

    double top = defaultTopMargin;
    double scale = 1;
    if (_scrollController.hasClients) {
      double offset = _scrollController.offset;
      top -= offset;
      if (offset < defaultTopMargin - scaleStart){
        scale = 1;
      }
      else if (offset < defaultTopMargin - scaleEnd) {
        scale = (defaultTopMargin - scaleEnd - offset)/scaleEnd;
      }
      else {
        scale = 0;
      }
    }
    return Positioned(
      top: top,
      left: 16,
      child: Transform(
        transform: Matrix4.identity()..scale(scale),
        alignment: Alignment.center,
        child: StreamBuilder(
          stream: bloc.tasks,
          builder: (context, snapshot) {
            return FloatingActionButton(
              backgroundColor: Colors.teal,
              onPressed: () {
                bloc.toggleTaskComplete(snapshot.data[widget.index], widget.index);
              },
              child: Builder(
                builder: (_) {
                  if (!snapshot.hasData){
                    return Container();
                  }

                  if (snapshot.data[widget.index].isDone)
                    return Icon(Icons.close);
                  else
                    return Icon(Icons.check);
                },
              ),
            );
          }
        ),
      ),
    );
  }

  displayTaskTitle(TaskListBloc bloc, int index) {
    return StreamBuilder(
      stream: bloc.tasks,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return CircularProgressIndicator();
        }

        if (snapshot.data.isEmpty) {
          return Container();
        }

        return Text(
            snapshot.data[index].title
        );
      },
    );
  }
}