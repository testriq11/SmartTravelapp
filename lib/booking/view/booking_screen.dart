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
  List<String> selectedResponses = [];

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final Map arguments =
    ModalRoute
        .of(context)!
        .settings
        .arguments as Map;
    responses = arguments['responses'] ?? [];
    prompt = arguments['prompt'] ?? ''; // Initialize prompt value
    String destination1 = extractDestination(prompt, 'visit from', 'to');
    String destination2 = extractDestination(prompt, 'to', 'by road');
    print('Des1:$destination1');
    print('Des:2$destination2');
    promptLocation = '$destination2';
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
        'https://08bc-202-179-91-72.ngrok-free.app/destination_title/insertTitle'; // Change the URL to your server URL

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
        'https://08bc-202-179-91-72.ngrok-free.app/fetch_route/responses'; // Update the URL to match your server endpoint

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

  Future<void> saveResponsesToDatabase(List<String> responses,
      int titleId) async {
    final String apiUrl =
        'https://08bc-202-179-91-72.ngrok-free.app/des_open_ai_response/saveResponses'; // Change the URL to your server URL

    try {
      for (String response in responses) {
        final responseList =
        response.split('\n'); // Split response by newline

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

          final responseData =
          jsonDecode(response.body); // Parse response body

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
    final startIndex = prompt.indexOf(from);
    final endIndex = prompt.indexOf(to, startIndex + from.length);
    return prompt.substring(startIndex, endIndex).trim();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Booking Screen'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              '$promptLocation',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            child: StreamBuilder<List<Map<String, dynamic>>>(
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
          ),
          ElevatedButton(
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
                  ),
                );
              }
            },
            child: Text('Show Selected Responses'),
          ),
        ],
      ),
    );
  }

  Widget _buildCard(Map<String, dynamic> response,
      {bool withCheckbox = true}) {
    String? journey = response['journey'];
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

    List<bool> isCheckedList =
    List<bool>.generate(contents.length, (index) => false);

    List<Widget> placeWidgets = [];

    for (var i = 0; i < contents.length; i++) {
      String place = contents[i];
      if (place.isNotEmpty) {
        Widget widgetToAdd;
        if (withCheckbox) {
          widgetToAdd = Row(
            children: [
              Checkbox(
                value: isCheckedList[i],
                onChanged: (bool? value) {
                  setState(() {
                    isCheckedList[i] = value!;
                    if (value!) {
                      selectedResponses.add(place);
                    } else {
                      selectedResponses.remove(place);
                    }
                  });
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

    List<Widget> children = [];
    if (journey != null && withCheckbox && contents.length > 1) {
      children.add(
        Padding(
          padding: EdgeInsets.only(left: 8.0, bottom: 4.0),
          child: Text(
            journey,
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }

    children.addAll(
      placeWidgets.map(
            (widget) => Card(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: widget,
          ),
        ),
      ),
    );

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: children,
    );
  }

}
