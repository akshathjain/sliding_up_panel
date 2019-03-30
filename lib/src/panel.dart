/*
Name: Akshath Jain
Date: 3/18/19
Purpose: defines the sliding_up_panel widget
Copyright: © 2019, Akshath Jain. All rights reserved.
Licensing: More information can be found here: https://github.com/akshathjain/sliding_up_panel/blob/master/LICENSE
*/

import 'package:flutter/material.dart';
// import 'dart:math';

class SlidingUpPanel extends StatefulWidget {

  /// The Widget that lies underneath the sliding panel. This widget automatically sizes itself
  /// to be in an area
  final Widget childBehind;

  /// The Widget displayed in the sliding panel when collapsed. This dissappears as the panel is opened.
  final Widget childWhenCollapsed;

  /// The Widget displayed when the sliding panel is fully opened. This slides into view as the panel is opened.
  /// When the panel is collased and if the [childWhenCollapsed] is null, then top portion of this Widget
  /// will be displayed on the panel; otherwise, the [childWhenCollapsed] will be displayed overtop of this Widget.
  final Widget child;

  /// The height of the sliding panel when fully collapsed.
  final double panelHeightCollapsed;

  /// The height of the sliding panel when fully open.
  final double panelHeightOpen;

  /// A border to draw around the sliding panel sheet.
  final Border border;

  /// If non-null, the corners of the sliding panel sheet are rounded by this [BorderRadius].
  final BorderRadiusGeometry borderRadius;

  /// A list of shadows cast behind the sliding panel.
  final List<BoxShadow> boxShadow;

  /// The color to fill the background of the sliding panel.
  final Color color;

  /// The amount to inset the children of the sliding panel.
  final EdgeInsetsGeometry padding;

  /// Empty space surrounding the sliding panel.
  final EdgeInsetsGeometry margin;

  /// Set to false to not to render the sliding panel sheet.
  /// This means that only [childBehind], [childWhenCollapsed], and the [child] Widgets will be rendered.
  /// Set this to false if you want to achieve a floating effect or want more customization over how the sliding panel
  /// looks like.
  final bool renderSheet;

  /// Set to false to disable the panel from snapping open or closed.
  final bool panelSnapping;

  /// If non-null, this can be used to control the state of the panel.
  final PanelController controller;

  SlidingUpPanel({
    Key key,
    this.childBehind,
    this.childWhenCollapsed,
    @required this.child,
    this.panelHeightCollapsed = 100.0,
    this.panelHeightOpen = 500.0,
    this.border,
    this.borderRadius,
    this.boxShadow = const <BoxShadow>[
      BoxShadow(
        blurRadius: 12.0,
        color: Colors.grey,
      )
    ],
    this.color = Colors.white,
    this.padding,
    this.margin,
    this.renderSheet = true,
    this.panelSnapping = true,
    this.controller,
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
        widget.childBehind != null ? Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: widget.childBehind,
        ) : Container(),

        _Slider(
          closedHeight: widget.panelHeightCollapsed,
          openHeight: widget.panelHeightOpen,
          collapsed: widget.childWhenCollapsed,
          full: widget.child,
          border: widget.border,
          borderRadius: widget.borderRadius,
          boxShadows: widget.boxShadow,
          color: widget.color,
          padding: widget.padding,
          margin: widget.margin,
          renderSheet: widget.renderSheet,
          panelSnapping: widget.panelSnapping,
          controller: widget.controller,
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
  final EdgeInsetsGeometry margin;
  final bool renderSheet;
  final bool panelSnapping;
  final PanelController controller;

  _Slider({
    Key key,
    @required this.closedHeight,
    @required this.openHeight,
    @required this.collapsed,
    @required this.full,
    @required this.border,
    @required this.borderRadius,
    @required this.boxShadows,
    @required this.color,
    @required this.padding,
    @required this.margin,
    @required this.renderSheet,
    @required this.panelSnapping,
    @required this.controller,
  }) : super (key: key);

  @override
  _SliderState createState() => _SliderState();
}

class _SliderState extends State<_Slider> with SingleTickerProviderStateMixin{
  AnimationController _ac;
  double _closedHeight; //this can change depending on whether or not the user hides the sliding panel

  @override
  void initState(){
    super.initState();

    _ac = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    )..addListener((){
      setState((){});
    });
    _ac.value = 0.0;

    _closedHeight = widget.closedHeight;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragUpdate: _onDrag,
      onVerticalDragEnd: _settle,
      child: Container(
        height: _ac.value * (widget.openHeight - _closedHeight) + _closedHeight,
        margin: widget.margin,
        padding: widget.padding,
        decoration: widget.renderSheet ? BoxDecoration(
          border: widget.border,
          borderRadius: widget.borderRadius,
          boxShadow: widget.boxShadows,
          color: widget.color,
        ) : null,
        child: Stack(
          children: <Widget>[

            //open panel
            Positioned(
              top: 0.0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                height: widget.openHeight,
                child: widget.full,
              )
            ),

            // collapsed panel
            Container(
              height: _closedHeight,
              child: Opacity(
                opacity: 1.0 - _ac.value,
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
    _ac.dispose();
    super.dispose();
  }

  void _onDrag(DragUpdateDetails details){
    _ac.value -= details.primaryDelta / (widget.openHeight - _closedHeight);
  }

  double _minFlingVelocity = 365.0;
  void _settle(DragEndDetails details){

      //let the current animation finish before starting a new one
      if(_ac.isAnimating) return;

      //check if the velocity is sufficient to constitute fling
      if(details.velocity.pixelsPerSecond.dy.abs() >= _minFlingVelocity){
        double visualVelocity = - details.velocity.pixelsPerSecond.dy / (widget.openHeight - _closedHeight);

        if(widget.panelSnapping)
          _ac.fling(velocity: visualVelocity);
        else{
          // actual scroll physics, will be implemented in a future release

          // double g = 9.8;
          // double u = .01;
          // double a = u * g;
          // double dx = visualVelocity * visualVelocity / (-2 * u * g);
          // double t = sqrt(2 *  max(dx, -dx) / u / g);
          // print((t*1000).toInt());

          _ac.animateTo(
            _ac.value + visualVelocity * 0.16,
            duration: Duration(milliseconds: 410),
            curve: Curves.decelerate,
          );
        }

        return;
      }

      // check if the controller is already halfway there
      if (widget.panelSnapping) {
        if(_ac.value > 0.5)
          _ac.fling();
        else
          _ac.fling(velocity: -1);
      }

  }

  void _close(){
    _ac.fling(velocity: -1.0);
  }

  void _open(){
    _ac.fling(velocity: -1.0);
  }

  void _hide(){
    setState(() {

    });
  }

  void _show(){
    setState(() {

    });
  }
}






























class PanelController{
  VoidCallback _closeListener;
  VoidCallback _openListener;
  VoidCallback _hideListener;
  VoidCallback _showListener;

  void _addCloseListener(VoidCallback listener){
    this._closeListener = listener;
  }

  void close(){
    _closeListener();
  }

  void _addOpenListener(VoidCallback listener){
    this._openListener = listener;
  }

  void open(){
    _openListener();
  }

  void _addHideListener(VoidCallback listener){
    this._hideListener = listener;
  }

  void hide(){
    _hideListener();
  }

  void _addShowListener(VoidCallback listener){
    this._showListener = listener;
  }

  void show(){
    _showListener();
  }

}