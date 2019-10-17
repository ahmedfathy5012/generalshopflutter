import 'dart:async';

import 'package:generalshop/contracts/contracts.dart';

class DotsStream implements Disposable{
int currentDot;
StreamController<int> _dotsStreamController = StreamController<int>.broadcast();
Stream<int> get dots => _dotsStreamController.stream;
StreamSink<int> get dotsSink => _dotsStreamController.sink;


 DotsStream(){
   currentDot = 1;
   _dotsStreamController.add(currentDot);
   _dotsStreamController.stream.listen(_indexChange);
 }



void _indexChange (int newIndex){
  currentDot = newIndex;
  _dotsStreamController.add(newIndex);
}


  @override
  void dispose() {
    // TODO: implement dispose
    _dotsStreamController.close();
  }


}