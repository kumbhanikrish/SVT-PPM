import 'dart:developer';

import 'package:url_launcher/url_launcher.dart';

Future<void> launchDialer(String phoneNumber) async {
  final Uri launchUri = Uri(scheme: 'tel', path: phoneNumber);
  if (await canLaunchUrl(launchUri)) {
    await launchUrl(launchUri);
  } else {
    throw 'Could not launch $launchUri';
  }
}

void launchWhatsApp(String phone, String message) async {
  String url = "https://wa.me/$phone?text=${Uri.encodeComponent(message)}";
  if (await canLaunchUrl(Uri.parse(url))) {
    await launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
  } else {
    log("Could not launch WhatsApp");
  }
}
