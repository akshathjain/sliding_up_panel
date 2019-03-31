/*
Name: Akshath Jain
Date: 3/18/19
Purpose: Defines the sliding_up_panel widget
Copyright: © 2019, Akshath Jain. All rights reserved.
Licensing: More information can be found here: https://github.com/akshathjain/sliding_up_panel/blob/master/LICENSE
*/

import 'package:flutter/material.dart';

class SlidingUpPanel extends StatefulWidget {

  /// The Widget that slides into view. When the
  /// panel is collapsed and if [collapsed] is null,
  /// then top portion of this Widget will be displayed;
  /// otherwise, [collapsed] will be displayed overtop
  /// of this Widget.
  final Widget panel;

  /// The Widget displayed overtop the [panel] when collapsed.
  /// This fades out as the panel is opened.
  final Widget collapsed;

  /// The Widget that lies underneath the sliding panel.
  /// This Widget automatically sizes itself
  /// to fill the screen.
  final Widget body;

  /// The height of the sliding panel when fully collapsed.
  final double minHeight;

  /// The height of the sliding panel when fully open.
  final double maxHeight;

  /// A border to draw around the sliding panel sheet.
  final Border border;

  /// If non-null, the corners of the sliding panel sheet are rounded by this [BorderRadius].
  final BorderRadiusGeometry borderRadius;

  /// A list of shadows cast behind the sliding panel sheet.
  final List<BoxShadow> boxShadow;

  /// The color to fill the background of the sliding panel sheet.
  final Color color;

  /// The amount to inset the children of the sliding panel sheet.
  final EdgeInsetsGeometry padding;

  /// Empty space surrounding the sliding panel sheet.
  final EdgeInsetsGeometry margin;

  /// Set to false to not to render the sheet the [panel] sits upon.
  /// This means that only the [body], [collapsed], and the [panel]
  /// Widgets will be rendered.
  /// Set this to false if you want to achieve a floating effect or
  /// want more customization over how the sliding panel
  /// looks like.
  final bool renderPanelSheet;

  /// Set to false to disable the panel from snapping open or closed.
  final bool panelSnapping;

  /// If non-null, this can be used to control the state of the panel.
  final PanelController controller;

  SlidingUpPanel({
    Key key,
    @required this.panel,
    this.body,
    this.collapsed,
    this.minHeight = 100.0,
    this.maxHeight = 500.0,
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
    this.renderPanelSheet = true,
    this.panelSnapping = true,
    this.controller,
  }) : super(key: key);

  @override
  _SlidingUpPanelState createState() => _SlidingUpPanelState();
}

class _SlidingUpPanelState extends State<SlidingUpPanel> with SingleTickerProviderStateMixin{

  AnimationController _ac;

  double _closedHeight; //this can change depending on whether or not the user hides the sliding panel
  double _openHeight; //this can change depending on whether or not the user hides the sliding panel

  bool _isVisible = true;

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

    _closedHeight = widget.minHeight;
    _openHeight = widget.maxHeight;

    widget.controller?._addCloseListener(_close);
    widget.controller?._addOpenListener(_open);
    widget.controller?._addHideListener(_hide);
    widget.controller?._addShowListener(_show);

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: <Widget>[

        //make the back widget take up the entire back side
        widget.body != null ? Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: widget.body,
        ) : Container(),

        //the actual sliding part
        !_isVisible ? Container() : GestureDetector(
          onVerticalDragUpdate: _onDrag,
          onVerticalDragEnd: _onDragEnd,
          child: Container(
            height: _ac.value * (_openHeight - _closedHeight) + _closedHeight,
            margin: widget.margin,
            padding: widget.padding,
            decoration: widget.renderPanelSheet ? BoxDecoration(
              border: widget.border,
              borderRadius: widget.borderRadius,
              boxShadow: widget.boxShadow,
              color: widget.color,
            ) : null,
            child: Stack(
              children: <Widget>[

                //open panel
                Positioned(
                  top: 0.0,
                  width:  MediaQuery.of(context).size.width -
                          (widget.margin != null ? widget.margin.horizontal : 0) -
                          (widget.padding != null ? widget.padding.horizontal : 0),
                  child: Container(
                    height: widget.maxHeight,
                    child: widget.panel,
                  )
                ),

                // collapsed panel
                Container(
                  height: widget.minHeight,
                  child: Opacity(
                    opacity: 1.0 - _ac.value,
                    child: widget.collapsed ?? Container()
                  ),
                ),


              ],
            ),
          ),
        ),

      ],
    );
  }

  @override
  void dispose(){
    _ac.dispose();
    super.dispose();
  }

  void _onDrag(DragUpdateDetails details){
    _ac.value -= details.primaryDelta / (_openHeight - _closedHeight);
  }

  void _onDragEnd(DragEndDetails details){
    double minFlingVelocity = 365.0;

    //let the current animation finish before starting a new one
    if(_ac.isAnimating) return;

    //check if the velocity is sufficient to constitute fling
    if(details.velocity.pixelsPerSecond.dy.abs() >= minFlingVelocity){
      double visualVelocity = - details.velocity.pixelsPerSecond.dy / (_openHeight - _closedHeight);

      if(widget.panelSnapping)
        _ac.fling(velocity: visualVelocity);
      else{
        // actual scroll physics, will be implemented in a future release
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
        _open();
      else
        _close();
    }

  }

  //close the panel
  void _close(){
    _ac.fling(velocity: -1.0);
  }

  //open the panel
  void _open(){
    _ac.fling(velocity: 1.0);
  }

  //hide the panel (completely offscreen)
  void _hide(){
    _ac.fling(velocity: -1.0).then((x){
      setState(() {
        _isVisible = false;
      });
    });
  }

  //show the panel (in collapsed mode)
  void _show(){
    _ac.fling(velocity: -1.0).then((x){
      setState(() {
        _isVisible = true;
      });
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

  /// Closes the sliding panel to its collapsed state (i.e. to the  minHeight)
  void close(){
    _closeListener();
  }

  void _addOpenListener(VoidCallback listener){
    this._openListener = listener;
  }

  /// Opens the sliding panel fully (i.e. to the maxHeight)
  void open(){
    _openListener();
  }

  void _addHideListener(VoidCallback listener){
    this._hideListener = listener;
  }

  /// Hides the sliding panel (i.e. is invisible)
  void hide(){
    _hideListener();
  }

  void _addShowListener(VoidCallback listener){
    this._showListener = listener;
  }

  /// Shows the sliding panel in its collapsed state (i.e. "un-hide" the sliding panel)
  void show(){
    _showListener();
  }

}