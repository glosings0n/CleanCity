import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data.dart';

class TeamsServices {
  static final admin = FirebaseFirestore.instance.collection("admin");
  static final adminEmail = "elikya@gmail.com";

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
    await admin
        .doc(adminEmail)
        .collection("teams")
        .doc("Equipe-${id + 1}")
        .set({
      "id": "Equipe-${id + 1}",
      "chiefEmail": team.chiefEmail,
      "teamEmails": team.teamEmails,
    });
    final nbr = await getTeamsLength();
    if (nbr >= 0) await AdminServices.updateXNbr("nbr_teams", nbr);
  }

  static Future<void> addTeamMember(
    String teamID,
    List membersList,
  ) async {
    await admin.doc(adminEmail).collection("teams").doc(teamID).update({
      "teamEmails": membersList,
    });
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getTeams() {
    return admin.doc(adminEmail).collection("teams").snapshots();
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

  static Future<bool> deleteTeam(String id) async {
    try {
      await admin.doc(adminEmail).collection("teams").doc(id).delete();
      final nbr = await getTeamsLength();
      if (nbr >= 0) await AdminServices.updateXNbr("nbr_teams", nbr);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
