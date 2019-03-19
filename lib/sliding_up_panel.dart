/*
Name: Akshath Jain
Date: 3/18/19
Purpose: defines the package: grouped_buttons
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

class _SliderState extends State<_Slider> {

  double _height; //store panel height
  double _y0; //store previous position
  int _t0; //store previous time
  int _dt = 200;

  @override
  void initState(){
    super.initState();

    _height = widget.closedHeight;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      child: AnimatedContainer(
        duration: Duration(milliseconds: _dt),
        curve: Curves.easeOutExpo,
        height: _height,
        color: Colors.orange,
        child: widget.full,
      ),
      onVerticalDragUpdate: _onDrag,
      onVerticalDragStart: (DragStartDetails dets){
        _t0 = dets.sourceTimeStamp.inMilliseconds;
      },
      onVerticalDragEnd: (DragEndDetails dets){
        setState(() {
          if(_y0 < 0.0) _height = widget.openHeight;
          else _height = widget.closedHeight;
          _dt = 200;
        });
      },
      
    );
  }

  void _onDrag(DragUpdateDetails details){
    //print(_height);
    //print(details.delta.dy);
    // setState((){_height = widget.openHeight;});
    // print(details.sourceTimeStamp.inMilliseconds.toString());

    setState(() {
      double newHeight = _height - details.delta.dy;
      if(widget.closedHeight <= newHeight && newHeight <= widget.openHeight)
        _height = newHeight;
      _y0 = details.delta.dy;
      _dt = details.sourceTimeStamp.inMilliseconds - _t0;
      _t0 = details.sourceTimeStamp.inMilliseconds;
    });
  }
}