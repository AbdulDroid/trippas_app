import 'package:flutter/material.dart';
import 'package:trippas_app/model/trip.dart';
import 'package:trippas_app/ui/tripdetails.dart';
import 'package:trippas_app/utils/colors.dart';
import 'package:trippas_app/utils/dbhelper.dart';

class TripTile extends StatefulWidget {
  final ValueNotifier countNotifier;
  final ValueNotifier updateNofifier;
  TripTile(this.countNotifier, this.updateNofifier);
  @override
  State<StatefulWidget> createState() =>
      TripTileState(countNotifier, updateNofifier);
}

class TripTileState extends State {
  DBHelper helper = DBHelper();
  List<Trip> trips;
  int count = 0;
  final ValueNotifier countNotifier;
  final ValueNotifier updateNofifier;
  TripTileState(this.countNotifier, this.updateNofifier);

  @override
  Widget build(BuildContext context) {
    if (trips == null) {
      trips = List<Trip>();
      getData();
    }
    return ListView.builder(
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
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
                                color: calculateColor(trips[pos].tripType),
                                borderRadius: BorderRadius.circular(2.0)),
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
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
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
                            margin: EdgeInsets.only(top: 10.0, right: 9.0),
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
                            margin: EdgeInsets.only(top: 3.0, right: 9.0),
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
                          PopupMenuButton<String>(
                            onSelected: (value) => performAction(value, trips[pos]),
                            child: Image(
                              image: AssetImage('images/menu.png'),
                            ),
                            itemBuilder: (context) => <PopupMenuEntry<String>>[
                              const PopupMenuItem(
                                child: Center(
                                  child: Text(
                                    "Update",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.w600,
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
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                                value: 'Delete',
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
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

  navigateToDetails(Trip trip) async {
    bool result = await Navigator.push(
        context, MaterialPageRoute(builder: (context) => TripDetails(trip)));
    if (result) {
      getData();
    }
  }

  getData() {
    final dbFuture = helper.initializeDb();
    dbFuture.then((result) {
      helper.getTrips().then((result) {
        List<Trip> tripList = List<Trip>();
        count = result.length;
        result.forEach((t) {
          tripList.add(Trip.fromObject(t));
          debugPrint(tripList.last.arrival);
        });
        setState(() {
          trips = tripList;
          count = count;
          countNotifier.value = count;
        });
        debugPrint('Trip count $count');
      });
    });
  }

  performAction(String value, Trip trip) async {
    if(value == 'Delete') {
      if (trip.id == null) {
        return;
      }
      int result = await helper.deleteTrip(trip.id);

      if(result != 0) {
        getData();
      }
    } else {
      navigateToDetails(trip);
    }
  }
}
