import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data.dart';

class HistoriesServices {
  static final admin = FirebaseFirestore.instance.collection("admin");
  static final adminEmail = "elikya@gmail.com";

  static Future<int> getHistoriesLength() async {
    try {
      final histories =
          await admin.doc(adminEmail).collection("histories").get();
      final historiesLength = histories.docs.length;
      debugPrint(historiesLength.toString());
      return historiesLength;
    } catch (e) {
      debugPrint(e.toString());
      return -1;
    }
  }

  static Future<void> addHistory(HistoryModel history) async {
    final id = await getHistoriesLength();
    await admin
        .doc(adminEmail)
        .collection("histories")
        .doc("Historique-${id + 1}")
        .set({
      "id": id + 1,
      "teamID": history.teamID,
      "depotID": history.depotID,
      "clientEmail": history.clientEmail,
      "type": history.type,
      "quantity": history.quantity,
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getHistories() {
    return admin.doc(adminEmail).collection("histories").snapshots();
  }

  static Future<bool> updateHistory(HistoryModel history) async {
    try {
      await admin
          .doc(adminEmail)
          .collection("histories")
          .doc("Historique-${history.id + 1}")
          .update({
        "teamID": history.teamID,
        "depotID": history.depotID,
        "clientEmail": history.clientEmail,
        "type": history.type,
        "quantity": history.quantity,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> deleteHistory(int id) async {
    try {
      await admin
          .doc(adminEmail)
          .collection("histories")
          .doc("Historique-${id + 1}")
          .delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
