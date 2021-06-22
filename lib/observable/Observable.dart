abstract class Observable<T>{
  T? oldValue;
  List<ObservableChangeCallback> callbacks = <ObservableChangeCallback>[];

  setValue(T newValue){
    //值未发生变化
    if(oldValue==newValue){
      return;
    }
    //值发生变化
    oldValue = newValue;
    for(var callback in callbacks){
      callback.changeCallback(newValue);
    }
  }
  T getValue();

  //添加监听器
  void addCallback(ObservableChangeCallback callback){
    for(var cb in callbacks){
      //检查是否是同一个实例
      if(identical(cb,callback)){
        return;
      }
    }
    callbacks.add(callback);
  }

  //移除监听器
  void removeCallback(ObservableChangeCallback callback){
    for(var cb in callbacks){
      if(identical(cb,callback)){
        callbacks.remove(callback);
        return ;
      }
    }
  }

}
abstract class ObservableChangeCallback<T>{
  void changeCallback(T newValue);
}