/*
Name: Akshath Jain
Date: 3/18/19
Purpose: Example app that implements the package: sliding_up_panel
Copyright: © 2019, Akshath Jain. All rights reserved.
Licensing: More information can be found here: https://github.com/akshathjain/sliding_up_panel/blob/master/LICENSE
*/

import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong/latlong.dart';

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

  double _fabHeight = 120.0;

  @override
  Widget build(BuildContext context){
    return Material(
      child: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[

          SlidingUpPanel(
            maxHeight: 550.0,
            parallaxEnabled: true,
            parallaxOffset: .5,
            body: _body(),
            panel: _panel(),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
            onPanelSlide: (double pos) => setState((){
              _fabHeight = pos * 450.0 + 120.0;
            }),
          ),

          // the fab
          Positioned(
            right: 20.0,
            bottom: _fabHeight,
            child: FloatingActionButton(
              child: Icon(
                Icons.gps_fixed,
                color: Theme.of(context).primaryColor,
              ),
              onPressed: (){},
              backgroundColor: Colors.white,
            ),
          ),

          //the SlidingUpPanel Titel
          Positioned(
            top: 50.0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24.0, 18.0, 24.0, 18.0),
              child: Text(
                "SlidingUpPanel Example",
                style: TextStyle(
                  fontWeight: FontWeight.w500
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24.0),
                boxShadow: [BoxShadow(
                  color: Color.fromRGBO(0, 0, 0, .35),
                  blurRadius: 20.0
                )],
              ),
            ),
          ),


        ],
      ),
    );
  }

  Widget _panel(){
    return Column(
      children: <Widget>[
        SizedBox(height: 12.0,),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              width: 30,
              height: 5,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.all(Radius.circular(12.0))
              ),
            ),
          ],
        ),

        SizedBox(height: 18.0,),

        Text(
          "Explore Pittsburgh",
          style: TextStyle(
            fontWeight: FontWeight.normal,
            fontSize: 24.0,
          ),
        ),
      ],
    );
  }

  Widget _body(){
    return FlutterMap(
      options: MapOptions(
        center: LatLng(40.441589, -80.010948),
        zoom: 13,
        maxZoom: 15,
      ),
      layers: [
        TileLayerOptions(
          urlTemplate: "https://maps.wikimedia.org/osm-intl/{z}/{x}/{y}.png"
        ),

        MarkerLayerOptions(
          markers: [
            Marker(
              point: LatLng(40.441753, -80.011476),
              builder: (ctx) => Icon(
                Icons.location_on,
                color: Colors.blue,
                size: 48.0,
              ),
              height: 60
            ),
          ]
        ),
      ],
    );
  }
}
