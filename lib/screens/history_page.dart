import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> markersData;

  HistoryPage({required this.markersData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Markers List'),
      ),
      body: ListView.builder(
        itemCount: markersData.length,
        itemBuilder: (context, index) {
          final markerData = markersData[index];
          final marker = markerData['marker'] as Marker;
          final imageUrl = markerData['imageUrl'] as String;
          final tag = markerData['tag'] as String;
          final position = markerData['position'] as String;

          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              leading: Image.network(
                imageUrl,
                width: 50.0,
                height: 50.0,
                fit: BoxFit.cover,
              ),
              title: Text(marker.infoWindow.title ?? 'Unknown Marker'),
              subtitle: Text(tag + ": POSITION-" + position),
              onTap: () {
                // On tap, navigate to the marker on the map (if needed)
              },
            ),
          );
        },
      ),
    );
  }
}
