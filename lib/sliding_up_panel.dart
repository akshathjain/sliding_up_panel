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
    return Container(
      
    );
  }
}