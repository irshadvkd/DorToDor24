import 'package:flutter/material.dart';

import '../../Helper/colors.dart';
import '../../Helper/common_button.dart';

class EditAddressButton extends StatelessWidget {
  const EditAddressButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CommonButton(
      width: 40,
      height: 30,
      color: colors.themeButton,
      text: 'Edit',
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 0),
      style: Theme.of(context).textTheme.bodySmall!.copyWith(
          color: colors.white, fontWeight: FontWeight.w600),
      onTap: () {
        showEditDialog(context);
      },
    );
  }
  Widget buildRow(BuildContext context, String label, String value) {
    return Row(
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Colors.blue, overflow: TextOverflow.clip),
        ),
        Text(
          value,
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: Colors.blue, overflow: TextOverflow.clip),
        ),
      ],
    );
  }

  void showEditDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                buildEditTextField('Governorate', 'Al-Ahmadi Governorate'),
                buildEditTextField('City', 'Sabah Al-ahmed A'),
                buildEditTextField('Block', 'Block 3'),
                buildEditTextField('Street', '319'),
                buildEditTextField('Building', '316'),
                buildEditTextField('Floor', '2'),
                buildEditTextField('Apartment', '1'),
                buildEditTextField('Phone', '+971 123 456 78'),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CommonButton(
                        width: 120,
                        color: colors.themeButton,
                        text: "Cancel",
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: colors.white, fontWeight: FontWeight.w600),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                      CommonButton(
                        width: 120,
                        color: colors.themeButton,
                        text: "Confirm",
                        height: 50,
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 0),
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: colors.white, fontWeight: FontWeight.w600),
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget buildEditTextField(String label, String initialValue) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextFormField(
        initialValue: initialValue,
        decoration: InputDecoration(
          labelText: label,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}