import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DbRepository with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addFund({
    required double amount,
    String comment = '',
    required String userId,
    required String userName,
    required String paymentMethod,
  }) async {
    var fundHistoryUid = Uuid().v4();
    var data = {
      "fundHistoryUid": fundHistoryUid,
      "name": userName,
      "userId": userId,
      "amount": amount,
      "status":
          "pending", // pending, failed, verified (if verified only then add and reflect). TODO: implement method in admin access to verify and add amount
      "paymentMethod": paymentMethod,
      "timestamp": DateTime.now().millisecondsSinceEpoch,
    };

    // add data to common collection and put uid reference in users' uid doc
    _firestore.collection("fundAddHistory").doc(fundHistoryUid).set(data);
    _firestore
        .collection("users")
        .doc(userId)
        .collection("fundHistory")
        .doc(fundHistoryUid)
        .set({});
  }

  Future<void> verifyFundAddPayment({required String fundHistoryUid}) async {
    // fetch the data of that particular transaction
    var snap =
        await _firestore.collection("fundAddHistory").doc(fundHistoryUid).get();
    var data = snap.data();

    // verify transaction and add the amount to the fund (in both global and user collection)
  }
}
