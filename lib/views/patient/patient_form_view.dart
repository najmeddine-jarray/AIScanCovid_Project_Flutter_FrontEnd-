import 'dart:convert';
import 'dart:io';

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
        source: ImageSource.gallery,
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

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    TextInputType? keyboardType,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        style: const TextStyle(fontSize: 16),
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.blueAccent),
          labelText: label,
          labelStyle: const TextStyle(
            fontSize: 14,
            color: Colors.black54,
            fontWeight: FontWeight.w500,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          enabledBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blueAccent, width: 1.2),
            borderRadius: BorderRadius.circular(14),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.blue, width: 1.5),
            borderRadius: BorderRadius.circular(14),
          ),
          errorBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: Colors.red, width: 1.2),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        validator: (value) =>
            value == null || value.trim().isEmpty ? 'Required' : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Patient X-ray Scanner',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildTextField(
                      label: 'First Name',
                      controller: _firstNameController,
                      icon: Icons.person,
                    ),
                    SizedBox(height: 6),
                    _buildTextField(
                      label: 'Last Name',
                      controller: _lastNameController,
                      icon: Icons.person_outline,
                    ),
                    SizedBox(height: 6),
                    _buildTextField(
                      label: 'Phone Number',
                      controller: _phoneController,
                      icon: Icons.phone,
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: 6),
                    _buildTextField(
                      label: 'CIN',
                      controller: _cinController,
                      icon: Icons.badge,
                    ),
                    SizedBox(height: 6),
                    _buildTextField(
                      label: 'Date of Birth',
                      controller: _birthController,
                      icon: Icons.calendar_today,
                      keyboardType: TextInputType.datetime,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Column(
                children: [
                  _image == null
                      ? Text('No image selected',
                          style: TextStyle(color: Colors.grey))
                      : ClipRRect(
                          borderRadius: BorderRadius.circular(12),
                          child: Image.file(_image!,
                              height: 150, fit: BoxFit.cover),
                        ),
                  SizedBox(height: 12),
                  ElevatedButton.icon(
                    icon: Icon(Icons.photo_library, color: Colors.white),
                    label: Text('Select X-ray from Gallery'),
                    onPressed: _pickImage,
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              _isLoading
                  ? CircularProgressIndicator()
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          icon: Icon(Icons.send, color: Colors.white),
                          label: Text(
                            'Submit Scan',
                            style: TextStyle(color: Colors.white),
                          ),
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 14),
                            backgroundColor: Colors.blueAccent,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                        ),
                      ),
                    ),
              if (_scanResult != null) ...[
                SizedBox(height: 20),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  color: _scanResult == 'Normal'
                      ? Colors.green[100]
                      : Colors.red[100],
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      children: [
                        Icon(
                          _scanResult == 'Normal'
                              ? Icons.check_circle
                              : Icons.warning,
                          color: _scanResult == 'Normal'
                              ? Colors.green
                              : Colors.red,
                          size: 28,
                        ),
                        SizedBox(width: 10),
                        Expanded(
                          child: Text(
                            'Scan Result: $_scanResult',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: _scanResult == 'Normal'
                                  ? Colors.green
                                  : Colors.red,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
