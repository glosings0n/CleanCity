import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data.dart';

class DepositsServices {
  static final admin = FirebaseFirestore.instance.collection("admin");
  static final adminEmail = "elikya@gmail.com";

  static Future<int> getDepotsLength() async {
    try {
      final depots = await admin.doc(adminEmail).collection("depots").get();
      final depotsLength = depots.docs.length;
      debugPrint(depotsLength.toString());
      return depotsLength;
    } catch (e) {
      debugPrint(e.toString());
      return -1;
    }
  }

  static Future<void> addDepot(DepotModel depot) async {
    final id = await getDepotsLength();
    await admin
        .doc(adminEmail)
        .collection("depots")
        .doc("Dépôt-${id + 1}")
        .set({
      "id": "Dépôt-${id + 1}",
      "localisation": depot.localisation,
      "capacity": depot.capacity,
    });
    final nbr = await getDepotsLength();
    if (nbr >= 0) await AdminServices.updateXNbr("nbr_depots", nbr);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getDepots() {
    return admin.doc(adminEmail).collection("depots").snapshots();
  }

  static Future<bool> updateDepot(DepotModel depot) async {
    try {
      await admin.doc(adminEmail).collection("depots").doc(depot.id).update({
        "localisation": depot.localisation,
        "capacity": depot.capacity,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> deleteDepot(String depotID) async {
    try {
      await admin.doc(adminEmail).collection("depots").doc(depotID).delete();
      final nbr = await getDepotsLength();
      if (nbr >= 0) await AdminServices.updateXNbr("nbr_depots", nbr);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
