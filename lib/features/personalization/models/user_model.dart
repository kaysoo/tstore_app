import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:tstore_app/utils/formatters/formatter.dart';

class UserModel {
  // keep the values final for those which you do not want to update
  final String id;
  String firstName;
  String lastName;
  final String userName;
  final String email;
  String phoneNumber;
  String profilePicture;

  // constructor for usermodel
  UserModel({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.userName,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
  });

  //helper function to get the full name
  String get fullname => '$firstName $lastName';

  //helper function to format phone number
  String get formattedPhoneNo => TFormatter.formatPhoneNumber(phoneNumber);

  //static function to split name into first and last name
  static List<String> nameParts(fullname) => fullname.split(" ");

  //static function to generate a username from the full name
  static String generateUsername(fullName) {
    List<String> nameParts = fullName.split(" ");
    String firstName = nameParts[0].toLowerCase();
    String lastName = nameParts.length > 1 ? nameParts[1].toLowerCase() : '';

    String camelCaseUsername =
        '$firstName$lastName'; //combine first and last name
    String usernamewithPrefix = 'cmt_$camelCaseUsername'; //add 'cmt' prefix
    return usernamewithPrefix;
  }

  //static function to create an empty user model
  static UserModel empty() => UserModel(
      id: "",
      firstName: "",
      lastName: "",
      userName: "",
      email: "",
      phoneNumber: "",
      profilePicture: "");

  //convert model to json structure for storing data in firebase
  Map<String, dynamic> toJson() {
    return {
      'FirstName': firstName,
      'LastName': lastName,
      'Username': userName,
      'Email': email,
      'PhoneNumber': phoneNumber,
      'ProfilePicture': profilePicture,
    };
  }

  // Factory method to create a UserModel from a Firebase document snapshot
  factory UserModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    if (data == null) {
      throw Exception('Document data is null');
    }
    return UserModel(
      id: document.id,
      firstName: data['FirstName'] ?? '',
      lastName: data['LastName'] ?? '',
      userName: data['Username'] ?? '',
      email: data['Email'] ?? '',
      phoneNumber: data['PhoneNumber'] ?? '',
      profilePicture: data['ProfilePicture'] ?? '',
    );
  }

  // //factory method to create a usermodel from a firebase document snapshot
  // factory UserModel.fromSnapshot(
  //     DocumentSnapshot<Map<String, dynamic>> document) {
  //   if (document.data() != null) {
  //     final data = document.data()!;
  //     return UserModel(
  //         id: document.id,
  //         firstName: data['FirstName'] ?? '',
  //         lastName: data['LastName'] ?? '',
  //         userName: data['Username'] ?? '',
  //         email: data['Email'] ?? '',
  //         phoneNumber: data['PhoneNumber'] ?? '',
  //         profilePicture: data['ProfilePicture'] ?? '');
  //   }
  // }
}
