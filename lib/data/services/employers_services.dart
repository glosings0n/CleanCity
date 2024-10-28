import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data.dart';

class EmployersServices {
  static final admin = FirebaseFirestore.instance.collection("admin");
  static final adminEmail = "elikya@gmail.com";

  static Future<int> getEmployerLength() async {
    try {
      final employers =
          await admin.doc(adminEmail).collection("employers").get();
      final employersLength = employers.docs.length;
      debugPrint(employersLength.toString());
      return employersLength;
    } catch (e) {
      debugPrint(e.toString());
      return -1;
    }
  }

  static Future<void> addEmployers(EmployerModel employer) async {
    await admin
        .doc(adminEmail)
        .collection("employers")
        .doc(employer.email)
        .set({
      "nom": employer.nom,
      "prenom": employer.prenom,
      "age": employer.age,
      "email": employer.email,
      "num": employer.num,
      "team": employer.team,
    });
    final nbr = await getEmployerLength();
    if (nbr >= 0) await AdminServices.updateXNbr("nbr_employers", nbr);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getEmployers() {
    return admin.doc(adminEmail).collection("employers").snapshots();
  }

  static Future<bool> updateEmployer(EmployerModel employer) async {
    try {
      await admin
          .doc(adminEmail)
          .collection("employers")
          .doc(employer.email)
          .update({
        "nom": employer.nom,
        "prenom": employer.prenom,
        "age": employer.age,
        "num": employer.num,
        "team": employer.team,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> deleteEmployer(String email) async {
    try {
      await admin.doc(adminEmail).collection("employers").doc(email).delete();
      final nbr = await getEmployerLength();
      if (nbr >= 0) await AdminServices.updateXNbr("nbr_employers", nbr);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
