import 'dart:async';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_parking_app/services/api_key.dart';

// void main() => runApp(MyApp());

const _pinkHue = 350.0;
final _placesApiClient = GoogleMapsPlaces(apiKey: googleMapsApiKey);


class FreeParkingMap extends StatefulWidget {
  static const String id = 'free_parking_map';
  // const MapPage({@required this.title});

  // final String title;

  @override
  _FreeParkingMapState createState() => _FreeParkingMapState();
}

class _FreeParkingMapState extends State<FreeParkingMap> {
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0.0,
        backgroundColor: Colors.white,
        leading: IconButton(
          color: Colors.black,
          onPressed: () => Navigator.of(context).pop(),
          icon: Icon(Icons.arrow_back, color: Colors.black),
        ),
        title: Text('Free Parking Locations',
            style: TextStyle(color: Colors.black, fontWeight: FontWeight.w700)),
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
                
                flex: 3,
                child: StoreMap(
                  documents: snapshot.data.documents,
                  initialPosition: const LatLng(33.881356, -117.885364),
                  mapController: _mapController,
                ),
              ),
              Flexible(
                  flex: 2,
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
        zoom: 13,
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
    return Card(
      elevation: 14.0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      
      child: ListTile(
        title: Text(widget.document['name'],style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
        subtitle: Text(widget.document['address']),
        leading: Container(
          child: _placePhotoUrl.isNotEmpty
              ? CircleAvatar(
                  backgroundImage: NetworkImage(_placePhotoUrl),
                )
              : Material(
                            color: Colors.greenAccent,
                            borderRadius: BorderRadius.circular(24.0),
                            child: Center(
                                child: Padding(
                              padding: EdgeInsets.all(16.0),
                              child: Icon(Icons.directions,
                                  color: Colors.white, size: 30.0),
                            ))),
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
                zoom: 15,
              ),
            ),
          );
        },
      ),
    );
  }
}
