import 'package:flutter/material.dart';
import '../../Helper/common_app_bar.dart';

class TermsAndPolicyPage extends StatelessWidget {
  const TermsAndPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    return CommonAppBar(
      title: "Terms and Policy",
      actionEnable: false,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms & Condition',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              '1. Introduction',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '''
Welcome to DOR TO DOR 24! By accessing or using our mobile application, you agree to comply with and be bound by these terms and conditions ("Terms"). Please read these Terms carefully before using our App.
              ''',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.normal, height: 1.5),
            ),
            Text(
              '2. Use of the App',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '''
2.1: You must be at least 18 years of age to use this App.
2.2: You are responsible for maintaining the confidentiality of your account and password and for restricting access to your device to prevent unauthorized access to your account.
2.3: You agree to accept responsibility for all activities that occur under your account or password.
2.4: You don't have return policy for Vegetables, Fruits, Ice-Creams & Opened Food items.
              ''',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.normal, height: 1.5),
            ),
            Text(
              '3. User Accounts',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '''
3.1: In order to use our App, you may be required to create an account. You agree to provide accurate, current, and complete information during the registration process.
3.2: You are solely responsible for maintaining the confidentiality of your account and password and for restricting access to your account.
3.3: You agree to notify us immediately of any unauthorized use of your account or any other breach of security.
              ''',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.normal, height: 1.5),
            ),
            Text(
              '4. Ordering and Payments',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '''
4.1: By placing an order through our App, you warrant that you are legally capable of entering into binding contracts.
4.2: You agree to provide accurate and complete information when placing an order.
4.3: Payment for orders placed through our App shall be made through the payment methods provided.
4.4: We reserve the right to refuse or cancel any order at our sole discretion.
                 ''',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.normal, height: 1.5),
            ),
            Text(
              '5. Delivery',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '''
5.1: Delivery times quoted at the time of ordering are approximate only and may vary. We shall not be liable for any delay in delivery.
5.2: You agree to accept delivery of the goods at the agreed time and location.
                 ''',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.normal, height: 1.5),
            ),
            Text(
              '6. Intellectual Property',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '''
6.1: The App and its original content, features, and functionality are owned by [DOR TO DOR 24] and are protected by international copyright, trademark, patent, trade secret, and other intellectual property or proprietary rights laws.
6.2: You agree not to reproduce, modify, distribute, display, perform, or create derivative works of any part of the App.
                 ''',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.normal, height: 1.5),
            ),
            Text(
              '7. Limitation of Liability',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '''
7.1: In no event shall DOR TO DOR, nor its directors, employees, partners, agents, suppliers, or affiliates, be liable for any indirect, incidental, special, consequential, or punitive damages, including without limitation, loss of profits, data, use, goodwill, or other intangible losses.
                 ''',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.normal, height: 1.5),
            ),
            Text(
              '8. Changes to Terms',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '''
8.1: We reserve the right, at our sole discretion, to modify or replace these Terms at any time. If a revision is material, we will provide at least 30 days' notice prior to any new terms taking effect.
                 ''',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.normal, height: 1.5),
            ),
            Text(
              '9. Governing Law',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '''
9.1: These Terms shall be governed and construed in accordance with the laws of KUWAIT, without regard to its conflict of law provisions.
                 ''',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.normal, height: 1.5),
            ),
            Text(
              '10. Contact Us',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '''
10.1: If you have any questions about these Terms, please contact us at Dor2dor2024@gmail.com.
                 ''',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.normal, height: 1.5),
            ),
            const SizedBox(height: 16.0),
            Text(
              'Privacy Policy',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Text(
              '''
Dor to dor 24 operates the 'dortodor24' mobile application (the "App"). This page informs you of our policies regarding the collection, use, and disclosure of personal data when you use our App and the choices you have associated with that data.
              ''',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.normal, height: 1.5),
            ),
            Text(
              'Information Collection and Use',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '''
We collect several different types of information for various purposes to provide and improve our App to you.
              ''',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.normal, height: 1.5),
            ),
            Text(
              'Types of Data Collected',
              style: Theme.of(context).textTheme.titleMedium,
            ),
            Text(
              '''
- Personal Data: While using our App, we may ask you to provide us with certain personally identifiable information that can be used to contact or identify you ("Personal Data"). Personally identifiable information may include, but is not limited to:
  - Email address
  - First name and last name
  - Phone number
  - Address, State, Province, ZIP/Postal code, City
  - Cookies and Usage Data
  - Usage Data: We may also collect information about how the App is accessed and used ("Usage Data"). This Usage Data may include information such as your device's Internet Protocol address (e.g. IP).
                ''',
              style: Theme.of(context)
                  .textTheme
                  .headlineLarge!
                  .copyWith(fontWeight: FontWeight.normal, height: 1.5),
            ),
          ],
        ),
      ),
    );
  }
}
