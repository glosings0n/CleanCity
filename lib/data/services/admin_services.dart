import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data.dart';

class AdminServices {
  static final admin = FirebaseFirestore.instance.collection("admin");
  static final adminEmail = "elikya@gmail.com";

  static Future getAdmin() async {
    try {
      final adminDoc = await admin.doc(adminEmail).get();
      final adminJson = adminDoc.data();
      final adminData = AdminModel.fromJson(adminJson);
      debugPrint(adminData.email);
      return adminData;
    } catch (e) {
      debugPrint(e.toString());
      return;
    }
  }

  static Future<bool> updateXNbr(String field, int data) async {
    try {
      await admin.doc(adminEmail).update({field: data});
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<List> getLengths() async {
    try {
      final length1 = await ClientsServices.getClientsLength();
      final length2 = await EmployersServices.getEmployerLength();
      final length3 = await TeamsServices.getTeamsLength();
      final length4 = await DepositsServices.getDepotsLength();
      return [length1, length2, length3, length4];
    } catch (e) {
      debugPrint(e.toString());
      return [];
    }
  }
}
