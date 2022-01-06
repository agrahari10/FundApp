import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fund_manger/models/fundHistoryModel.dart';
import 'package:fund_manger/models/userModel.dart';
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
    var data = snap.data();
    String userId = data?['userId'];
    double amountAdded = data?['amount'] ?? 0;

    if (data?['status'] == "verified") {
      print("payment already verified");
      return Future.delayed(Duration.zero);
    } // do nothing if already verifed

    //////// verify transaction and add the amount to the fund (in both global and user collection)

    ////// adding fund amount to global variable
    //// get fund amount
    _firestore.collection("fund").doc("fundAmount").get().then((doc) {
      double previousAmount = 0.0;
      double amount = 0.0;
      // check if in case doesn't exist
      if (doc.exists) {
        previousAmount =
            double.parse(doc.data()!['totalFundAmount'].toString());
        amount =
            data!['amount']; // data['amount'] is coming from user's collection
      }

      // add amount
      _firestore.collection("fund").doc("fundAmount").set({
        "totalFundAmount": previousAmount + amount,
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
      double previousAmount = 0;
      if (doc.exists) {
        previousAmount =
            double.parse(doc.data()!["totalFundAmount"].toString());
      }

      //// add and store total amount
      _firestore
          .collection("users")
          .doc(userId)
          .collection("fund")
          .doc("fundAmount")
          .set({
        "totalFundAmount": previousAmount + amountAdded,
      }).then((value) => print((doc.data()?["totalFundAmount"] ?? 0)));
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
      double previousAmount = 0;
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
        double previousAmount = 0;
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
            .set({
          "totalFundAmount": previousAmount - perPersonAmountExpend,
        });
      });
    }
  }

  Future<UserModel> getUserDetails({required String uuid}) async {
    var snap = await _firestore.collection("users").doc(uuid).get();
    var data = snap.data()!;
    return UserModel(
      uuid: data['uuid'],
      email: data['email'],
      isAdmin: data['isAdmin'],
      accountCreatedOn: data['joinDate'],
      name: data['name'],
    );
  }

  Future<FundHistoryModel> getFundHistoryDetails(
      {required String fundHistoryUid}) async {
    var snap =
        await _firestore.collection("fundAddHistory").doc(fundHistoryUid).get();
    var data = snap.data()!;

    return FundHistoryModel(
      fundAddHistoryUid: data['fundHistoryUid'],
      addedByUid: data['userId'],
      addedByUsername: data['name'],
      timestamp: data['timestamp'],
      amount: data['amount'],
      paymentMethod: data['paymentMethod'],
      status: data['status'],
      comment: data['comment'],
    );
  }

  Future<List<String>> getAuthorizedUsersIds() async {
    List<String> uids = [];
    await _firestore
        .collection("users")
        .where("isRequestAccepted", isEqualTo: "accepted")
        .get()
        .then((docs) {
      docs.docs.forEach((doc) {
        uids.add(doc.id);
      });
    });

    return uids;
  }
}
