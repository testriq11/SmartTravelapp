import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class BookingScreen1 extends StatefulWidget {
  BookingScreen1({Key? key}) : super(key: key);

  @override
  _BookingScreen1State createState() => _BookingScreen1State();
}


class _BookingScreen1State extends State<BookingScreen1> {
  List<String> responses = [];
  late String prompt;
  late String destination1;
  late String destination2;
  late String promptLocation;
  int titleId = 0;
  StreamController<List<Map<String, dynamic>>> _controller =
  StreamController<List<Map<String, dynamic>>>();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map arguments =
    ModalRoute.of(context)!.settings.arguments as Map;
    responses = arguments['responses'] ?? [];
    prompt = arguments['prompt'] ?? ''; // Initialize prompt value
    destination1 = extractDestination(
        prompt, 'I am planning to visit from', 'to');
    destination2 = extractDestination(prompt, 'to', 'by road');
    print('Des1:$destination1');
    print('Des:2$destination2');
    promptLocation = '$destination1 to $destination2';
    print('Prompt Loc: $promptLocation');

    // saveResponsesToDatabase(responses);
    insertTitleDatabase(promptLocation).then((id) {
      setState(() {
        titleId = id; // Set the title ID
      });
      saveResponsesToDatabase(responses, titleId); // Pass titleId here
    });

