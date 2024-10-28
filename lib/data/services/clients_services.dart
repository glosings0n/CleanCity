import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../data.dart';

class ClientsServices {
  static final clients = FirebaseFirestore.instance.collection("clients");
  static final admin = FirebaseFirestore.instance.collection("admin");
  static final adminEmail = "elikya@gmail.com";

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
    final nbr = await getClientsLength();
    if (nbr >= 0) await AdminServices.updateXNbr("nbr_clients", nbr);
  }

  static Stream<QuerySnapshot<Map<String, dynamic>>> getClients() {
    return clients.snapshots();
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
      final nbr = await getClientsLength();
      if (nbr >= 0) await AdminServices.updateXNbr("nbr_clients", nbr);
      return true;
    } catch (e) {
      debugPrint(e.toString());
      return false;
    }
  }
}
