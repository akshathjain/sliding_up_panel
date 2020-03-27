import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';

void main() => runApp(DemoApp());

class DemoApp extends StatefulWidget {
  
  @override
  State<StatefulWidget> createState() => _DemoAppState();
  
}

class _DemoAppState extends State<DemoApp> {
  static const _routeTo2 = '/2';

  @override
  Widget build(BuildContext context) =>
      MaterialApp(
        home: Stack(
          children: <Widget>[
            SlidingUpPanel(
              scrollViewCount: 2,
              defaultScrollView: 0,
              minHeight: 32,
              panelBuilder: (scrollController) =>
                  Navigator(
                    initialRoute: Navigator.defaultRouteName,
                    onGenerateRoute: (settings) {
                      switch (settings.name) {
                        case Navigator.defaultRouteName:
                          return MaterialPageRoute(
                            builder: (context) {
                              scrollController.delegateTo(0);
                              return ListView(
                                physics: ClampingScrollPhysics(),
                                controller: scrollController.delegate(0),
                                children: [
                                  for (int i = 0; i < 100; i++)
                                    GestureDetector(
                                      child: Container(
                                        height: 32,
                                        color: Colors.primaries[i % Colors.primaries.length],
                                      ),
                                      onTap: () => Navigator.pushNamed(context, _routeTo2),
                                    ),
                                ],
                              );
                            },
                          );
                        case _routeTo2:
                          return MaterialPageRoute(
                            builder: (context) {
                              scrollController.delegateTo(1);
                              return ListView(
                                physics: ClampingScrollPhysics(),
                                controller: scrollController.delegate(1),
                                children: [
                                  for (int i = 0; i < 100; i++)
                                    GestureDetector(
                                      child: Container(
                                        height: 32,
                                        color: Colors.accents[i % Colors.accents.length],
                                      ),
                                      onTap: () => Navigator.pop(context),
                                    ),
                                ],
                              );
                            },
                          );
                        default:
                          throw Exception("Unknown route: ${settings.name}");
                      }
                    },
                  ),
            ),
          ],
        ),
      );
}