/*
Name: Akshath Jain
Date: 3/18/19
Purpose: Example app that implements the package: sliding_up_panel
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
      title: 'SlidingUpPanel Example',
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

  PanelController _pc = new PanelController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SlidingUpPanelExample"),
      ),
      body: SlidingUpPanel(
        renderPanelSheet: false,
        panel: _floatingPanel(),
        collapsed: _floatingCollapsed(),
        body: _body(),
        controller: _pc,
      ),
    );
  }

  Widget _body(){
    return Container(
      padding: const EdgeInsets.only(top: 20.0),
      child: Column(
        children: <Widget>[
          RaisedButton(
            child: Text("Open"),
            onPressed: () => _pc.open(),
          ),
          RaisedButton(
            child: Text("Close"),
            onPressed: () => _pc.close(),
          ),
          RaisedButton(
            child: Text("Show"),
            onPressed: () => _pc.show(),
          ),
          RaisedButton(
            child: Text("Hide"),
            onPressed: () => _pc.hide(),
          ),
        ],
      ),
    );
  }

  Widget _floatingCollapsed(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.only(topLeft: Radius.circular(24.0), topRight: Radius.circular(24.0)),
      ),
      margin: const EdgeInsets.fromLTRB(24.0, 24.0, 24.0, 0.0),
      child: Center(
        child: Text(
          "This is the collapsed Widget",
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }

  Widget _floatingPanel(){
    return Container(
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.all(Radius.circular(24.0)),
        boxShadow: [
          BoxShadow(
            blurRadius: 20.0,
            color: Colors.grey,
          ),
        ]
      ),
      margin: const EdgeInsets.all(24.0),
      child: _scrollingList(),
    );
  }

  Widget _scrollingList(){
    return Container(
      //adding a margin to the top leaves an area where the user can swipe
      //to open/close the sliding panel
      margin: const EdgeInsets.only(top: 36.0),
      child: ListView.builder(
        itemCount: 50,
        itemBuilder: (BuildContext context, int i){
          return Container(
            color: Colors.white,
            padding: const EdgeInsets.all(12.0),
            child: Text("$i"),
          );
        },
      ),
    );
  }

}
