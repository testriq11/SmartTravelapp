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
import 'package:smarttravelapp/selected_responses_location_screen/SelectedResponsesLocationScreen.dart';

import '../../constants/api_consts.dart';

class BookingScreen1 extends StatefulWidget {
  // Declare id as a parameter
  BookingScreen1({Key? key}) : super(key: key);

  @override
  _BookingScreen1State createState() => _BookingScreen1State();
}


class _BookingScreen1State extends State<BookingScreen1> {
  List<String> responses = [];
  late String prompt;
  late int uid;
  late String destination1;
  late String destination2;
  late String promptLocation; // Initialize promptLocation
  int titleId = 0;

  // Initialize promptLocation in the constructor
  _BookingScreen1State() {
    promptLocation = ''; // Initialize promptLocation
  }

    StreamController<List<Map<String, dynamic>>> _controller =
    StreamController<List<Map<String, dynamic>>>();
  List<String> selectedResponses = [];
  bool _isFetching = false; // Track whether responses are being fetched

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map? arguments =
    ModalRoute.of(context)!.settings.arguments as Map?;
    if (arguments != null) {
      responses = arguments['responses'] ?? [];
      prompt = arguments['prompt'] ?? ''; // Initialize prompt value
      destination1 = extractDestination(prompt, 'visit from', 'to');
      destination2 = extractDestination(prompt, 'to', 'by road');
      promptLocation = destination2;
      uid = arguments['id'];// Initialize promptLocation here
      print('Des1:$destination1');
      print('Des:2$destination2');
      print('Prompt Loc: $promptLocation');
      print('id:$uid');


    }

