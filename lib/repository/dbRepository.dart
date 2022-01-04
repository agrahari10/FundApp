import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class DbRepository with ChangeNotifier {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // adding fund from user side, it'll not reflect in fund untill verified by admin
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
      "comment": comment,
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
    var data = snap.data()!;
    String userId = data['userId'];

    //////// verify transaction and add the amount to the fund (in both global and user collection)

    ////// adding fund amount to global variable
    //// get fund amount
    _firestore.collection("fund").doc("fundAmount").get().then((doc) {
      double previousAmount = 0.0;
      // check if in case doesn't exist
      if (doc.exists) {
        previousAmount = doc.data()!['totalFundAmount'];
      }

      // add amount
      _firestore.collection("fund").doc("fundAmount").set({
        "totalFundAmount": previousAmount +
            data['amount'], // data['amount'] is coming from user's collection
      });
    });

    ////// adding fund amount to the user's collection
    await _firestore
        .collection("users")
        .doc(userId)
        .collection("fund")
        .doc("fundAmount")
        .get()
        .then((doc) {
      //// get the previous amount
      double previousAmount = 0.0;
      if (doc.exists) {
        previousAmount = doc.data()!["totalFundAmount"];
      }

      //// add and store total amount
      _firestore
          .collection("users")
          .doc(userId)
          .collection("fund")
          .doc("fundAmount")
          .update({
        "totalFundAmount": previousAmount + doc.data()!["totalFundAmount"],
      });
    });

    //// set status to "verified" from "pending"
    _firestore.collection("fundAddHistory").doc(fundHistoryUid).update({
      "status": "verified",
    });
  }

  Future<void> rejectFundAddPaymentVerification(
      {required String fundHistoryUid}) async {
    _firestore.collection("fundAddHistory").doc(fundHistoryUid).update({
      "status": "failed",
    });
  }

  ////// Add record (add transaction record of things / services bought and minus the amount from the consumers and user fund)
  Future<void> addRecord({
    required String itemName,
    required double amount,
    String comment = "",
    required String
        recordedByUid, // the person who recorded / added / proceeded the transaction
    required List<String>
        consumersUids, // TODO: check if user request is accepted before adding his/her uid here
  }) async {
    var recordUid = Uuid().v4();
    int timestamp = DateTime.now().millisecondsSinceEpoch;
    // record transactions (buying transactions) history and details (in global scope)
    var data = {
      "recordUid": recordUid, // refernce uid of the transactions
      "itemName": itemName,
      "amount": amount,
      "comment": comment,
      "recordedByUid":
          recordedByUid, // the person who recorded / added / proceeded the transaction
      "consumersUids": consumersUids, // list of uids of consumers
      "timestamp": timestamp, // in millisecondsSinceEpoch
    };
    await _firestore.collection("transactions").doc(recordUid).set(data);

    // record and store the refence uid to the collection of the person who recoded / added the transaction
    await _firestore
        .collection("users")
        .doc(recordedByUid)
        .collection("transactions")
        .doc(recordUid)
        .set({});

    //// substract the amount from global fund scope
    // get the global fund amount and data
    await _firestore.collection("fund").doc("fundAmount").get().then((doc) {
      double previousAmount = 0.0;
      // check if in case doesn't exist
      if (doc.exists) {
        previousAmount = doc.data()!['totalFundAmount'];
      }

      // substract global fund amount
      _firestore.collection("fund").doc("fundAmount").set({
        "totalFundAmount": previousAmount -
            amount, // amount is the amount expended in this particular transaction
      });
    });

    //// substract the amounts from the consumers scope fund
    ///
    ///
    for (var consumerUid in consumersUids) {
      await _firestore
          .collection("users")
          .doc(consumerUid)
          .collection("fund")
          .doc("fundAmount")
          .get()
          .then((doc) {
        //// get the previous amount
        double previousAmount = 0.0;
        if (doc.exists) {
          previousAmount = doc.data()!["totalFundAmount"];
        }

        double perPersonAmountExpend = amount / consumersUids.length;

        //// substract and update total amount (from each consumer fund)
        _firestore
            .collection("users")
            .doc(consumerUid)
            .collection("fund")
            .doc("fundAmount")
            .update({
          "totalFundAmount": previousAmount - perPersonAmountExpend,
        });
      });
    }
  }
}
