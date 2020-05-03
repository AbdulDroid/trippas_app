import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:trippas_app/model/trip.dart';
import 'package:trippas_app/utils/colors.dart';
import 'package:trippas_app/utils/dbhelper.dart';

DBHelper helper = DBHelper();

class TripDetails extends StatefulWidget {
  final Trip trip;
  TripDetails(this.trip);

  @override
  State<StatefulWidget> createState() => TripDetailsState(trip);
}

class TripDetailsState extends State {
  final Trip trip;
  TripDetailsState(this.trip);

  TextEditingController departureController = TextEditingController();
  TextEditingController arrivalController = TextEditingController();
  TextEditingController departureDateController = TextEditingController();
  TextEditingController departureTimeController = TextEditingController();
  TextEditingController arrivalDateController = TextEditingController();
  TextEditingController arrivalTimeController = TextEditingController();
  final _tripOptions = ['Business', 'Education', 'Health', 'Vacation'];
  String _tripOption = 'Low';

  @override
  void initState() {
    super.initState();
    departureDateController.addListener(updateDepartureDate);
    departureTimeController.addListener(updateDepartureTime);
    arrivalDateController.addListener(updateArrivalDate);
    arrivalTimeController.addListener(updateArrivalTime);
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    departureTimeController.dispose();
    departureDateController.dispose();
    arrivalTimeController.dispose();
    arrivalTimeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    departureController.text = trip.departure;
    arrivalController.text = trip.arrival;
    departureDateController.text = trip.departureDate;
    departureTimeController.text = trip.departureTime;
    arrivalDateController.text = trip.arrivalDate;
    arrivalTimeController.text = trip.arrivalTime;
    TextStyle textStyle = GoogleFonts.nunito(
        textStyle: TextStyle(
      color: Colors.black,
      fontSize: 18.0,
      fontWeight: FontWeight.w600,
    ));
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(true),
          color: Colors.black,
        ),
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          updateTitle(trip.arrival),
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.w600,
            color: Colors.black,
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: 30.0,
          right: 30.0,
          left: 30.0,
        ),
        child: ListView(
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: TextField(
                    controller: departureController,
                    onChanged: (v) => updateDeparture(),
                    style: textStyle,
                    decoration: InputDecoration(
                        hintText: 'Enter Departure',
                        hintStyle: TextStyle(
                          color: textLight,
                          fontWeight: FontWeight.normal,
                          fontSize: 18.0,
                        )),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () => setDate('Departure'),
                          child: IgnorePointer(
                            child: TextField(
                              style: textStyle,
                              controller: departureDateController,
                              decoration: InputDecoration(
                                  border: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          width: 1.0, color: textLight)),
                                  hintText: 'Enter Date',
                                  hintStyle: TextStyle(
                                    color: textLight,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 57.0,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => setTime('Departure'),
                          child: IgnorePointer(
                            child: TextField(
                              controller: departureTimeController,
                              style: textStyle,
                              decoration: InputDecoration(
                                  hintText: 'Enter Time',
                                  hintStyle: TextStyle(
                                    color: textLight,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: TextField(
                    controller: arrivalController,
                    onChanged: (v) => updateArrival(),
                    style: textStyle,
                    decoration: InputDecoration(
                        hintText: 'Enter Destination',
                        hintStyle: TextStyle(
                          color: textLight,
                          fontWeight: FontWeight.normal,
                          fontSize: 18.0,
                        )),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Expanded(
                        child: InkWell(
                          onTap: () => setDate('Arrival'),
                          child: IgnorePointer(
                            child: TextField(
                              controller: arrivalDateController,
                              style: textStyle,
                              decoration: InputDecoration(
                                  hintText: 'Enter Date',
                                  hintStyle: TextStyle(
                                    color: textLight,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0,
                                  )),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 57.0,
                      ),
                      Expanded(
                        child: InkWell(
                          onTap: () => setTime('Arrival'),
                          child: IgnorePointer(
                            child: TextField(
                              controller: arrivalTimeController,
                              style: textStyle,
                              decoration: InputDecoration(
                                  hintText: 'Enter Time',
                                  hintStyle: TextStyle(
                                    color: textLight,
                                    fontWeight: FontWeight.normal,
                                    fontSize: 18.0,
                                  )),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: DropdownButton<String>(
                    isExpanded: true,
                    style: textStyle,
                    hint: Text(
                      'Trip Type',
                      style: TextStyle(
                        color: textLight,
                        fontWeight: FontWeight.normal,
                        fontSize: 18.0,
                      ),
                    ),
                    items: _tripOptions.map((value) {
                      return DropdownMenuItem<String>(
                        child: Text(value),
                        value: value,
                      );
                    }).toList(),
                    value: retreiveTripType(trip.tripType),
                    icon: Image(
                      image: AssetImage('images/dropdown.png'),
                    ),
                    onChanged: (String value) => updateTripType(value),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30.0),
                  child: RaisedButton(
                    onPressed: () => save(),
                    color: business,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0)),
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 12.0),
                      child: Text(
                        setButtonText(trip.arrival),
                        style: GoogleFonts.nunito(
                            textStyle: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 18.0,
                        )),
                      ),
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }

  save() async {
    if (trip.id != null) {
      helper.updateTrip(trip);
    } else {
      helper.insertTrip(trip);
    }
    Navigator.pop(context, true);
  }

  String updateTitle(String arrival) {
    if(trip.id == null) {
      return 'Create a trip';
    } else {
      return 'Update trip to $arrival';
    }
  }

  String setButtonText(String arrival) {
    if (trip.id == null) {
      return 'Add trip';
    } else {
      return 'Update trip';
    }
  }

  updateDeparture() {
    trip.departure = departureController.text;
  }

  updateDepartureDate() {
    trip.departureDate = departureDateController.text;
  }

  updateDepartureTime() {
    trip.departureTime = departureTimeController.text;
  }

  updateArrival() {
    trip.arrival = arrivalController.text;
  }

  updateArrivalDate() {
    trip.arrivalDate = arrivalDateController.text;
  }

  updateArrivalTime() {
    trip.arrivalTime = arrivalTimeController.text;
  }

  updateTripType(String value) {
    if (value == 'Health') {
      trip.tripType = 'Medical';
    } else {
      trip.tripType = value;
    }
    setState(() {
      _tripOption = value;
    });
  }

  String retreiveTripType(String value) {
    if (value == 'Medical') {
      return 'Health';
    } else if (value.isEmpty) {
      return null;
    } else {
      return value;
    }
  }

  setDate(String type) async {
    DateTime endDate = type == 'Departure'
        ? DateTime.now().add(Duration(days: 7))
        : DateTime.now().add(Duration(days: 21));
    DateTime selected = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(Duration(days: 1)),
      firstDate: DateTime.now(),
      lastDate: endDate,
    );
    if (selected != null) {
      String date = DateFormat('EEE , dd MM yyyy').format(selected);
        if (type == 'Departure') {
          departureDateController.text = date;
        } else {
          arrivalDateController.text = date;
        }
    }
  }

  setTime(String type) async {
    TimeOfDay selected = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );

    if (selected != null) {
      final now = DateTime.now();
      final date = DateTime(
        now.year,
        now.month,
        now.day,
        selected.hour,
        selected.minute,
      );
      String time = DateFormat.jm().format(date).toLowerCase();
        if (type == 'Departure') {
          departureTimeController.text = time;
        } else {
          arrivalTimeController.text = time;
        }
    }
  }
}
