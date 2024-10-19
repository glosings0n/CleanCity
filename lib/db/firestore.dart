import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'model.dart';

class DBServices {
  static final clients = FirebaseFirestore.instance.collection("clients");
  static final admin = FirebaseFirestore.instance.collection("admin");
  static final adminEmail = "elikya@gmail.com";

//------------------ADMIN SECTION-------------------------------//
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

//------------------CLIENT SECTION-------------------------------//
  static Future<int> getClientsLength() async {
    try {
      final clientsCol = await clients.get();
      final clientsLength = clientsCol.docs.length;
      debugPrint(clientsLength.toString());
      return clientsLength;
    } catch (e) {
      debugPrint(e.toString());
      return -1;
    }
  }

  static Future<void> addClient(ClientModel client) async {
    final id = await getClientsLength();
    await clients.doc(client.email).set({
      "id": id + 1,
      "nom": client.nom,
      "postnom": client.postnom,
      "prenom": client.prenom,
      "age": client.age,
      "email": client.email,
      "numero": client.num,
      "adresse": client.address,
      "montant": client.montant,
    });
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getClients() async {
    return await clients.get();
  }

  static Future<bool> updateClient(ClientModel client) async {
    try {
      await clients.doc(client.email).update({
        "nom": client.nom,
        "postnom": client.postnom,
        "prenom": client.prenom,
        "age": client.age,
        "email": client.email,
        "numero": client.num,
        "adresse": client.address,
        "montant": client.montant,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> deleteClient(String email) async {
    try {
      await clients.doc(email).delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

//------------------DEPOT SECTION-------------------------------//
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
        .doc("depot-${id + 1}")
        .set({
      "id": id + 1,
      "localisation": depot.localisation,
      "capacity": depot.capacity,
    });
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getDepots() async {
    return await admin.doc(adminEmail).collection("depots").get();
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

  static Future<bool> deleteDepot(int id) async {
    try {
      await admin
          .doc(adminEmail)
          .collection("depots")
          .doc("depot-${id + 1}")
          .delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

//------------------EMPLOYER SECTION-------------------------------//
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
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getEmployers() async {
    return await admin.doc(adminEmail).collection("employers").get();
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
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

//------------------TEAM SECTION-------------------------------//
  static Future<int> getTeamsLength() async {
    try {
      final teams = await admin.doc(adminEmail).collection("teams").get();
      final teamsLength = teams.docs.length;
      debugPrint(teamsLength.toString());
      return teamsLength;
    } catch (e) {
      debugPrint(e.toString());
      return -1;
    }
  }

  static Future<void> addTeam(TeamModel team) async {
    final id = await getTeamsLength();
    await admin.doc(adminEmail).collection("teams").doc("team-${id + 1}").set({
      "id": "team-${id + 1}",
      "teamEmails": team.teamEmails,
      "chiefEmail": team.chiefEmail,
    });
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getTeams() async {
    return await admin.doc(adminEmail).collection("teams").get();
  }

  static Future<bool> updateTeam(TeamModel team) async {
    try {
      await admin.doc(adminEmail).collection("employers").doc(team.id).update({
        "teamEmails": team.teamEmails,
        "chiefEmail": team.chiefEmail,
      });
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

  static Future<bool> deleteTeam(int id) async {
    try {
      await admin
          .doc(adminEmail)
          .collection("teams")
          .doc("team-${id + 1}")
          .delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }

//------------------HISTORY SECTION-------------------------------//
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
        .doc("history-${id + 1}")
        .set({
      "id": id + 1,
      "teamID": history.teamID,
      "depotID": history.depotID,
      "clientEmail": history.clientEmail,
      "type": history.type,
      "quantity": history.quantity,
    });
  }

  static Future<QuerySnapshot<Map<String, dynamic>>> getHistories() async {
    return await admin.doc(adminEmail).collection("histories").get();
  }

  static Future<bool> updateHistory(HistoryModel history) async {
    try {
      await admin
          .doc(adminEmail)
          .collection("histories")
          .doc("history-${history.id + 1}")
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
          .doc("history-${id + 1}")
          .delete();
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
