class User {
  final String fullName;
  final String firstName;
  final String lastName;
  final String email;
  final String photoUrl;
  final String userType;
  final DateTime createdAt;
  final String studentNumber;
  final String uid;
  final String displayName;

  User(
      {this.fullName,
      this.firstName,
      this.lastName,
      this.email,
      this.photoUrl,
      this.userType,
      this.createdAt,
      this.studentNumber,
      this.displayName,
      this.uid});

  factory User.fromMap(Map data) {
    data = data ?? {};
    return User(
      fullName: data['displayName'] ?? '',
      email: data['email'] ?? '',
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      displayName: data['displayName'] ?? '',
      uid: data['uid'] ?? '',
      photoUrl: data['photoUrl'] ?? '',
      userType: data['userType'] ?? '',
      studentNumber: data['studentNumber'] ?? '',
    );
  }
}
