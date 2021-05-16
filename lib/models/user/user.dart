class User {
  final String id,username, email, firstName, lastName, description;

  User({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.description
  });
  @override
  String toString() {
    return '{"id": "${id}", "username": "${username}", "email": "${email}" ,"firstName": "${firstName}", "lastName": "${lastName}", "description": "${description}" }';
  }

  factory User.fromJSON(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        username: json['username'] as String,
        email: json['email'] as String,
        firstName: json['firstName'] as String,
        lastName: json['lastName'] as String,
        description: json['description'] as String,
      );
}

class UserDetails {
  final String id,username, email, firstName, lastName, description;

  UserDetails({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.description
  });

  factory UserDetails.fromJSON(Map<String, dynamic> json) => UserDetails(
    id: json['id'] as String,
    username: json['username'] as String,
    email: json['email'] as String,
    firstName: json['firstName'] as String,
    lastName: json['lastName'] as String,
    description: json['description'] as String,
  );
}