    // saveResponsesToDatabase(responses);
    insertTitleDatabase(promptLocation).then((id) {
      setState(() {
        titleId = id; // Set the title ID
      });
      saveResponsesToDatabase(responses, titleId,uid); // Pass titleId here
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
      if (!_isFetching) {
        fetchResponses();
      }
    });
  }

  Future<int> insertTitleDatabase(String promptLocation) async {
    final String apiUrl =
        '$NGROK_URL/destination_title/insertTitle'; // Change the URL to your server URL

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

  Future<void> fetchResponses() async {
    if (!_controller.isClosed) {
      _isFetching = true; // Set to true when fetching responses
      final String url =
          '$NGROK_URL/fetch_route/responses'; // Update the URL to match your server endpoint

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
        } else {
          // If the server returns an error response, throw an exception
          throw Exception('Failed to load responses: ${response.statusCode}');
        }
      } catch (error) {
        // If an error occurs during the HTTP request, throw an exception
        throw Exception('Failed to load responses: $error');
      } finally {
        _isFetching = false; // Set back to false after response is fetched
      }
    }
  }

    Future<void> saveResponsesToDatabase(List<String> responses, int titleId, int userId) async {
    final String apiUrl = '$NGROK_URL/des_open_ai_response/saveResponses'; // Change the URL to your server URL

    try {
      for (String response in responses) {
        final responseList = response.split('\n'); // Split response by newline

        for (String singleResponse in responseList) {
          final responsePart = singleResponse.trim();
          final httpResponse = await http.post(
            Uri.parse(apiUrl),
            headers: <String, String>{
              'Content-Type': 'application/json; charset=UTF-8',
            },
            body: jsonEncode(<String, dynamic>{
              'response_text': responsePart,
              'title_id': titleId,
              'user_id': userId // Send user_id along with the response
            }),
          );

          final responseData = jsonDecode(httpResponse.body); // Parse response body

          if (httpResponse.statusCode == 200) {
            print('Response "$responsePart" saved successfully');
          } else {
            print('Failed to save response "$responsePart". Error: ${responseData['error']}'); // Print error from server
          }
        }
      }
    } catch (e) {
      print('Failed to connect to the server. Error: $e');
    }
  }

  // Future<void> saveResponsesToDatabase(List<String> responses,
  //     int titleId) async {
  //   final String apiUrl =
  //       'https://b226-202-179-91-72.ngrok-free.app/des_open_ai_response/saveResponses'; // Change the URL to your server URL
  //
  //   try {
  //     for (String response in responses) {
  //       final responseList =
  //       response.split('\n'); // Split response by newline
  //
  //       for (String singleResponse in responseList) {
  //         final responsePart = singleResponse.trim();
  //         final response = await http.post(
  //           Uri.parse(apiUrl),
  //           headers: <String, String>{
  //             'Content-Type': 'application/json; charset=UTF-8',
  //           },
  //           body: jsonEncode(<String, dynamic>{
  //             'response_text': responsePart,
  //             'title_id': titleId,
  //              'id' :  id                // Send title ID along with the response
  //           }),
  //         );
  //
  //         final responseData =
  //         jsonDecode(response.body); // Parse response body
  //
  //         if (response.statusCode == 200) {
  //           print('Response "$responsePart" saved successfully');
  //         } else {
  //           print(
  //               'Failed to save response "$responsePart". Error: ${responseData['error']}'); // Print error from server
  //         }
  //       }
  //     }
  //   } catch (e) {
  //     print('Failed to connect to the server. Error: $e');
  //   }
  // }

  String extractDestination(String prompt, String from, String to) {
    final startIndex = prompt.indexOf(from);
    final endIndex = prompt.indexOf(to, startIndex + from.length);
    return prompt.substring(startIndex, endIndex).trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Screen',style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.teal, // Custom app bar color
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0), // Increased padding for text
            child: Text(
              'Choose Location:',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20, // Increased font size
                color: Colors.deepPurple, // Custom text color
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
              stream: _controller.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(
                          Colors.deepPurple), // Custom progress indicator color
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(
                      'Error: ${snapshot.error}',
                      style: TextStyle(
                        color: Colors.red, // Custom error text color
                      ),
                    ),
                  );
                } else {
                  List<Map<String, dynamic>>? responses = snapshot.data;

                  if (responses == null || responses.isEmpty) {
                    return Center(
                      child: Text(
                        'No data available',
                        style: TextStyle(
                          fontStyle: FontStyle.italic, // Italics for empty data message
                          color: Colors.grey, // Custom text color
                        ),
                      ),
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
          ),
          SizedBox(height: 20), // Added spacing between the list and button
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: ElevatedButton(
              onPressed: () {
                if (selectedResponses.isNotEmpty) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          SelectedResponsesLocationScreen(selectedResponses),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('No response selected!'),
                      backgroundColor: Colors.red, // Custom snackbar color
                    ),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.teal, // Custom button color
                onPrimary: Colors.white, // Custom text color
              ),
              child: Text(
                'Show Selected Responses',
                style: TextStyle(
                  fontSize: 18, // Increased button text size
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> response, {bool withCheckbox = true}) {
    List<String> contents = [];

    if (response['text'] != null) {
      if (response['text'] is String) {
        contents = (response['text'] as String)
            .split('\n')
            .map((e) => e.trim())
            .toList();
      } else {
        contents = List<String>.from(response['text'])
            .map((e) => e.toString())
            .toList();
      }
    }

    List<Widget> placeWidgets = [];

    for (var i = 0; i < contents.length; i++) {
      String place = contents[i];
      if (place.isNotEmpty) {
        Widget widgetToAdd;
        if (withCheckbox) {
          bool isChecked = selectedResponses.contains(place);
          widgetToAdd = Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(place),
              ),
              Checkbox(
                value: isChecked,
                onChanged: (bool? value) {
                  setState(() {
                    if (value!) {
                      selectedResponses.add(place);
                    } else {
                      selectedResponses.remove(place);
                    }
                  });
                },
              ),
            ],
          );
        } else {
          widgetToAdd = Padding(
            padding: EdgeInsets.only(left: 25.0),
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
      margin: EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: placeWidgets,
        ),
      ),
    );
  }

}

