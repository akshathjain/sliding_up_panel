/*
Name: Akshath Jain
Date: 3/18/19
Purpose: defines the package: grouped_buttons
Copyright: © 2019, Akshath Jain. All rights reserved.
Licensing: More information can be found here: https://github.com/akshathjain/sliding_up_panel/blob/master/LICENSE
*/

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

void main() => runApp(SlidingUpPanelExample());

class SlidingUpPanelExample extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SlidingUpPanelExample"),
      ),
      body: _body(),
    );
  }

  Widget _body(){
    return SlidingUpPanel(
      back: Center(child: Text("This is the back"),),
      //panelCollapsed: _floatingClosed(),
      renderSheet: false,
      panelOpen: _floatingOpen(),
    );
  }

  Widget _floatingClosed(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
      ),
      margin: const EdgeInsets.all(10.0),
      child: Center(
        child: Text("This is the SlidingUpPanel when closed", style: TextStyle(color: Colors.white),),
      ),
    );
  }

  Widget _floatingOpen(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(36.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.grey,
          ),
        ]
      ),
      margin: const EdgeInsets.all(24.0),
      child: Center(
        child: Text("This is the SlidingUpPanel when open"),
      ),
    );
  }

}
