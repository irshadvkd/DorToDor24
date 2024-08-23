import 'package:flutter/material.dart';

import '../../Helper/colors.dart';
import '../../Helper/common_card.dart';
import 'edit_address_button.dart';

class AddressCard extends StatelessWidget {
  const AddressCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CommonCard(
      height: 220,
      boxShadowEnable: true,
      borderRadius: 12,
      padding: const EdgeInsets.all(6),
      margin: const EdgeInsets.only(bottom: 8,),
      child: Row(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    Text(
                      'Governorate : ',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.textMain,overflow: TextOverflow.clip),
                    ),
                    Text(
                      'Al-Ahmadi Governorate',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.textMain,overflow: TextOverflow.clip),
                    ),
                  ],
                ),
                const SizedBox(width: 5,),
                Row(
                  children: [
                    Text(
                      'City : ',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.textMain,overflow: TextOverflow.clip),
                    ),
                    Text(
                      'Sabah Al-ahmed A',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.textMain,overflow: TextOverflow.clip),
                    ),
                  ],
                ),
                const SizedBox(width: 5,),
                Row(
                  children: [
                    Text(
                      'Block : ',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.textMain,overflow: TextOverflow.clip),
                    ),
                    Text(
                      'Block 3',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.textMain,overflow: TextOverflow.clip),
                    ),
                  ],
                ),
                const SizedBox(width: 5,),
                Row(
                  children: [
                    Text(
                      'Street : ',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.textMain,overflow: TextOverflow.clip),
                    ),
                    Text(
                      '319',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.textMain,overflow: TextOverflow.clip),
                    ),
                  ],
                ),
                const SizedBox(width: 5,),
                Row(
                  children: [
                    Text(
                      'Building : ',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.textMain,overflow: TextOverflow.clip),
                    ),
                    Text(
                      '316',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.textMain,overflow: TextOverflow.clip),
                    ),
                  ],
                ),
                const SizedBox(width: 5,),
                Row(
                  children: [
                    Text(
                      'Floor : ',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.textMain,overflow: TextOverflow.clip),
                    ),
                    Text(
                      '2',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.textMain,overflow: TextOverflow.clip),
                    ),
                  ],
                ),
                const SizedBox(width: 5,),
                Row(
                  children: [
                    Text(
                      'Apartment : ',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.textMain,overflow: TextOverflow.clip),
                    ),
                    Text(
                      '1',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.textMain,overflow: TextOverflow.clip),
                    ),
                  ],
                ),
                const SizedBox(width: 5,),
                Row(
                  children: [
                    Text(
                      'Phone : ',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.textMain,overflow: TextOverflow.clip),
                    ),
                    Text(
                      ' +971 123 456 78',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(color: colors.textMain,overflow: TextOverflow.clip),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const EditAddressButton(),
        ],
      ),
    );
  }
}
