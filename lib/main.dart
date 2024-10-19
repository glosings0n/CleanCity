import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:firebase_core/firebase_core.dart';

import 'firebase_options.dart';
import 'shared/shared.dart';
import 'views/views.dart';

void main() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.grey.shade300,
        textTheme: TextTheme(
          labelLarge: GoogleFonts.outfit(
            fontWeight: FontWeight.normal,
            color: Colors.black,
            fontSize: 12,
          ),
        ),
      ),
      initialRoute: '/clients',
      routes: {
        '/': (context) => const MainPageView(),
        '/admin': (context) => const AdminScreen(),
        '/clients': (context) => const ClientsList(),
        '/employers': (context) => const EmployersList(),
        '/deposits': (context) => const DepositsList(),
      },
    );
  }
}

class MainData {
  static List<String> images = [
    AppImages.tous,
    AppImages.famille,
    AppImages.apprendre,
    AppImages.camion,
    AppImages.tri,
  ];

  static List<String> titles = [
    "Unis pour une ville plus propre",
    "Un geste simple,\nun impact immense",
    "Éduquons pour\nun monde meilleur",
    "Attendez le passage\ndes camions, agissez de\nmanière responsable",
    "Le tri, c'est facile\net ça change tout !",
  ];

  static List<String> desc = [
    "Ensemble, faisons de notre ville un écrin de nature ! En utilisant notre plateforme, vous devenez un acteur clé de la transition écologique. Chaque geste compte, chaque déchet trié est une victoire pour notre environnement. Rejoignez la communauté des citoyens engagés et contribuons ensemble à un avenir plus vert.",
    "En famille, entre amis ou en couple, adoptez des habitudes éco-responsables au quotidien. Grâce à notre plateforme, trier vos déchets devient un jeu d'enfant. Ensemble, créons un environnement sain et agréable pour les générations futures.",
    "Transmettez vos valeurs écologiques aux plus jeunes ! Notre plateforme propose des outils pédagogiques pour sensibiliser les enfants et les adolescents aux enjeux du tri et du recyclage. Formons les citoyens de demain à devenir les défenseurs de la planète.",
    "Ne laissez plus vos déchets trainer ! En attendant le passage régulier de nos camions de collecte, vous contribuez à maintenir notre ville propre et à préserver notre environnement. Grâce à notre plateforme, vous pouvez facilement connaître les jours de collecte dans votre quartier et optimiser la gestion de vos déchets.",
    "Apprenez à trier vos déchets comme un pro ! Notre plateforme vous guide pas à pas pour identifier les différents types de déchets et les déposer dans les bonnes poubelles. En maîtrisant le tri, vous contribuez à préserver les ressources naturelles et à réduire l'impact environnemental.",
  ];
}
