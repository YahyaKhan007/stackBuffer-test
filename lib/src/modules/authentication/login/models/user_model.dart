import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  String userId;
  String name;
  final String email;
  String phoneNumber;
  String profilePicture;
  String tokens;
  String location;
  final DateTime createdAt;

  // List<SellAdModel> favAdsList;

  UserModel({
    this.userId = "",
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profilePicture,
    required this.tokens,
    required this.location,
    required this.createdAt,
    // this.favAdsList = const [],
  });

  /// Convert Firebase data (Map) to a UserModel instance
  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      userId: map['userId'] ?? '',
      name: map['name'] ?? '',
      email: map['email'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      profilePicture: map['profilePicture'] ?? '',
      tokens: map['tokens'] ?? '',
      location: map['location'] ?? '',
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      // favAdsList:
      //     (map['favAdsList'] as List<dynamic>?)
      //         ?.map((ad) => SellAdModel.fromJson(ad))
      //         .toList() ??
      //     [],
    );
  }

  /// Convert UserModel instance to a Map for Firebase
  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'email': email,
      'phoneNumber': phoneNumber,
      'profilePicture': profilePicture,
      'tokens': tokens,
      'location': location,
      'createdAt': Timestamp.fromDate(createdAt),
      // 'favAdsList': favAdsList.map((ad) => ad.toJson()).toList(),
    };
  }

  /// Override props for comparison
  @override
  List<Object?> get props => [
    userId,
    name,
    email,
    phoneNumber,
    profilePicture,
    tokens,
    location,
    createdAt,
    // favAdsList,
  ];
}
