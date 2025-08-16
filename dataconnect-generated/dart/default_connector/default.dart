library default_connector;

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:convert';

class DefaultConnector {
  CollectionReference users = FirebaseFirestore.instance.collection('users');

  getQuestons() async {
    QuerySnapshot querySnapshot = await users.get();
    for (var doc in querySnapshot.docs) {
      print(doc['questions']); // Access document fields
    }
  }
}
