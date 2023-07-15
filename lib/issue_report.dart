import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'dart:convert';

class IssueReport {
  final String name;
  final String phoneNumber;
  final String busSource;
  final String busDestination;
  final String busNumber;
  final String breakdownPlace;

  IssueReport({
    required this.name,
    required this.phoneNumber,
    required this.busSource,
    required this.busDestination,
    required this.busNumber,
    required this.breakdownPlace,
  });

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phoneNumber': phoneNumber,
      'busSource': busSource,
      'busDestination': busDestination,
      'busNumber': busNumber,
      'breakdownPlace': breakdownPlace,
    };
  }
}

class IssuseForm extends StatefulWidget {
  @override
  _IssueFormState createState() => _IssueFormState();
}

class _IssueFormState extends State<IssuseForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _busSourceController = TextEditingController();
  final _busDestinationController = TextEditingController();
  final _busNumberController = TextEditingController();
  final _breakdownPlaceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Issuse Report Form'),
        backgroundColor: Color(0xFF070A52),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _phoneNumberController,
                decoration: InputDecoration(
                  labelText: 'Phone Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your phone number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _busSourceController,
                decoration: InputDecoration(
                  labelText: 'Bus number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the bus source';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _busDestinationController,
                decoration: InputDecoration(
                  labelText: 'Describe your Issue',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter description';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _busNumberController,
                decoration: InputDecoration(
                  labelText: 'Bus Number',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the bus number';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              TextFormField(
                controller: _breakdownPlaceController,
                decoration: InputDecoration(
                  labelText: 'Describe your problem',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter the breakdown place';
                  }
                  return null;
                },
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Call Police'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Call Ambulance'),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    child: Text('Call TNSTC'),
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final report = IssueReport(
                      name: _nameController.text,
                      phoneNumber: _phoneNumberController.text,
                      busSource: _busSourceController.text,
                      busDestination: _busDestinationController.text,
                      busNumber: _busNumberController.text,
                      breakdownPlace: _breakdownPlaceController.text,
                    );
                    submitForm(context, report);
                  }
                },
                child: Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void submitForm(BuildContext context, IssueReport report) async {
  final url = 'https://localbus33.000webhostapp.com/breakdown_report.php';
  final headers = {'Content-Type': 'application/json'};
  final body = json.encode(report.toJson());

  final response =
      await http.post(Uri.parse(url), headers: headers, body: body);

  if (response.statusCode == 200) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text('Your report has been submitted.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  } else {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text('There was an error submitting your report.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
