import 'package:flutter/material.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  ItemScrollController itemScrollController;
  ItemPositionsListener itemPositionListener;
  List<String> users = [
    "1",
    "2",
    "3",
    "4",
    "5",
    "6",
    "7",
    "8",
    "9",
    "10",
    "11",
    "12"
  ];

  @override
  void initState() {
    itemScrollController = ItemScrollController();
    itemPositionListener = ItemPositionsListener.create();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 250,
              child: ScrollablePositionedList.builder(
                physics: ScrollPhysics(parent: null),
                itemScrollController: itemScrollController,
                itemPositionsListener: itemPositionListener,
                itemCount: users.length,
                padding: EdgeInsets.only(bottom: 50, top: 20),
                itemBuilder: (context, index) {
                  return Container(
                    margin: EdgeInsets.all(5),
                    decoration: BoxDecoration(color: Colors.red),
                    height: MediaQuery.of(context).size.height / 5,
                    padding: EdgeInsets.all(20),
                    child: Text(
                      users[index],
                      style: TextStyle(color: Colors.white, fontSize: 30),
                    ),
                  );
                },
              ),
            ),
            Container(
              child: getTextWidgets(),
            )
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget getTextWidgets() {
    List<Widget> list = new List<Widget>();
    for (var i = 0; i < users.length; i++) {
      list.add(Container(
        height: 45,
        width: 45,
        margin: EdgeInsets.all(5),
        child: new RawMaterialButton(
          onPressed: () => findCurrentUser(itemScrollController, i),
          elevation: 2.0,
          fillColor: Colors.white,
          child: Text(
            users[i],
            style: TextStyle(fontSize: 10),
          ),
          padding: EdgeInsets.all(15.0),
          shape: CircleBorder(),
        ),
      ));
    }
    return new Wrap(children: list);
  }

  findCurrentUser(ItemScrollController itemScrollController, index) {
    itemScrollController.scrollTo(
        index: index,
        duration: Duration(seconds: 2),
        curve: Curves.easeInOutCubic);
  }
}
