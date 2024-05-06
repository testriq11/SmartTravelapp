
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:smarttravelapp/home/controller/home_controller.dart';


class SelectedResponsesLocationScreen extends StatelessWidget {
  final List<String> selectedResponses;

  SelectedResponsesLocationScreen(this.selectedResponses);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Selected Responses'),
      ),
      body: ListView.builder(
        itemCount: selectedResponses.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(selectedResponses[index]),
          );
        },
      ),
    );
  }
}