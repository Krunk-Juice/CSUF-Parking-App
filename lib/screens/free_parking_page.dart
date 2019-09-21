import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_parking_app/services/api_key.dart';

// void main() => runApp(MyApp());

const _pinkHue = 350.0;
final _placesApiClient = GoogleMapsPlaces(apiKey: googleMapsApiKey);

class FreeParkingPage extends StatelessWidget {

  static const String id = 'free_parking_locations';
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Free Parking',
      home: const MapPage(title: 'FREE PARKING'),
      theme: ThemeData(
        primarySwatch: Colors.pink,
        scaffoldBackgroundColor: Colors.pink[50],
      ),
    );
  }
}

class MapPage extends StatefulWidget {
  const MapPage({@required this.title});

  final String title;

  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  Stream<QuerySnapshot> _freeParkingLocations;
  final Completer<GoogleMapController> _mapController = Completer();

  @override
  void initState() {
    super.initState();
    _freeParkingLocations = Firestore.instance
        .collection('free_parking_locations')
        .orderBy('name')
        .snapshots();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: _freeParkingLocations,
        builder: (context, snapshot) {
          if (snapshot.hasError)
            return Center(child: Text('Error: ${snapshot.error}}'));
          if (!snapshot.hasData) return Center(child: Text('Loading...'));

          return Column(
            children: [
              Flexible(
                flex: 2,
                child: StoreMap(
                  documents: snapshot.data.documents,
                  initialPosition: const LatLng(37.7786, -122.4375),
                  mapController: _mapController,
                ),
              ),
              Flexible(
                  flex: 3,
                  child: StoreList(
                    documents: snapshot.data.documents,
                    mapController: _mapController,
                  )),
            ],
          );
        },
      ),
    );
  }
}

class StoreMap extends StatelessWidget {
  const StoreMap({
    Key key,
    @required this.documents,
    @required this.initialPosition,
    @required this.mapController,
  }) : super(key: key);

  final List<DocumentSnapshot> documents;
  final LatLng initialPosition;
  final Completer<GoogleMapController> mapController;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: initialPosition,
        zoom: 12,
      ),
      markers: documents
          .map((document) => Marker(
                markerId: MarkerId(document['placeId']),
                icon: BitmapDescriptor.defaultMarkerWithHue(_pinkHue),
                position: LatLng(
                  document['location'].latitude,
                  document['location'].longitude,
                ),
                infoWindow: InfoWindow(
                  title: document['name'],
                  snippet: document['address'],
                ),
              ))
          .toSet(),
      onMapCreated: (mapController) {
        this.mapController.complete(mapController);
      },
    );
  }
}

class StoreList extends StatelessWidget {
  const StoreList({
    Key key,
    @required this.documents,
    @required this.mapController,
  }) : super(key: key);

  final List<DocumentSnapshot> documents;
  final Completer<GoogleMapController> mapController;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: documents.length,
      itemBuilder: (builder, index) {
        final document = documents[index];
        return StoreListTile(
          document: document,
          mapController: mapController,
        );
      },
    );
  }
}

class StoreListTile extends StatefulWidget {
  const StoreListTile({
    Key key,
    @required this.document,
    @required this.mapController,
  }) : super(key: key);

  final DocumentSnapshot document;
  final Completer<GoogleMapController> mapController;

  @override
  _StoreListTileState createState() => _StoreListTileState();
}

class _StoreListTileState extends State<StoreListTile> {
  String _placePhotoUrl = '';
  bool _disposed = false;

  @override
  void initState() {
    super.initState();
    _retrievePlacesDetails();
  }

  @override
  void dispose() {
    _disposed = true;
    super.dispose();
  }

  Future<void> _retrievePlacesDetails() async {
    final details =
        await _placesApiClient.getDetailsByPlaceId(widget.document['placeId']);
    if (!_disposed) {
      setState(() {
        _placePhotoUrl = _placesApiClient.buildPhotoUrl(
          photoReference: details.result.photos[0].photoReference,
          maxHeight: 300,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.document['name']),
      subtitle: Text(widget.document['address']),
      leading: Container(
        child: _placePhotoUrl.isNotEmpty
            ? CircleAvatar(
                backgroundImage: NetworkImage(_placePhotoUrl),
              )
            : Container(),
        width: 60,
        height: 60,
      ),
      onTap: () async {
        final controller = await widget.mapController.future;
        await controller.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              target: LatLng(
                widget.document['location'].latitude,
                widget.document['location'].longitude,
              ),
              zoom: 16,
            ),
          ),
        );
      },
    );
  }
}
