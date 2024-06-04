


import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geocoding/geocoding.dart' as geocoding;

class SelectedResponsesLocationScreen extends StatefulWidget {
  final List<String> selectedResponses;

  SelectedResponsesLocationScreen(this.selectedResponses);

  @override
  _SelectedResponsesLocationScreenState createState() => _SelectedResponsesLocationScreenState();
}

class _SelectedResponsesLocationScreenState extends State<SelectedResponsesLocationScreen> {
  late GoogleMapController _mapController;
  final List<Map<String, dynamic>> _locations = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _geocodeLocations();
  }

  Future<void> _geocodeLocations() async {
    for (String location in widget.selectedResponses) {
      try {
        List<geocoding.Location> locations = await geocoding.locationFromAddress(location);
        if (locations.isNotEmpty) {
          setState(() {
            _locations.add({
              'name': location,
              'latLng': LatLng(locations.first.latitude, locations.first.longitude)
            });
          });
        }
      } catch (e) {
        print('Failed to geocode location: $location');
      }
    }
    setState(() {
      _isLoading = false;
    });
  }

  void _printLocations() {
    for (var location in _locations) {
      print('Location: ${location['name']}, Coordinates: ${location['latLng'].latitude}, ${location['latLng'].longitude}');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Responses'),
        actions: [
          IconButton(
            icon: Icon(Icons.print),
            onPressed: _printLocations,
          ),
        ],
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
        children: [
          Expanded(
            child: _locations.isEmpty
                ? Center(child: Text('No valid locations to display on the map.'))
                : GoogleMap(
              onMapCreated: (controller) {
                _mapController = controller;
              },
              initialCameraPosition: CameraPosition(
                target: _locations[0]['latLng'],
                zoom: 10,
              ),
              markers: _createMarkers(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _locations.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(_locations[index]['name']),
                  subtitle: Text('Lat: ${_locations[index]['latLng'].latitude}, Lng: ${_locations[index]['latLng'].longitude}'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Set<Marker> _createMarkers() {
    return _locations.map((location) {
      return Marker(
        markerId: MarkerId(location['latLng'].toString()),
        position: location['latLng'],
        infoWindow: InfoWindow(title: location['name']),
      );
    }).toSet();
  }
}


