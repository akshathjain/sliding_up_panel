/*
Name: Akshath Jain
Date: 3/30/19
Purpose: defines the panel controller class
Copyright: © 2019, Akshath Jain. All rights reserved.
Licensing: More information can be found here: https://github.com/akshathjain/sliding_up_panel/blob/master/LICENSE
*/

import 'package:flutter/material.dart';

class PanelController{
  VoidCallback _closeListener;
  VoidCallback _openListener;
  VoidCallback _hideListener;

  @protected
  void addCloseListener(VoidCallback listener){
    this._closeListener = listener;
  }

  void close(){
    _closeListener();
  }

  @protected
  void addOpenListener(VoidCallback listener){
    this._openListener = listener;
  }

  void open(){
    _openListener();
  }

  @protected
  void addHideListener(VoidCallback listener){
    this._hideListener = listener;
  }

  void hide(){
    _hideListener();
  }

}