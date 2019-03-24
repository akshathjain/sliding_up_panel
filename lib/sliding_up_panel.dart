/*
Name: Akshath Jain
Date: 3/18/19
Purpose: defines the package: sliding_up_panel
Copyright: © 2019, Akshath Jain. All rights reserved.
Licensing: More information can be found here: https://github.com/akshathjain/sliding_up_panel/blob/master/LICENSE
*/

library sliding_up_panel;

import 'package:flutter/material.dart';

class SlidingUpPanel extends StatefulWidget {
  
  /// The Widget that lies underneath the sliding panel.
  final Widget back;

  /// The Widget displayed in the sliding panel when collapsed.
  final Widget frontCollapsed;

  /// The Widget displayed when the sliding panel is fully opened.
  final Widget frontFull;

  /// The height of the sliding panel when fully collapsed.
  final double panelHeightCollapsed; 

  /// The height of the sliding panel when fully open.
  final double panelHeightOpen;

  SlidingUpPanel({
    Key key,
    @required this.back,
    @required this.frontCollapsed,
    @required this.frontFull,
    this.panelHeightCollapsed = 100.0,
    this.panelHeightOpen = 500.0, 
  }) : super(key: key);

  @override
  _SlidingUpPanelState createState() => _SlidingUpPanelState();
}

class _SlidingUpPanelState extends State<SlidingUpPanel> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[

        //make the back widget take up the entire back side
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Colors.grey,
          child: widget.back,
        ),

        _Slider(
          closedHeight: widget.panelHeightCollapsed,
          openHeight: widget.panelHeightOpen,
          collapsed: widget.frontCollapsed,
          full: widget.frontFull,
        ),
      ],
    );
  }
}


class _Slider extends StatefulWidget {
  
  final double closedHeight;
  final double openHeight;
  final Widget collapsed;
  final Widget full;

  _Slider({
    Key key,
    @required this.closedHeight,
    @required this.openHeight,
    @required this.collapsed,
    @required this.full,
  }) : super (key: key);

  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<_Slider> with SingleTickerProviderStateMixin{
  AnimationController _controller;

  @override
  void initState(){
    super.initState();

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener((){
      setState((){});
    });
    _controller.value = 0.0;
    print(_controller.value);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _onDrag,
      onVerticalDragEnd: _settle,
      child: Container(
        height: _controller.value * (widget.openHeight - widget.closedHeight) + widget.closedHeight,
        color: Colors.orange,
      ),
    );
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  void _onDrag(DragUpdateDetails details){
    _controller.value -= details.primaryDelta / (widget.openHeight - widget.closedHeight);
    //print(_controller);
  }

  double _minFlingVelocity = 365.0;

  void _settle(DragEndDetails details){
    //check if the velocity is sufficient to constitute fling
    if(details.velocity.pixelsPerSecond.dy.abs() >=_minFlingVelocity){
      double visualVelocity = - details.velocity.pixelsPerSecond.dy / (widget.openHeight - widget.closedHeight);
      _controller.fling(velocity: visualVelocity);
    }
  }

}