import 'package:flutter/material.dart';
import '../../models/patient_model.dart';

class PatientTable extends StatelessWidget {
  final List<Patient> patients;

  PatientTable({required this.patients});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: DataTable(
        columns: [
          DataColumn(label: Text('Name')),
          DataColumn(label: Text('Phone')),
          DataColumn(label: Text('CIN')),
          DataColumn(label: Text('Result')),
          DataColumn(label: Text('Actions')),
        ],
        rows: patients.map((patient) {
          return DataRow(cells: [
            DataCell(Text('${patient.firstname} ${patient.lastname}')),
            DataCell(Text(patient.phonenumber)),
            DataCell(Text(patient.cin)),
            DataCell(
              Text(
                patient.result,
                style: TextStyle(
                  color: patient.result == 'Normal' ? Colors.green : Colors.red,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DataCell(
              IconButton(
                icon: Icon(Icons.visibility),
                onPressed: () {
                  // Show patient details
                },
              ),
            ),
          ]);
        }).toList(),
      ),
    );
  }
}