    // Fetch responses initially after a delay of 10 seconds
    Future.delayed(Duration(seconds: 10), () {
      fetchResponses();
    });
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Schedule to fetch responses every 10 to 15 seconds
    Timer.periodic(Duration(seconds: 15), (timer) {
      fetchResponses();
    });
  }

  Future<int> insertTitleDatabase(String promptLocation) async {
    final String apiUrl =
        'https://42d7-202-179-91-72.ngrok-free.app/destination_title/insertTitle'; // Change the URL to your server URL

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, dynamic>{
          'destination_title': promptLocation,
        }),
      );

      final responseData = jsonDecode(response.body); // Parse response body

      if (response.statusCode == 200) {
        print('Title saved successfully');
        return responseData['insertId']; // Return the ID of the inserted title
      } else {
        print(
            'Failed to save title. Error: ${responseData['error']}'); // Print error from server
        throw Exception(responseData['error']);
      }
    } catch (e) {
      print('Failed to connect to the server. Error: $e');
      throw e;
    }
  }

  Future<List<Map<String, dynamic>>> fetchResponses() async {
    final String url =
        'https://42d7-202-179-91-72.ngrok-free.app/fetch_route/responses'; // Update the URL to match your server endpoint

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        // If the server returns a successful response, parse the JSON
        List<dynamic> responseData = json.decode(response.body);

        // Map each response part to a Map
        List<Map<String, dynamic>> mappedResponse = responseData.map((part) {
          return {
            'cardIndex': part['cardIndex'],
            'text': part['text']
          };
        }).toList();

        _controller.add(mappedResponse);

        return mappedResponse;
      } else {
        // If the server returns an error response, throw an exception
        throw Exception('Failed to load responses: ${response.statusCode}');
      }
    } catch (error) {
      // If an error occurs during the HTTP request, throw an exception
      throw Exception('Failed to load responses: $error');
    }
  }

  Future<void> saveResponsesToDatabase(
      List<String> responses, int titleId) async {
    final String apiUrl =
        'https://42d7-202-179-91-72.ngrok-free.app/des_open_ai_response/saveResponses'; // Change the URL to your server URL

    try {
      for (String response in responses) {
        final responseList = response.split('\n'); // Split response by newline

        for (String singleResponse in responseList) {
          final responsePart = singleResponse.trim();
          final response = await http.post(
            Uri.parse(apiUrl),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'response_text': responsePart,
              'title_id': titleId, // Send title ID along with the response
            }),
          );

          final responseData = jsonDecode(response.body); // Parse response body

          if (response.statusCode == 200) {
            print('Response "$responsePart" saved successfully');
          } else {
            print(
                'Failed to save response "$responsePart". Error: ${responseData['error']}'); // Print error from server
          }
        }
      }
    } catch (e) {
      print('Failed to connect to the server. Error: $e');
    }
  }

  String extractDestination(String prompt, String from, String to) {
    final startIndex = prompt.indexOf(from) + from.length;
    final endIndex = prompt.indexOf(to, startIndex);
    return prompt.substring(startIndex, endIndex).trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Screen'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: _controller.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          } else {
            List<Map<String, dynamic>>? responses = snapshot.data;

            if (responses == null || responses.isEmpty) {
              return Center(
                child: Text('No data available'),
              );
            }

            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: responses.map((response) {
                  return _buildCard(response, withCheckbox: true);
                }).toList(),
              ),
            );
          }
        },
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> response, {bool withCheckbox = true}) {
    String? journey = response['journey'];
    List<String> contents = [];

    if (response['text'] != null) {
      if (response['text'] is String) {
        contents = (response['text'] as String)
            .split('\n')
            .map((e) => e.trim())
            .toList();
      } else {
        contents =
            List<String>.from(response['text']).map((e) => e.toString()).toList();
      }
    }

    List<Widget> placeWidgets = [];

    for (var i = 0; i < contents.length; i++) {
      String place = contents[i];
      if (place.isNotEmpty) {
        Widget widgetToAdd;
        if (i == 0) {
          widgetToAdd = Row(
            children: [
              if (withCheckbox)
                Checkbox(
                  value: true, // Change this value to manage checkbox state
                  onChanged: (bool? value) {
                    // Implement logic to handle checkbox state change
                  },
                ),
              SizedBox(width: 10), // Added SizedBox to provide space between checkbox and text
              Expanded(
                child: Text(place),
              ),
            ],
          );
        } else {
          widgetToAdd = Padding(
            padding: const EdgeInsets.only(left: 25.0), // Added padding to align the response text
            child: Text(place),
          );
        }
        placeWidgets.add(widgetToAdd);
      }
    }

    if (placeWidgets.isEmpty) {
      return SizedBox(); // Return an empty SizedBox if there are no placeWidgets
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (journey != null) Text(journey),
            SizedBox(height: 5),
            ...placeWidgets,
          ],
        ),
      ),
    );
  }
}



  // Widget build(BuildContext context) {
  //   List<LatLng> locations = [];
  //
  //   responses.forEach((response) {
  //     List<String> sections = response.split('\n\n');
  //     List<String> places = sections.sublist(1);
  //     places.forEach((place) {
  //       List<String> data = place.split(',');
  //       if (data.length >= 3) {
  //         String placeName = data[0].trim();
  //         double latitude = double.tryParse(data[1].trim()) ?? 0.0;
  //         double longitude = double.tryParse(data[2].trim()) ?? 0.0;
  //         locations.add(LatLng(latitude, longitude));
  //       }
  //     });
  //   });
  //
  //   return Scaffold(
  //     appBar: AppBar(
  //       title: Text('Booking Screen'),
  //     ),
  //     body: Column(
  //       crossAxisAlignment: CrossAxisAlignment.start,
  //       children: [
  //         Expanded(
  //           child: SingleChildScrollView(
  //             child: Column(
  //               mainAxisAlignment: MainAxisAlignment.center,
  //               children: [
  //                 SizedBox(height: 20),
  //                 Text('Searched Places'),
  //                 SizedBox(height: 10),
  //                 Column(
  //                   children: responses.map((response) {
  //                     List<String> sections = response.split('\n\n');
  //                     String title = sections.first;
  //                     List<String> places = sections.sublist(1);
  //
  //                     return Card(
  //                       child: Column(
  //                         crossAxisAlignment: CrossAxisAlignment.start,
  //                         children: [
  //                           Padding(
  //                             padding: EdgeInsets.all(8.0),
  //                             child: Text(
  //                               title,
  //                               style: TextStyle(fontWeight: FontWeight.bold),
  //                             ),
  //                           ),
  //                           Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: places.map((place) {
  //                               return Padding(
  //                                 padding:
  //                                 EdgeInsets.symmetric(horizontal: 16.0),
  //                                 child: Text(place),
  //                               );
  //                             }).toList(),
  //                           ),
  //                         ],
  //                       ),
  //                     );
  //                   }).toList(),
  //                 ),
  //                 SizedBox(height: 20),
  //                 Container(
  //                   height: 300,
  //                   child: GoogleMap(
  //                     initialCameraPosition: CameraPosition(
  //                       target:
  //                       locations.isNotEmpty ? locations.first : LatLng(0, 0),
  //                       zoom: 10,
  //                     ),
  //                     markers: locations.map((latLng) {
  //                       String placeName =
  //                       _getPlaceName(latLng, responses);
  //                       return Marker(
  //                         markerId: MarkerId(placeName),
  //                         position: latLng,
  //                         infoWindow: InfoWindow(title: placeName),
  //                       );
  //                     }).toSet(),
  //                   ),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Function to get the place name for a given location
  String _getPlaceName(LatLng latLng, List<String> responses) {
    for (String response in responses) {
      List<String> sections = response.split('\n\n');
      String title = sections.first;
      List<String> places = sections.sublist(1);
      for (String place in places) {
        List<String> data = place.split(',');
        double latitude = double.parse(data[1].trim());
        double longitude = double.parse(data[2].trim());
        if (LatLng(latitude, longitude) == latLng) {
          return data[0].trim();
        }
      }
    }
    return ''; // Default if not found
  }

