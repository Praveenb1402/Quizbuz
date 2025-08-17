import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

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
