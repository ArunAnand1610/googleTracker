import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:geocoder/geocoder.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googletracking_project/getxcontrollers/profilecontroller.dart';
import 'package:googletracking_project/model/usermodel.dart';

import 'package:googletracking_project/pages/profilepage.dart';
import 'package:googletracking_project/pages/searchplacescreen.dart';

import 'package:nb_utils/nb_utils.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({super.key});

  @override
  State<DashboardPage> createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  int i = 0;
  var accidentlatitude;
  var accidentlongitude;
  var currentlat;
  var currentlon;
  bool isreport = false;
  String? name;
  CameraPosition? kInitialPosition;
  String googleAPiKey = "AIzaSyAJmb-BORcD831wvfNF8fwPyZm8DvgLGFk";
  var distance;
  Set<Marker> markers = Set(); //markers for google map
  Map<PolylineId, Polyline> polylines = {};
  GoogleMapController? mapController; //contrller for Google map
  PolylinePoints polylinePoints = PolylinePoints();
  var accidentaddress;
  LatLng startLocation = const LatLng(27.6683619, 85.3101895);
  LatLng endLocation = const LatLng(27.6688312, 85.3077329);
  List accidentlists = [
    {
      "name": "A1",
      "mail": "a1@gmail.com",
      "mobile": "xxxxx-yyyy",
      "Emergency contact": "0000000000",
      "spot-latitude": "12.916522960627699",
      "spot-longitude": "79.13244847208261",
    },
    {
      "name": "A2",
      "mail": "a2@gmail.com",
      "mobile": "xxxxx-yyyy",
      "Emergency contact": "0000000000",
      "spot-latitude": "12.35903391693856",
      "spot-longitude": "79.34509232640266",
    },
    {
      "name": "A3",
      "mail": "a3@gmail.com",
      "mobile": "xxxxx-yyyy",
      "Emergency contact": "0000000000",
      "spot-latitude": "12.226227633807204",
      "spot-longitude": "79.07483395189047",
    },
    {
      "name": "A4",
      "mail": "a4@gmail.com",
      "mobile": "xxxxx-yyyy",
      "Emergency contact": "0000000000",
      "spot-latitude": "10.873681474189137",
      "spot-longitude": "78.70855651795864",
    },
    {
      "name": "A5",
      "mail": "a5@gmail.com",
      "mobile": "xxxxx-yyyy",
      "Emergency contact": "0000000000",
      "spot-latitude": "9.844395995561118",
      "spot-longitude": "78.48943144083023",
    }
  ];
  @override
  void initState() {
    super.initState();
    getUserCurrentLocation().then((value) => {
          setState(() {
            kInitialPosition = CameraPosition(
                target: LatLng(
                    value.latitude.toDouble(), value.longitude.toDouble()),
                zoom: 13.0);
            currentlat = value.latitude;
            currentlon = value.longitude;
            _getLocation(
                LatLng(value.latitude.toDouble(), value.longitude.toDouble()));
            setmarker();
          }),
          debugPrint("the current location is : $value"),
        });
    FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((value) {
      setState(() {
        name = value.get("role");
      });
    });
  }

  Future<Position> getUserCurrentLocation() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) async {
      await Geolocator.requestPermission();
      debugPrint("ERROR$error");
    });

    return await Geolocator.getCurrentPosition();
  }

  getDirections() async {
    List<LatLng> polylineCoordinates = [];

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      googleAPiKey,
      PointLatLng(currentlat, currentlon),
      PointLatLng(accidentlatitude, accidentlongitude),
      travelMode: TravelMode.driving,
    );
    if (result.points.isNotEmpty) {
      for (var point in result.points) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      }
    } else {
      debugPrint(result.errorMessage);
    }
    double totalDistance = 0;
    for (var i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
          polylineCoordinates[i].latitude,
          polylineCoordinates[i].longitude,
          polylineCoordinates[i + 1].latitude,
          polylineCoordinates[i + 1].longitude);
    }
    debugPrint("$totalDistance");

    setState(() {
      distance = totalDistance.toStringAsFixed(2);
    });
    addPolyLine(polylineCoordinates);
  }

  addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = const PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  _getLocation(LatLng pos) async {
    final coordinates = Coordinates(pos.latitude, pos.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);

    accidentaddress = addresses.first;
    debugPrint(
        " 1 ) ${accidentaddress.featureName} : ${accidentaddress.addressLine} , 2)  ${accidentaddress.adminArea} , 3) ${accidentaddress.coordinates} , 4) ${accidentaddress.countryCode} ,5) ${accidentaddress.countryName} , 6) ${accidentaddress.locality} ,7) ${accidentaddress.postalCode} , 8) ${accidentaddress.subAdminArea} ,9) ${accidentaddress.subLocality} , 10) ${accidentaddress.subThoroughfare}");
    debugPrint("the position is : $pos");

    setState(() {
      kInitialPosition = CameraPosition(
          target: LatLng(pos.latitude, pos.longitude), zoom: 20.0);
      // _lastTap = pos;
    });
    getDirections();
  }

  Future<LatLng> _getCoordinates(String address) async {
    final coordinates = await Geocoder.local.findAddressesFromQuery(address);
    final accidentaddress = coordinates.first;
    return LatLng(accidentaddress.coordinates.latitude!.toDouble(),
        accidentaddress.coordinates.longitude!.toDouble());
  }

  void _goToCurrentLocation() async {
    _getLocation(LatLng(currentlat, currentlon));
    kInitialPosition = CameraPosition(
      target: LatLng(currentlat, currentlon),
      zoom: 13,
    );
    mapController!
        .animateCamera(CameraUpdate.newCameraPosition(kInitialPosition!));
    setmarker();
  }

  setmarker() {
    startLocation = LatLng(currentlat, currentlon);
    markers.add(Marker(
      //add start location marker
      markerId: MarkerId(startLocation.toString()),
      position: startLocation, //position of marker
      infoWindow: const InfoWindow(
        //popup info
        title: 'Starting Point ',
        snippet: 'Start Marker',
      ),
      icon: BitmapDescriptor.defaultMarker, //Icon for Marker
    ));
    if (accidentlatitude != null && accidentlongitude != null) {
      endLocation = LatLng(accidentlatitude, accidentlongitude);
      markers.add(Marker(
        markerId: MarkerId(endLocation.toString()),
        position: endLocation,
        infoWindow: const InfoWindow(
          title: 'Destination Point ',
          snippet: 'Destination Marker',
        ),
        icon: BitmapDescriptor.defaultMarker,
      ));
      getDirections();
    }
  }

  double calculateDistance(lat1, lon1, lat2, lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    final Controller = Get.put(ProfileController());
    return SafeArea(
        child: Scaffold(
      drawer: Drawer(
        child: ProfilePage(),
      ),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(48),
        child: Container(
          height: 48,
          width: double.infinity,
          color: const Color.fromRGBO(40, 115, 240, 1),
          child: Container(
            margin: const EdgeInsets.only(right: 16),
            child: Row(
              // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {
                      _scaffoldKey.currentState!.openDrawer();
                    },
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 28,
                    )),
                Padding(
                  padding: EdgeInsets.only(left: 56.0),
                  child: Text(
                    "Hii ${name}",
                    style: TextStyle(
                        fontFamily: "Gortita",
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      key: _scaffoldKey,
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        child: Column(
          children: [
           
            /////////////....................... Ambulance...............////////
            Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12)),
              child: ListTile(
                leading: const SizedBox(
                    height: 30, width: 30, child: Icon(Icons.location_city)),
                title: Text(
                  "SearchNear by hospital",
                  style: GoogleFonts.rubik(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xff000000),
                  ),
                ),
                onTap: () {
                  Get.to(SearchPlacesScreen());
                },
              ),
            ),
//...................................User......................//

//....................................Police....................//
            Visibility(
              visible: name=="Police",
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                        "${accidentlists.length} Accidents near under your circle"),
                  ),
                  SizedBox(
                    height: 200,
                    child: kInitialPosition != null
                        ? GoogleMap(
                            onMapCreated: onMapCreated,
                            // mapToolbarEnabled: true,
                            initialCameraPosition: kInitialPosition!,
                            onTap: (LatLng pos) {
                              print("the tapped : $pos");
                            },
                            mapType: MapType.normal,
                            polylines: Set<Polyline>.of(polylines.values),
                            onLongPress: (LatLng pos) {
                              setState(() {
                                // _lastLongPress = pos;
                              });
                            },
                            buildingsEnabled: true,
                            trafficEnabled: true,
                            zoomControlsEnabled: false,
                            myLocationButtonEnabled: false,
                            myLocationEnabled: true,
                            markers: markers,
                          )
                        : Center(
                            child: CircularProgressIndicator(),
                          ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.8,
                    child: ListView.builder(
                        itemCount: accidentlists.length,
                        shrinkWrap: true,
                        itemBuilder: (c, i) {
                          return Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  accidentlatitude = double.parse(accidentlists[i]
                                          ["spot-latitude"]
                                      .toString());
                                  accidentlongitude = double.parse(
                                      accidentlists[i]["spot-longitude"]
                                          .toString());
                                });
                                _getLocation(
                                    LatLng(accidentlatitude, accidentlongitude));
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text("Name ${accidentlists[i]["name"]}"),
                                      Text("mail ${accidentlists[i]["mail"]}"),
                                      Text(
                                          "Mobile ${accidentlists[i]["mobile"]}"),
                                      Text(
                                          "Emergency contact ${accidentlists[i]["Emergency contact"]}")
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    ));
  }
}

Future<void> onMapCreated(GoogleMapController controller) async {
  debugPrint("the controllers called");
}
