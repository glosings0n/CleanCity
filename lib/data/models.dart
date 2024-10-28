class AdminModel {
  String name;
  String email;
  int num;
  String address;
  String password;
  int clients;

  AdminModel({
    required this.name,
    required this.email,
    required this.num,
    required this.address,
    required this.password,
    required this.clients,
  });

  factory AdminModel.fromJson(json) {
    return AdminModel(
      name: json['nom'],
      email: json['email'],
      num: json['numero'],
      address: json['adresse'],
      password: json['password'],
      clients: json['nbr_clients'],
    );
  }
}

class ClientModel {
  String nom;
  String postnom;
  String prenom;
  int age;
  String email;
  int num;
  String address;
  String? password;
  int montant;

  ClientModel({
    required this.nom,
    required this.postnom,
    required this.prenom,
    required this.age,
    required this.email,
    required this.num,
    required this.address,
    required this.montant,
    this.password,
  });

  factory ClientModel.fromJson(json) {
    return ClientModel(
      nom: json['nom'],
      postnom: json['postnom'],
      prenom: json['prenom'],
      age: json['age'],
      email: json['email'],
      num: json['numero'],
      address: json['adresse'],
      password: json['password'],
      montant: json['montant'],
    );
  }
}

class EmployerModel {
  String nom;
  String prenom;
  int age;
  String email;
  int num;
  String team;

  EmployerModel({
    required this.nom,
    required this.prenom,
    required this.age,
    required this.email,
    required this.num,
    required this.team,
  });

  factory EmployerModel.fromJson(json) {
    return EmployerModel(
      nom: json['nom'],
      prenom: json['prenom'],
      age: json['age'],
      email: json['email'],
      num: json['num'],
      team: json['team'],
    );
  }
}

class DepotModel {
  String? id;
  String localisation;
  String capacity;

  DepotModel({
    this.id,
    required this.localisation,
    required this.capacity,
  });

  factory DepotModel.fromJson(json) => DepotModel(
        id: json['id'],
        localisation: json['localisation'],
        capacity: json['capacity'],
      );
}

class TeamModel {
  String? id;
  String chiefEmail;
  List teamEmails;

  TeamModel({
    this.id,
    required this.chiefEmail,
    required this.teamEmails,
  });

  factory TeamModel.fromJson(json) => TeamModel(
        id: json['id'] as String,
        teamEmails: json['teamEmails'],
        chiefEmail: json['chiefEmail'] as String,
      );
}

class HistoryModel {
  int id;
  String teamID;
  String depotID;
  String clientEmail;
  String quantity;
  String type;

  HistoryModel({
    required this.id,
    required this.teamID,
    required this.depotID,
    required this.clientEmail,
    required this.quantity,
    required this.type,
  });

  factory HistoryModel.fromJson(json) {
    return HistoryModel(
      id: json['id'],
      teamID: json['teamID'],
      depotID: json['depotID'],
      clientEmail: json['clientEmail'],
      quantity: json['quantity'],
      type: json['type'],
    );
  }
}
