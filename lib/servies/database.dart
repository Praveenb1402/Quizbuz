import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:quizbuz/RiverPod.dart';

class Firestore_Database {
  final CollectionReference questions_set =
      FirebaseFirestore.instance.collection('question_collections');
  final CollectionReference easy_questions =
      FirebaseFirestore.instance.collection('easy');
  final CollectionReference medium_questions =
      FirebaseFirestore.instance.collection('hard');
  final CollectionReference hard_questions =
      FirebaseFirestore.instance.collection('medium');

  Future<List> getquestion(String level) async {
    if (await hasInternet()) {
      final ref = FirebaseDatabase.instance.ref();
      final snapshot = await ref.child('$level').get();

      if (snapshot.exists) {
        print(snapshot.value); // prints node data
      } else {
        print("No data found at this node.");
      }
      return snapshot.value as List<dynamic>;
    } else {
      return [];
    }
  }

  void getFacts(WidgetRef ref) async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    // Check cached data
    final cachedData = remoteConfig.getString("did_you_know");

    if (cachedData.isNotEmpty && ref.read(didYouKnowProvider).isEmpty) {
      // Parse cached facts
      final decoded = jsonDecode(cachedData) as Map<String, dynamic>;
      final List<dynamic> facts = decoded["facts"];
      ref.read(didYouKnowProvider.notifier).state =
          facts.map((e) => e as Map<String, dynamic>).toList();

    } else if (ref.read(didYouKnowProvider).isEmpty) {
      // Fetch from server
      await remoteConfig.fetchAndActivate();
      final jsonString = remoteConfig.getString("did_you_know");

      if (jsonString.isNotEmpty) {
        final decoded = jsonDecode(jsonString) as Map<String, dynamic>;
        final List<dynamic> facts = decoded["facts"];
        ref.read(didYouKnowProvider.notifier).state =
            facts.map((e) => e as Map<String, dynamic>).toList();
      }
    }
  }


// Set default values

  Future<bool> hasInternet() async {
    var connectivityResult = await Connectivity().checkConnectivity();
    if (connectivityResult == ConnectivityResult.none) {
      return false;
    }

    try {
      final result = await http
          .get(Uri.parse('https://www.google.com'))
          .timeout(const Duration(seconds: 3));
      return result.statusCode == 200;
    } catch (_) {
      return false;
    }
  }
}
