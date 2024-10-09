import 'package:dortodorpartner/Helper/colors.dart';
import 'package:dortodorpartner/Helper/common_app_bar.dart';
import 'package:flutter/material.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: "Contact us",
      actionEnable: false,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Feel free to contact us with any questions or feedback!',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            const SizedBox(height: 24.0),
            contactDetail(
              context,
              Icons.location_on,
              'Address',
              'kuwait  City',
            ),
            contactDetail(
              context,
              Icons.phone,
              'Phone',
              '+96566478626',
            ),
            contactDetail(
              context,
              Icons.email,
              'Email',
              'dor2dor2024@gmail.com',
            ),
          ],
        ),
      ),
    );
  }

  Widget contactDetail(context, icon, label, value) {
    return ListTile(
      leading: Icon(icon, color: colors.primary),
      title: Text(label, style: Theme.of(context).textTheme.headlineLarge),
      subtitle: Text(value),
    );
  }
}
