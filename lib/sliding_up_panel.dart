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
  final Widget panelCollapsed;

  /// The Widget displayed when the sliding panel is fully opened.
  final Widget panelOpen;

  /// The height of the sliding panel when fully collapsed.
  final double panelHeightCollapsed;

  /// The height of the sliding panel when fully open.
  final double panelHeightOpen;

  /// A border to draw around the sliding panel sheet.
  final Border border;

  /// If non-null, the corners of the sliding panel sheet are rounded by this [BorderRadius].
  final BorderRadiusGeometry borderRadius;

  /// A list of shadows cast behind the sliding panel.
  final List<BoxShadow> boxShadows;

  /// The color to fill the background of the sliding panel.
  final Color color;

  /// The amount to inset the children of the sliding panel.
  final EdgeInsetsGeometry padding;

  /// Signals whether or not to render the sliding panel sheet.
  /// Setting this to false means that only [back], [panelCollapsed], and the [panelOpen] Widgets will be rendered.
  /// Set this to false if you want to achieve a floating effect or want more customization over how the sliding panel
  /// looks like.
  final bool renderSheet;

  SlidingUpPanel({
    Key key,
    @required this.back,
    this.panelCollapsed,
    @required this.panelOpen,
    this.panelHeightCollapsed = 100.0,
    this.panelHeightOpen = 500.0,
    this.border,
    this.borderRadius,
    this.boxShadows = const <BoxShadow>[
      BoxShadow(
        blurRadius: 12.0,
        color: Colors.grey,
      )
    ],
    this.color = Colors.white,
    this.padding,
    this.renderSheet = true,
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
          child: widget.back,
        ),

        _Slider(
          closedHeight: widget.panelHeightCollapsed,
          openHeight: widget.panelHeightOpen,
          collapsed: widget.panelCollapsed,
          full: widget.panelOpen,
          border: widget.border,
          borderRadius: widget.borderRadius,
          boxShadows: widget.boxShadows,
          color: widget.color,
          padding: widget.padding,
          renderSheet: widget.renderSheet,
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
  final Border border;
  final BorderRadiusGeometry borderRadius;
  final List<BoxShadow> boxShadows;
  final Color color;
  final EdgeInsetsGeometry padding;
  final bool renderSheet;

  _Slider({
    Key key,
    @required this.closedHeight,
    @required this.openHeight,
    @required this.collapsed,
    @required this.full,
    this.border,
    this.borderRadius,
    this.boxShadows,
    this.color,
    this.padding,
    this.renderSheet,
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
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _onDrag,
      onVerticalDragEnd: _settle,
      child: Container(
        height: _controller.value * (widget.openHeight - widget.closedHeight) + widget.closedHeight,
        padding: widget.padding,
        decoration: BoxDecoration(
          border: widget.border,
          borderRadius: widget.borderRadius,
          boxShadow: widget.boxShadows,
          color: widget.color,
        ),
        child: Stack(
          children: <Widget>[

            //open panel
            Positioned(
              top: 0.0,
              child: Container(
                height: widget.openHeight,
                width: MediaQuery.of(context).size.width,
                child: widget.full,
              )
            ),

            // collapsed panel
            Container(
              height: widget.closedHeight,
              child: Opacity(
                opacity: 1.0 - _controller.value,
                child: widget.collapsed ?? Container()
              ),
            ),


          ],
        ),
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
  }

  double _minFlingVelocity = 365.0;

  void _settle(DragEndDetails details){
    //check if the velocity is sufficient to constitute fling
    if(details.velocity.pixelsPerSecond.dy.abs() >=_minFlingVelocity){
      double visualVelocity = - details.velocity.pixelsPerSecond.dy / (widget.openHeight - widget.closedHeight);
      _controller.fling(velocity: visualVelocity);
      return;
    }

    //check if the controller is already halfway there
    if(_controller.value > 0.5)
      _controller.fling();
    else
      _controller.fling(velocity: -1);
  }

}