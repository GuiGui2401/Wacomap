import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  final LatLng? initialPosition;

  HomePage({Key? key, this.initialPosition}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late GoogleMapController mapController;
  LatLng _initialPosition =
      const LatLng(37.7749, -122.4194); // Default to San Francisco
  bool _isMapInitialized = false;
  LatLng? _currentPosition;
  double? distance;
  final String _googleApiKey =
      'AIzaSyD0kO0ws5BJIYgvWhT3Q0PDhl_La6Vw_S8'; // Replace with your API key

  // List of markers to be placed on the map
  final List<Marker> _markers = [
    Marker(
      markerId: MarkerId('marker_1'),
      position: LatLng(3.8527005288496983, 11.499877904200474), // San Francisco
      infoWindow: InfoWindow(
        title: 'Dispositif alpha',
        snippet: 'Details about Dispositif alpha',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_2'),
      position: LatLng(3.8517906382215332, 11.496273015511457), // Los Angeles
      infoWindow: InfoWindow(
        title: 'Dispositif Beta',
        snippet: 'Details about Dispositif Beta',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_3'),
      position: LatLng(3.8490288466472458, 11.50057527850416), // New York
      infoWindow: InfoWindow(
        title: 'Dispositif gamma',
        snippet: 'Details about Dispositif gamma',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_4'),
      position: LatLng(3.8530005288496983, 11.498877904200474),
      infoWindow: InfoWindow(
        title: 'Dispositif delta',
        snippet: 'Details about Dispositif delta',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_5'),
      position: LatLng(3.8500006382215332, 11.497000015511457),
      infoWindow: InfoWindow(
        title: 'Dispositif epsilon',
        snippet: 'Details about Dispositif epsilon',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_6'),
      position: LatLng(3.8480008466472458, 11.50100027850416),
      infoWindow: InfoWindow(
        title: 'Dispositif zeta',
        snippet: 'Details about Dispositif zeta',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_7'),
      position: LatLng(3.8522005288496983, 11.499077904200474),
      infoWindow: InfoWindow(
        title: 'Dispositif eta',
        snippet: 'Details about Dispositif eta',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_8'),
      position: LatLng(3.8510006382215332, 11.495273015511457),
      infoWindow: InfoWindow(
        title: 'Dispositif theta',
        snippet: 'Details about Dispositif theta',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_9'),
      position: LatLng(3.8495008466472458, 11.49977527850416),
      infoWindow: InfoWindow(
        title: 'Dispositif iota',
        snippet: 'Details about Dispositif iota',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_10'),
      position: LatLng(3.8525005288496983, 11.500877904200474),
      infoWindow: InfoWindow(
        title: 'Dispositif kappa',
        snippet: 'Details about Dispositif kappa',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_11'),
      position: LatLng(3.8505006382215332, 11.496500015511457),
      infoWindow: InfoWindow(
        title: 'Dispositif lambda',
        snippet: 'Details about Dispositif lambda',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_12'),
      position: LatLng(3.8485008466472458, 11.50257527850416),
      infoWindow: InfoWindow(
        title: 'Dispositif mu',
        snippet: 'Details about Dispositif mu',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_13'),
      position: LatLng(3.8532005288496983, 11.498077904200474),
      infoWindow: InfoWindow(
        title: 'Dispositif nu',
        snippet: 'Details about Dispositif nu',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_14'),
      position: LatLng(3.8502006382215332, 11.497000015511457),
      infoWindow: InfoWindow(
        title: 'Dispositif xi',
        snippet: 'Details about Dispositif xi',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_15'),
      position: LatLng(3.8492008466472458, 11.50157527850416),
      infoWindow: InfoWindow(
        title: 'Dispositif omicron',
        snippet: 'Details about Dispositif omicron',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_16'),
      position: LatLng(3.8528005288496983, 11.498877904200474),
      infoWindow: InfoWindow(
        title: 'Dispositif pi',
        snippet: 'Details about Dispositif pi',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_17'),
      position: LatLng(3.8508006382215332, 11.497773015511457),
      infoWindow: InfoWindow(
        title: 'Dispositif rho',
        snippet: 'Details about Dispositif rho',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_18'),
      position: LatLng(3.8498008466472458, 11.50057527850416),
      infoWindow: InfoWindow(
        title: 'Dispositif sigma',
        snippet: 'Details about Dispositif sigma',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_19'),
      position: LatLng(3.8534005288496983, 11.498377904200474),
      infoWindow: InfoWindow(
        title: 'Dispositif tau',
        snippet: 'Details about Dispositif tau',
      ),
    ),
    Marker(
      markerId: MarkerId('marker_20'),
      position: LatLng(3.8512006382215332, 11.496773015511457),
      infoWindow: InfoWindow(
        title: 'Dispositif upsilon',
        snippet: 'Details about Dispositif upsilon',
      ),
    ),
  ];
  final List<Map<String, dynamic>> _markersData = [
    {
      'marker': Marker(
        markerId: MarkerId('marker_1'),
        position: LatLng(3.8527005288496983, 11.499877904200474),
        infoWindow: InfoWindow(
          title: 'Dispositif alpha',
          snippet: 'Details about Dispositif alpha',
        ),
      ),
      'tag': 'Tag 1',
      'imageUrl':
          'https://qualitywatertreatment.com/cdn/shop/products/portable-structured-water-device-by-natural-action-technologies-484316_1024x1024.jpg?v=1686164435',
      'position': '3.8527005288496983, 11.499877904200474'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_2'),
        position: LatLng(3.8517906382215332, 11.496273015511457),
        infoWindow: InfoWindow(
          title: 'Dispositif Beta',
          snippet: 'Details about Dispositif Beta',
        ),
      ),
      'tag': 'Tag 2',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQw5H5ejIZTrZdfG5NpW4O9Oo2-tQsaid0Bzw&s',
      'position': '3.8517906382215332, 11.496273015511457'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_3'),
        position: LatLng(3.8490288466472458, 11.50057527850416),
        infoWindow: InfoWindow(
          title: 'Dispositif gamma',
          snippet: 'Details about Dispositif gamma',
        ),
      ),
      'tag': 'Tag 3',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ2m8Dk9d6hNORhUDYoh6XnTVmP3tc-AM6Og&s',
      'position': '3.8490288466472458, 11.50057527850416'
    },
    // Additional markers
    {
      'marker': Marker(
        markerId: MarkerId('marker_4'),
        position: LatLng(3.8530005288496983, 11.498877904200474),
        infoWindow: InfoWindow(
          title: 'Dispositif delta',
          snippet: 'Details about Dispositif delta',
        ),
      ),
      'tag': 'Tag 4',
      'imageUrl':
          'https://thewatermachine.com/cdn/shop/products/WATERMACHINEPic_600x600.png?v=1668979865',
      'position': '3.8530005288496983, 11.498877904200474'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_5'),
        position: LatLng(3.8500006382215332, 11.497000015511457),
        infoWindow: InfoWindow(
          title: 'Dispositif epsilon',
          snippet: 'Details about Dispositif epsilon',
        ),
      ),
      'tag': 'Tag 5',
      'imageUrl':
          'https://cdn.thewirecutter.com/wp-content/media/2022/05/smart-water-leak-detector-2048px-5218-3x2-1.jpg?auto=webp&quality=75&crop=1.91:1&width=1200',
      'position': '3.8500006382215332, 11.497000015511457'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_6'),
        position: LatLng(3.8480008466472458, 11.50100027850416),
        infoWindow: InfoWindow(
          title: 'Dispositif zeta',
          snippet: 'Details about Dispositif zeta',
        ),
      ),
      'tag': 'Tag 6',
      'imageUrl':
          'https://newater.com/wp-content/uploads/2021/06/Water-Purification-Equipment-1.jpg',
      'position': '3.8480008466472458, 11.50100027850416'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_7'),
        position: LatLng(3.8522005288496983, 11.499077904200474),
        infoWindow: InfoWindow(
          title: 'Dispositif eta',
          snippet: 'Details about Dispositif eta',
        ),
      ),
      'tag': 'Tag 7',
      'imageUrl':
          'https://aqua-waterfilter.com/wp-content/uploads/2022/03/%D8%AF%D9%83%D8%AA%D9%88%D8%B1-%D9%88%D9%88%D8%AA%D8%B1.webp',
      'position': '3.8522005288496983, 11.499077904200474'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_8'),
        position: LatLng(3.8510006382215332, 11.495273015511457),
        infoWindow: InfoWindow(
          title: 'Dispositif theta',
          snippet: 'Details about Dispositif theta',
        ),
      ),
      'tag': 'Tag 8',
      'imageUrl':
          'https://i.pcmag.com/imagery/reviews/05qHubkeqL1k5hy54lntEWP-2.fit_lim.size_1050x.png',
      'position': '3.8510006382215332, 11.495273015511457'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_9'),
        position: LatLng(3.8495008466472458, 11.49977527850416),
        infoWindow: InfoWindow(
          title: 'Dispositif iota',
          snippet: 'Details about Dispositif iota',
        ),
      ),
      'tag': 'Tag 9',
      'imageUrl':
          'https://img.etimg.com/thumb/width-1200,height-900,imgsize-169675,resizemode-75,msid-46804392/magazines/panache/how-to-save-your-phone-if-you-dropped-it-in-water.jpg',
      'position': '3.8495008466472458, 11.49977527850416'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_10'),
        position: LatLng(3.8525005288496983, 11.500877904200474),
        infoWindow: InfoWindow(
          title: 'Dispositif kappa',
          snippet: 'Details about Dispositif kappa',
        ),
      ),
      'tag': 'Tag 10',
      'imageUrl':
          'https://media.easy.co.il/images/UserThumbs/10073649_1644306780547.jpeg',
      'position': '3.8525005288496983, 11.500877904200474'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_11'),
        position: LatLng(3.8505006382215332, 11.496500015511457),
        infoWindow: InfoWindow(
          title: 'Dispositif lambda',
          snippet: 'Details about Dispositif lambda',
        ),
      ),
      'tag': 'Tag 11',
      'imageUrl':
          'https://cdn.shopify.com/s/files/1/0078/6156/7570/files/K19-H.png?v=1679639948',
      'position': '3.8505006382215332, 11.496500015511457'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_12'),
        position: LatLng(3.8485008466472458, 11.50257527850416),
        infoWindow: InfoWindow(
          title: 'Dispositif mu',
          snippet: 'Details about Dispositif mu',
        ),
      ),
      'tag': 'Tag 12',
      'imageUrl':
          'https://wp.culligan.com/wp-content/uploads/2021/06/Aquasential%C2%AE-Reverse-Osmosis-Drinking-Water-System.png?quality=80',
      'position': '3.8485008466472458, 11.50257527850416'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_13'),
        position: LatLng(3.8532005288496983, 11.498077904200474),
        infoWindow: InfoWindow(
          title: 'Dispositif nu',
          snippet: 'Details about Dispositif nu',
        ),
      ),
      'tag': 'Tag 13',
      'imageUrl': 'https://www.envest.com.tr/dosya/aqua_cnt22.png',
      'position': '3.8532005288496983, 11.498077904200474'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_14'),
        position: LatLng(3.8502006382215332, 11.497000015511457),
        infoWindow: InfoWindow(
          title: 'Dispositif xi',
          snippet: 'Details about Dispositif xi',
        ),
      ),
      'tag': 'Tag 14',
      'imageUrl':
          'https://cdn.shopify.com/s/files/1/0534/0993/9642/files/freestandingwatercoolerdispenser_375b49ab-4fe9-492a-b22b-ae7f522b6042_480x480.png?v=1636373905',
      'position': '3.8502006382215332, 11.497000015511457'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_15'),
        position: LatLng(3.8492008466472458, 11.50157527850416),
        infoWindow: InfoWindow(
          title: 'Dispositif omicron',
          snippet: 'Details about Dispositif omicron',
        ),
      ),
      'tag': 'Tag 15',
      'imageUrl':
          'https://cdn.thewirecutter.com/wp-content/media/2022/05/smart-water-leak-detector-2048px-5218-3x2-1.jpg?auto=webp&quality=75&crop=1.91:1&width=1200',
      'position': '3.8492008466472458, 11.50157527850416'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_16'),
        position: LatLng(3.8528005288496983, 11.498877904200474),
        infoWindow: InfoWindow(
          title: 'Dispositif pi',
          snippet: 'Details about Dispositif pi',
        ),
      ),
      'tag': 'Tag 16',
      'imageUrl':
          'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSK1xB8NmICudXUovVEPOkqyFrN_swHqBChYQ&s',
      'position': '3.8528005288496983, 11.498877904200474'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_17'),
        position: LatLng(3.8508006382215332, 11.497773015511457),
        infoWindow: InfoWindow(
          title: 'Dispositif rho',
          snippet: 'Details about Dispositif rho',
        ),
      ),
      'tag': 'Tag 17',
      'imageUrl':
          'https://thetradetable.com/cdn/shop/collections/Structured_Water_Device_1024x1024.jpg?v=1701983473',
      'position': '3.8508006382215332, 11.497773015511457'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_18'),
        position: LatLng(3.8498008466472458, 11.50057527850416),
        infoWindow: InfoWindow(
          title: 'Dispositif sigma',
          snippet: 'Details about Dispositif sigma',
        ),
      ),
      'tag': 'Tag 18',
      'imageUrl':
          'https://thetradetable.com/cdn/shop/collections/Structured_Water_Device_1024x1024.jpg?v=1701983473',
      'position': '3.8498008466472458, 11.50057527850416'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_19'),
        position: LatLng(3.8534005288496983, 11.498377904200474),
        infoWindow: InfoWindow(
          title: 'Dispositif tau',
          snippet: 'Details about Dispositif tau',
        ),
      ),
      'tag': 'Tag 19',
      'imageUrl':
          'https://cdn.thewirecutter.com/wp-content/media/2022/05/smart-water-leak-detector-2048px-5218-3x2-1.jpg?auto=webp&quality=75&crop=1.91:1&width=1200',
      'position': '3.8534005288496983, 11.498377904200474'
    },
    {
      'marker': Marker(
        markerId: MarkerId('marker_20'),
        position: LatLng(3.8512006382215332, 11.496773015511457),
        infoWindow: InfoWindow(
          title: 'Dispositif upsilon',
          snippet: 'Details about Dispositif upsilon',
        ),
      ),
      'tag': 'Tag 20',
      'imageUrl':
          'https://cdn.thewirecutter.com/wp-content/media/2024/04/smartleakdetectors-2048px-08157.jpg',
      'position': '3.8512006382215332, 11.496773015511457'
    },
  ];

  Set<Polyline> _polylines = {};
  MarkerId? _selectedMarkerId;

  @override
  void initState() {
    super.initState();
    _getUserLocation();
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
    if (_isMapInitialized) {
      mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(target: _initialPosition, zoom: 14.0),
        ),
      );
    }
  }

  Future<void> _getUserLocation() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Check if location services are enabled
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    // Request location permission
    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied.');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error('Location permissions are permanently denied.');
    }

    // Get the current location
    Position position = await Geolocator.getCurrentPosition(
        desiredAccuracy: LocationAccuracy.high);

    setState(() {
      _initialPosition = LatLng(position.latitude, position.longitude);
      _currentPosition = _initialPosition;
      _isMapInitialized = true;
      // Update camera position if the map has been created
      if (mapController != null) {
        mapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(target: _initialPosition, zoom: 14.0),
          ),
        );
      }
    });
  }

  void _calculateDistance() {
    if (_selectedMarkerId != null) {
      // Use the distance as needed
    }
  }

  void _onMarkerTapped(MarkerId markerId, LatLng markerPosition) async {
    if (_currentPosition != null) {
      //double distance = calculateDistance(_currentPosition, marker.position);
      distance = calculateDistance(_currentPosition, markerPosition);

      await _getRoute(_currentPosition!, markerPosition);
      setState(() {
        _selectedMarkerId = markerId;
      });
    }
  }

  Future<void> _getRoute(LatLng start, LatLng end) async {
    // Build the API URL
    String url =
        'https://maps.googleapis.com/maps/api/directions/json?origin=${start.latitude},${start.longitude}&destination=${end.latitude},${end.longitude}&key=$_googleApiKey';

    // Make the API call
    http.Response response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);

      if (data['routes'].isNotEmpty) {
        // Get the route's polyline points
        String polyline = data['routes'][0]['overview_polyline']['points'];

        // Decode the polyline
        List<LatLng> routePoints = _decodePolyline(polyline);

        setState(() {
          _polylines.clear(); // Clear any existing polylines
          _polylines.add(Polyline(
            polylineId: PolylineId('route'),
            visible: true,
            points: routePoints,
            color: Colors.blue,
            width: 5,
          ));
        });
      }
    } else {
      print("Failed to fetch route: ${response.statusCode}");
    }
  }

  List<LatLng> _decodePolyline(String polyline) {
    List<LatLng> points = [];
    int index = 0, len = polyline.length;
    int lat = 0, lng = 0;

    while (index < len) {
      int b, shift = 0, result = 0;

      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlat = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lat += dlat;

      shift = 0;
      result = 0;

      do {
        b = polyline.codeUnitAt(index++) - 63;
        result |= (b & 0x1f) << shift;
        shift += 5;
      } while (b >= 0x20);

      int dlng = ((result & 1) != 0 ? ~(result >> 1) : (result >> 1));
      lng += dlng;

      points.add(LatLng(lat / 1e5, lng / 1e5));
    }

    return points;
  }

  double? calculateDistance(LatLng? currentPosition, LatLng polylinePoint) {
    if (currentPosition == null) {
      return null; // or handle null case as needed
    }

    return Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      polylinePoint.latitude,
      polylinePoint.longitude,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        onMapCreated: _onMapCreated,
        initialCameraPosition: CameraPosition(
          target: _initialPosition,
          zoom: 11.0,
        ),
        markers: Set.from(_markers.map((marker) {
          return marker.copyWith(
            onTapParam: () => _onMarkerTapped(marker.markerId, marker.position),
          );
        }).toList()), // Add the markers to the map
        polylines: _polylines, // Show the traced route
        myLocationEnabled: true, // Show the user's current location on the map
      ),
      bottomSheet: _selectedMarkerId != null
          ? Container(
              width: MediaQuery.of(context).size.width -
                  32.0, // Adjust for padding or margins if needed
              padding: EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius:
                    BorderRadius.circular(12.0), // Adjust the radius as needed
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Changes the position of the shadow
                  ),
                ],
              ),
              child: Row(
                children: [
                  // Marker image
                  Image.network(
                    _markersData.firstWhere((data) =>
                        data['marker'].markerId ==
                        _selectedMarkerId)['imageUrl'],
                    width: 50.0, // Adjust size as needed
                    height: 50.0, // Adjust size as needed
                    fit: BoxFit.cover,
                  ),
                  SizedBox(width: 10.0), // Space between image and text
                  // Marker information text
                  Expanded(
                    child: Text(
                      _markersData
                                  .firstWhere((data) =>
                                      data['marker'].markerId ==
                                      _selectedMarkerId)['marker']
                                  .infoWindow
                                  .snippet +
                              "       Distance:" +
                              distance?.toStringAsFixed(2) +
                              "m" ??
                          '',
                      style: TextStyle(fontSize: 16),
                    ),
                  ),
                ],
              ),
            )
          : null,
    );
  }
}
