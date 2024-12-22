// ignore_for_file: library_private_types_in_public_api, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:new_app/Widget/size_widget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LandingPageScreen extends StatefulWidget {
  const LandingPageScreen({Key? key}) : super(key: key);

  @override
  _LandingPageScreenState createState() => _LandingPageScreenState();
}

class _LandingPageScreenState extends State<LandingPageScreen> {
  late TextEditingController _firstNameController;
  late TextEditingController _lastNameController;
  late TextEditingController _homeNameController;

  @override
  void initState() {
    super.initState();
    _firstNameController = TextEditingController();
    _lastNameController = TextEditingController();
    _homeNameController = TextEditingController();
    loadSavedData();
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _homeNameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var screenH = MediaQuery.of(context).size.height;
    var screenW = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () async {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            prefs.setString('firstName', _firstNameController.text);
            prefs.setString('lastName', _lastNameController.text);
            prefs.setString('homeName', _homeNameController.text);
            Navigator.pushNamedAndRemoveUntil(
                context, '/profilePage', (route) => false,
                arguments: {
                  'firstName': _firstNameController.text,
                  'lastName': _lastNameController.text,
                  'homeName': _homeNameController.text,
                });
          },
        ),
        title: const Text('landing Screen'),
      ),
      body: Padding(
 padding: EdgeInsets.symmetric(horizontal: screenW/30.0, vertical: screenH/40.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildEditableText("First Name", _firstNameController),
            constantHeight(context, 20.0),
            _buildEditableText("Last Name", _lastNameController),
            constantHeight(context, 20.0),
            _buildEditableText("Home Name", _homeNameController),
          ],
        ),
      ),
    );
  }

  Widget _buildEditableText(String labelText, TextEditingController controller) {
    return Row(
      children: [
        Text(labelText),
        constantWidth(context, 20.0),
        Expanded(
          child: TextField(
            controller: controller,
          ),
        ),
      ],
    );
  }

  Future<void> loadSavedData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? firstName = prefs.getString('firstName');
    String? lastName = prefs.getString('lastName');
    String? homeName = prefs.getString('homeName');
    setState(() {
      _firstNameController.text = firstName ?? '';
      _lastNameController.text = lastName ?? '';
      _homeNameController.text = homeName ?? '';
    });
  }
}
