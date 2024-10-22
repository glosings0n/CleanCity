import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:url_launcher/url_launcher.dart';

Widget socialmediaView(
  BuildContext context, {
  bool? isWhite = false,
}) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 50),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        SocialMediaIcon(
          url: 'https://g.dev/georgesbyona',
          icon: HugeIcons.strokeRoundedGoogle,
        ),
        SocialMediaIcon(
          url: 'https://x.com/georgesbyona',
          icon: HugeIcons.strokeRoundedNewTwitter,
        ),
        SocialMediaIcon(
          url: 'https://linkedin.com/in/georgesbyona',
          icon: HugeIcons.strokeRoundedLinkedin02,
        ),
        SocialMediaIcon(
          url: 'https://www.instagram.com/_ysokit_',
          icon: HugeIcons.strokeRoundedInstagram,
        ),
        SocialMediaIcon(
          url: 'https://www.facebook.com/charking.mihigo',
          icon: HugeIcons.strokeRoundedFacebook02,
        ),
        SocialMediaIcon(
          url: 'https://github.com/glosings0n/CleanCity',
          icon: HugeIcons.strokeRoundedGithub01,
        ),
      ],
    ),
  );
}

class SocialMediaIcon extends StatelessWidget {
  const SocialMediaIcon({super.key, required this.url, required this.icon});

  final String url;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    void launchApp(String url) async {
      if (await canLaunchUrl(Uri.parse(url))) {
        await launchUrl(Uri.parse(url));
      }
    }

    return IconButton(
      onPressed: () {
        launchApp(url);
      },
      style: ButtonStyle(
        alignment: Alignment.center,
        overlayColor: WidgetStatePropertyAll(Colors.grey.shade300),
        backgroundColor: WidgetStatePropertyAll(Colors.transparent),
        foregroundColor: WidgetStatePropertyAll(Colors.black),
      ),
      icon: Icon(icon),
    );
  }
}
