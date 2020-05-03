import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:trippas_app/ui/tripdetails.dart';
import 'package:trippas_app/utils/colors.dart';
import 'package:trippas_app/utils/scroller.dart';
import 'package:trippas_app/utils/dbhelper.dart';

import 'model/trip.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Trippas',
      theme: ThemeData(
          primarySwatch: createColor(Color(0xff3E64FF)),
          fontFamily: GoogleFonts.nunito().fontFamily,
          textTheme: TextTheme(
            headline: TextStyle(
              fontSize: 34.0,
              fontWeight: FontWeight.w800,
            ),
            title: TextStyle(
                fontSize: 18.0,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          )),
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
  DBHelper helper = DBHelper();
  List<Trip> trips;
  int count = 0;
  @override
  Widget build(BuildContext context) {
    TextStyle titleStyle = Theme.of(context).textTheme.title;
    if (trips == null) {
      trips = List<Trip>();
      getData();
    }
    return Scaffold(
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.only(
          top: 56.0,
          left: 30.0,
          right: 30.0,
          bottom: 24.0,
        ),
        child: ScrollConfiguration(
          behavior: TrippasBehavior(),
          child: SingleChildScrollView(
            physics: ScrollPhysics(),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Hello, Abdulrahman",
                      style: titleStyle,
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: business,
                          borderRadius: BorderRadius.circular(18.0)),
                      child: Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5.0, horizontal: 20.0),
                          child: Text(
                            tripCount(count),
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                              fontSize: 16.0,
                            ),
                          )),
                    )
                  ],
                ),
                Container(
                  margin: EdgeInsets.only(right: 100.0, top: 30.0),
                  child: Text(
                    'Create your trips with us',
                    style: GoogleFonts.nunito(
                        textStyle: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w900,
                            fontSize: 34.0,
                            letterSpacing: -.24,
                            height: 1)),
                  ),
                ),
                trips.length <= 0
                    ? Container(
                        height: MediaQuery.of(context).size.height * .77,
                        width: double.infinity,
                        child: Center(
                          child: Text(
                            'You have not created any trips\nClick + to begin.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 17.0,
                              color: textLight,
                            ),
                          ),
                        ))
                    : ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemCount: count,
                        itemBuilder: (context, pos) {
                          return InkWell(
                            onTap: () => {},
                            child: Container(
                              margin: EdgeInsets.symmetric(vertical: 5.0),
                              child: Card(
                                elevation: 1.0,
                                color: Colors.white,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    top: 12.0,
                                    left: 21.0,
                                    right: 12.0,
                                    bottom: 10.0,
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Text(
                                            trips[pos].departure,
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 18.0,
                                              fontWeight: FontWeight.w600,
                                              letterSpacing: -0.24,
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 10.0),
                                            child: Text(
                                              trips[pos].departureDate,
                                              style: TextStyle(
                                                color: textLight,
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: -.24,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 3.0),
                                            child: Text(
                                              trips[pos].departureTime,
                                              style: TextStyle(
                                                color: textLight,
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: -.24,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(top: 16.0),
                                            padding: EdgeInsets.symmetric(
                                              vertical: 1.0,
                                              horizontal: 7.0,
                                            ),
                                            decoration: BoxDecoration(
                                                color: calculateColor(
                                                    trips[pos].tripType),
                                                borderRadius:
                                                    BorderRadius.circular(2.5)),
                                            child: Text(
                                              getType(trips[pos].tripType),
                                              style: TextStyle(
                                                color: whiteShade,
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: -.24,
                                              ),
                                            ),
                                          )
                                        ],
                                      ),
                                      Image(
                                        image: AssetImage('images/plane.png'),
                                        height: 24.0,
                                        width: 24.0,
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Container(
                                            margin: EdgeInsets.only(right: 9.0),
                                            child: Text(
                                              trips[pos].arrival,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: -0.24,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 10.0, right: 9.0),
                                            child: Text(
                                              trips[pos].arrivalDate,
                                              style: TextStyle(
                                                color: textLight,
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: -.24,
                                              ),
                                            ),
                                          ),
                                          Container(
                                            margin: EdgeInsets.only(
                                                top: 3.0, right: 9.0),
                                            child: Text(
                                              trips[pos].arrivalTime,
                                              style: TextStyle(
                                                color: textLight,
                                                fontSize: 11.0,
                                                fontWeight: FontWeight.w600,
                                                letterSpacing: -.24,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 8.0,
                                                vertical: 10.0),
                                            child: PopupMenuButton<String>(
                                              onSelected: (value) =>
                                                  performAction(
                                                      value, trips[pos]),
                                              child: Image(
                                                image: AssetImage(
                                                    'images/menu.png'),
                                              ),
                                              itemBuilder: (context) =>
                                                  <PopupMenuEntry<String>>[
                                                const PopupMenuItem(
                                                  child: Center(
                                                    child: Text(
                                                      "Update",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  value: 'Update',
                                                ),
                                                const PopupMenuDivider(
                                                  height: 0.5,
                                                ),
                                                const PopupMenuItem(
                                                  child: Center(
                                                    child: Text(
                                                      "Delete",
                                                      style: TextStyle(
                                                        color: Colors.black,
                                                        fontSize: 18.0,
                                                        fontWeight:
                                                            FontWeight.w600,
                                                      ),
                                                    ),
                                                  ),
                                                  value: 'Delete',
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(
          right: 10.0,
          bottom: 20.0,
        ),
        child: FloatingActionButton(
          onPressed: () => navigateToDetails(Trip(
            '',
            '',
            '',
            '',
            '',
            '',
            '',
          )),
          tooltip: 'Increment',
          child: Image(
            image: AssetImage('images/add.png'),
          ),
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  navigateToDetails(Trip trip) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TripDetails(trip)));
    if (result != null && result == true) {
      getData();
    }
  }

  String tripCount(int count) {
    if (count == 1) {
      return '$count trip';
    } else {
      return '$count trips';
    }
  }

  Color calculateColor(String type) {
    Color result;
    switch (type) {
      case 'Vacation':
        result = vacation;
        break;
      case 'Education':
        result = education;
        break;
      case 'Health':
      case 'Medical':
        result = health;
        break;
      case 'Business':
        result = business;
        break;
    }
    return result;
  }

  String getType(String type) {
    if (type == 'Health')
      return 'Medical';
    else
      return type;
  }

  getData() {
    final dbFuture = helper.initializeDb();
    dbFuture.then((result) {
      helper.getTrips().then((result) {
        List<Trip> tripList = List<Trip>();
        count = result.length;
        result.forEach((t) {
          tripList.add(Trip.fromObject(t));
          debugPrint(tripList.last.toString());
        });
        setState(() {
          trips = tripList;
          count = count;
        });
        debugPrint('Trip count $count');
      });
    });
  }

  performAction(String value, Trip trip) async {
    if (value == 'Delete') {
      if (trip.id == null) {
        return;
      }
      int result = await helper.deleteTrip(trip.id);

      if (result != 0) {
        getData();
      }
    } else {
      navigateToDetails(trip);
    }
  }
}
