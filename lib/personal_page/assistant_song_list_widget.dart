
import 'package:flutter/material.dart';
import 'package:ice_music_flutter/data/PersonalSongListGroup.dart';
import 'package:ice_music_flutter/observable/BoolObservable.dart';
import 'package:ice_music_flutter/observable/Observable.dart';
import 'package:ice_music_flutter/personal_page/assistant_song_list_animation.dart';

class AssistantSongListWidget extends StatefulWidget{
  List<AssistantSongListItemHintData> hints;
  BoolObservable _boolObservable;
  AssistantSongListWidget(this.hints,this._boolObservable);

  @override
  _AssistantSongListState createState() => _AssistantSongListState(hints: hints,boolObservable: _boolObservable);


}
class _AssistantSongListState extends State<AssistantSongListWidget>
    with TickerProviderStateMixin,ObservableChangeCallback<bool>{
  List<AssistantSongListItemHintData> hints;

  BoolObservable boolObservable;
  _AssistantSongListState({required this.hints,required this.boolObservable});

  late AnimationController _controller;
  int pos = 0;
  int hintSize = 0;

  double widgetCornerRadius = 6;

  double titleWidgetBottomMargin = 30;

  //“试试看”widget的大小
  double toTryWidgetHeight = 24;
  double toTryWidgetTopMargin = 20;
  double toTryWidgetBottomMargin = 20;
  TextStyle toTryStyle = TextStyle(
    fontSize: 20,color: Colors.white
  );

  //歌单标题文字风格
  TextStyle titleStyle = const TextStyle(
      fontStyle: FontStyle.normal,color: Colors.grey,fontSize: 14
  );
  TextStyle hintTitleStyle = const TextStyle(
    fontSize: 10,color: Colors.grey,fontStyle: FontStyle.normal
  );

  @override
  void initState() {
    //添加监听
    boolObservable.addCallback(this);

    hintSize = hints.length;

    _controller = AnimationController(
        duration: const Duration(milliseconds: 1000),vsync: this);

    _controller.addStatusListener((status) {
      if(status == AnimationStatus.completed){
        setState(() {
          pos++;
          pos%=hintSize;
        });
        _controller.reset();
        _controller.forward();
      }else if(status == AnimationStatus.dismissed){
        _controller.forward();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widgetCornerRadius)
      ),
      child: Column(
        children: <Widget>[
          //歌单标题
          Align(
            alignment: Alignment.centerLeft,
            child: Text("歌单助手",style: titleStyle,),
          ),
          SizedBox(height: titleWidgetBottomMargin,),

          Align(
            alignment: Alignment.center,
            child: Text("你可以从歌单中筛选出",style: hintTitleStyle,),
          ),

          //歌单的提示动画
          AssistantSongListAnimation(controller: _controller,
            firstText: hints[pos].hintWord,secondText: hints[(pos+1)%hintSize].hintWord,),

          SizedBox(height: toTryWidgetTopMargin,),
          Container(
              height: toTryWidgetHeight,
              decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(toTryWidgetHeight/2),
                  ),
                  color: Colors.red
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  SizedBox(width: 6,),
                  Text("试试看",style: toTryStyle,),
                  SizedBox(width: 6,)
                ],
              ),
          ),
          SizedBox(height: toTryWidgetBottomMargin,),
        ],
      ),
    );
  }

  @override
  void changeCallback(bool newValue) {
    if(newValue){
      _controller.reset();
      _controller.forward();
    }else{
      _controller.stop();
    }
  }

  @override
  void dispose() {
    super.dispose();
    boolObservable.removeCallback(this);
  }
}
