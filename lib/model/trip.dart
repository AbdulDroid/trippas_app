class Trip {
  int _id;
  String _arrival;
  String _departure;
  String _departureDate;
  String _departureTime;
  String _arrivalTime;
  String _arrivalDate;
  String _tripType;

  Trip(
    this._arrival,
    this._departure,
    this._arrivalDate,
    this._arrivalTime,
    this._departureDate,
    this._departureTime,
    this._tripType,
  );

  Trip.withId(
    this._id,
    this._arrival,
    this._departure,
    this._arrivalDate,
    this._arrivalTime,
    this._departureDate,
    this._departureTime,
    this._tripType,
  );

  int get id => _id;

  String get arrival => _arrival;

  String get departure => _departure;

  String get arrivalDate => _arrivalDate;

  String get arrivalTime => _arrivalTime;

  String get tripType => _tripType;

  String get departureTime => _departureTime;

  String get departureDate => _departureDate;

  set arrival(String newArrival) {
    if (newArrival.isNotEmpty) _arrival = newArrival;
  }

  set departure(String newDeparture) {
    if (newDeparture.isNotEmpty) _departure = newDeparture;
  }

  set arrivalDate(String newArrivalDate) {
    if (newArrivalDate.isNotEmpty) _arrivalDate = newArrivalDate;
  }

  set arrivalTime(String newArrivalTime) {
    if (newArrivalTime.isNotEmpty) _arrivalTime = newArrivalTime;
  }

  set tripType(String newTripType) {
    if (newTripType.isNotEmpty) _tripType = newTripType;
  }

  set departureTime(String newDepartureTime) {
    if (newDepartureTime.isNotEmpty) _departureTime = newDepartureTime;
  }

  set departureDate(String newDepartureDate) {
    if (newDepartureDate.isNotEmpty) _departureDate = newDepartureDate;
  }

  @override
  toString() {
    return '{\'id\':\'$_id\',\'arrival\':\'$_arrival\',\'departure\':\'$_departure\',\'arrival_date\':\'$_arrivalDate\',' +
        '\'arrival_time\':\'$_arrivalTime\',\'departure_date\':\'$_departureDate\',\'departure_time\':\'$_departureTime\',' +
        '\'trip_type\':\'$_tripType\'}';
  }

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map['arrival'] = _arrival;
    map['departure'] = _departure;
    map['arrival_date'] = _arrivalDate;
    map['arrival_time'] = _arrivalTime;
    map['departure_date'] = _departureDate;
    map['departure_time'] = _departureTime;
    map['trip_type'] = _tripType;

    if (_id != null) {
      map['id'] = _id;
    }

    return map;
  }

  Trip.fromObject(dynamic map) {
    this._arrival = map['arrival'];
    this._arrivalDate = map['arrival_date'];
    this._arrivalTime = map['arrival_time'];
    this.departure = map['departure'];
    this._departureDate = map['departure_date'];
    this._departureTime = map['departure_time'];
    this._tripType = map['trip_type'];
    this._id = map['id'];
  }
}
