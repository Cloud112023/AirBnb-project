import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Contact {
  String? id;
  String? firstName;
  String? lastName;
  String? fullName;
  MemoryImage? displayImage;

  Contact({
    this.id = '',
    this.firstName = "",
    this.lastName = '',
    this.displayImage,
  });

  String getFullName() {
    return fullName = firstName! + ' ' + lastName!;
  }
}

class UserModel extends Contact {
  DocumentSnapshot? snapshot;
  String? email;
  String? bio;
  String? city;
  String? country;
  bool? isHost;
  bool? isCurrentlyHosting;
  String? password;

  UserModel({
    String id = '',
    String firstName = '',
    String lastName = '',
    MemoryImage? displayImage,
    this.email = '',
    this.bio = '',
    this.city = '',
    this.country = '',
  }) : super(
         id: id,
         firstName: firstName,
         lastName: lastName,
         displayImage: displayImage,
       ) {
    isHost = false;
    isCurrentlyHosting = false;
  }

  Future<void> addToFireStore() async {
    Map<String, dynamic> data = {
      'bio': bio,
      'city': city,
      'country': country,
      'email': email,
      'firstName': firstName,
      'isHost': false,
      'lastName': lastName,
      'myPostingIDs': [],
      'savedPostingIDs': [],
      'earnings': 0,
    };

    await FirebaseFirestore.instance.doc('users/$id').set(data);
  }

  //uploadImage to Cloudinary
  addImageToCloudinary() {}
  //getImageFromCloudinary
  getImageFromCloudinary() {}

  Future<void> getPersonalInfoFromFirestore() async {
    await getUserInfoFromFirestore();
  }

  Future<void> getUserInfoFromFirestore() async {
    final DocumentSnapshot snapshot = await FirebaseFirestore.instance
        .collection('users')
        .doc(id)
        .get();

    this.snapshot = snapshot;
    firstName = snapshot['firstName'] ?? '';
    lastName = snapshot['lastName'] ?? '';
    email = snapshot['email'] ?? '';
    bio = snapshot['bio'] ?? '';
    city = snapshot['city'] ?? '';
    country = snapshot['country'] ?? '';
    isHost = snapshot['isHost'] ?? false;
  }

  becomeHost() async {
    isHost = true;
    await FirebaseFirestore.instance.collection('users').doc(id).update({
      'isHost': true,
    });
    changeCurrentlyHosting(true);
  }

  void changeCurrentlyHosting(bool isHosting) {
    isCurrentlyHosting = isHosting;
  }
}
