import 'dart:ffi';

import 'package:flutter/material.dart';

class AssistantSongListAnimation extends StatelessWidget{
  final Animation<double> controller;
  late Animation<double> toSmallAnimation;
  late Animation<double> toBigAnimation;
  late Animation<double> toHideAnimation;
  late Animation<double> toShowAnimation;
  late Animation<EdgeInsets> toUpAnimation;

  double textHeight = 20;

  String firstText = "";
  String secondText = "";

  AssistantSongListAnimation({Key? key,required this.controller,required this.firstText,required this.secondText}):super(key: key){
    toSmallAnimation = Tween(
      begin: 20.0,
      end: 0.0
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    toBigAnimation = Tween(
        begin: 10.0,
        end: 20.0
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    toHideAnimation = Tween(begin: 1.0,end: 0.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    toShowAnimation = Tween(begin: 0.5,end: 1.0)
        .animate(CurvedAnimation(parent: controller, curve: Curves.linear));

    toUpAnimation = Tween(
        begin: EdgeInsets.only(top: textHeight),
        end: EdgeInsets.only(top: 0)
    ).animate(CurvedAnimation(parent: controller, curve: Curves.linear));

  }

  Widget _buildAnimationWidget(BuildContext context, Widget? child){
    return Stack(
      children: <Widget>[
        Container(
          height: textHeight,
          alignment: Alignment.topCenter,
          child: Opacity(
            opacity: toHideAnimation.value,
            child: Text("${firstText}",style: TextStyle(fontSize: toSmallAnimation.value),),
          ),
        ),
        Container(
          height: textHeight*2,
          alignment: Alignment.topCenter,
          child: Padding(
            padding: toUpAnimation.value,
            child: Opacity(
              opacity: toShowAnimation.value,
              child: Text("${secondText}",style: TextStyle(fontSize: toBigAnimation.value),),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: _buildAnimationWidget);
  }
  
}