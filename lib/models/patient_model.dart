class Patient {
  final String? id;
  final String firstname;
  final String lastname;
  final String phonenumber;
  final String cin;
  final String birth;
  final String result;
  final String? xrayBase64;

  Patient({
    this.id,
    required this.firstname,
    required this.lastname,
    required this.phonenumber,
    required this.cin,
    required this.birth,
    required this.result,
    this.xrayBase64,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id']?.toString(),
      firstname: json['firstname'],
      lastname: json['lastname'],
      phonenumber: json['phonenumber'],
      cin: json['cin'],
      birth: json['birth'],
      result: json['result'],
      xrayBase64: json['xraybase64'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstname': firstname,
      'lastname': lastname,
      'phonenumber': phonenumber,
      'cin': cin,
      'birth': birth,
      'result': result,
      'xraybase64': xrayBase64,
    };
  }
}
