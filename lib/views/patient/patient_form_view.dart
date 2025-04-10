import 'dart:io';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../services/api_service.dart';

class PatientFormView extends StatefulWidget {
  @override
  _PatientFormViewState createState() => _PatientFormViewState();
}

class _PatientFormViewState extends State<PatientFormView> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _cinController = TextEditingController();
  final _birthController = TextEditingController();
  final ImagePicker _picker = ImagePicker();
  File? _image;
  String? _scanResult;
  bool _isLoading = false;

  Future<void> _pickImage() async {
    try {
      final XFile? pickedFile = await _picker.pickImage(
        source: ImageSource.gallery, // Changed from camera to gallery
        imageQuality: 85,
        maxWidth: 800,
        maxHeight: 800,
      );

      if (pickedFile != null) {
        setState(() {
          _image = File(pickedFile.path);
        });
      }
    } catch (e) {
      print("Image picker error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Failed to pick image: ${e.toString()}")),
      );
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate() && _image != null) {
      setState(() {
        _isLoading = true;
      });

      try {
        final bytes = await _image!.readAsBytes();
        final base64Image = 'data:image/png;base64,${base64Encode(bytes)}';

        final response = await ApiService.scanPatient(
          firstname: _firstNameController.text,
          lastname: _lastNameController.text,
          phonenumber: _phoneController.text,
          cin: _cinController.text,
          birth: _birthController.text,
          imageBase64: base64Image,
        );

        if (response.statusCode == 201) {
          final result = json.decode(response.body)['result'];
          setState(() {
            _scanResult = result;
          });
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Scan completed: $result')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${response.body}')),
          );
        }
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('An error occurred: $e')),
        );
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    } else if (_image == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please select an X-ray image first')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Patient Scan')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                TextFormField(
                  controller: _firstNameController,
                  decoration: InputDecoration(labelText: 'First Name'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _lastNameController,
                  decoration: InputDecoration(labelText: 'Last Name'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _phoneController,
                  decoration: InputDecoration(labelText: 'Phone Number'),
                  keyboardType: TextInputType.phone,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _cinController,
                  decoration: InputDecoration(labelText: 'CIN'),
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                TextFormField(
                  controller: _birthController,
                  decoration: InputDecoration(labelText: 'Date of Birth'),
                  keyboardType: TextInputType.datetime,
                  validator: (value) => value!.isEmpty ? 'Required' : null,
                ),
                SizedBox(height: 20),
                _image == null
                    ? Text('No image selected',
                        style: TextStyle(color: Colors.grey))
                    : Image.file(_image!, height: 200),
                ElevatedButton(
                  onPressed: _pickImage,
                  child: Text('Select X-ray from Gallery'),
                ),
                SizedBox(height: 20),
                _isLoading
                    ? CircularProgressIndicator()
                    : ElevatedButton(
                        onPressed: _submitForm,
                        child: Text('Submit Scan'),
                      ),
                if (_scanResult != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 20),
                    child: Text(
                      'Scan Result: $_scanResult',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color:
                            _scanResult == 'Normal' ? Colors.green : Colors.red,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
