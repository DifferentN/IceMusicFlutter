import 'package:ice_music_flutter/observable/Observable.dart';

class BoolObservable extends Observable<bool>{
  bool _bool = false;

  bool getValue(){
    return _bool;
  }
  void setValue(bool newValue){
    //发送值改变通知
    super.setValue(newValue);

    _bool = newValue;
  }
}