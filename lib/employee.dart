class Employee {
  String id;
  String first_name, last_name;

  Employee({this.id, this.first_name, this.last_name});

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'] as String,
      first_name: json['first_name'] as String,
      last_name: json['last_name'] as String,
    );
  }
}
