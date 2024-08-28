import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:dorTodor24/Helper/colors.dart';
import 'package:dorTodor24/Helper/common_text_field.dart';

class CommonDropDownSearch extends StatelessWidget {
  final String hintText;
  final List list;
  final String selected;
  final void Function(Object?) onChange;
  final String? validatorText;
  final bool? enabled;
  CommonDropDownSearch({
    Key? key,
    required this.hintText,
    required this.list,
    required this.selected,
    required this.onChange,
    this.validatorText,
    this.enabled,
  }) : super(key: key);

  final TextEditingController search = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField2<dynamic>(
        isExpanded: true,
        hint: Text(
          hintText,
          style: Theme.of(context)
              .textTheme
              .headlineSmall!
              .copyWith(color: colors.grey),
        ),
        items: list.map((item) {
          return DropdownMenuItem(
            value: item["id"],
            enabled: enabled ?? true,
            child: Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.centerLeft,
              child: Text(
                item["name"],
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
          );
        }).toList(),
        value: selected == "" ? null : selected,
        onChanged: onChange,
        decoration: InputDecoration(
          filled: true,
          fillColor: colors.white,
          isDense: true,
          contentPadding: const EdgeInsets.fromLTRB(0, 12, 0, 12),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0x29000000)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0x29000000)),
          ),
          errorBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Colors.red),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(color: Color(0x29000000)),
          ),
          errorStyle: Theme.of(context)
              .textTheme
              .titleLarge!
              .copyWith(color: Colors.red, fontWeight: FontWeight.w400),
        ),
        validator: (value) {
          return validatorText != ""
              ? value == null
                  ? validatorText
                  : null
              : null;
        },
        iconStyleData: const IconStyleData(
          iconEnabledColor: colors.primary,
          iconDisabledColor: colors.primary,
          icon: Padding(
            padding: EdgeInsets.only(right: 10),
            child: Icon(Icons.arrow_drop_down),
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          padding: EdgeInsets.fromLTRB(10, 5, 10, 5),
        ),
        dropdownStyleData: DropdownStyleData(
          maxHeight: 200,
          padding: null,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(6),
            gradient: const LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [colors.white, colors.third],
            ),
            boxShadow: const [
              BoxShadow(
                color: Color(0x29000000),
                blurRadius: 3,
              ),
            ],
          ),
          scrollbarTheme: ScrollbarThemeData(
            radius: const Radius.circular(40),
            thickness: MaterialStateProperty.all(6),
            thumbVisibility: MaterialStateProperty.all(true),
          ),
        ),
        dropdownSearchData: DropdownSearchData(
          searchController: search,
          searchInnerWidgetHeight: 50,
          searchInnerWidget: Padding(
            padding: const EdgeInsets.fromLTRB(12, 12, 12, 0),
            child: CommonTextField(
              hintText: 'Search the bus depot',
              maxLines: 1,
              textController: search,
            ),
          ),
          searchMatchFn: (item, searchValue) {
            for (var i = 0; i < list.length; i++) {
              if (item.value == list[i]['id']) {
                return list[i]['name']
                    .toString()
                    .toLowerCase()
                    .contains(searchValue.toLowerCase());
              }
            }
            return false;
          },
        ),
        //This to clear the search value when you close the menu
        onMenuStateChange: (isOpen) {
          if (!isOpen) {
            search.clear();
          }
        },
      ),
    );
  }
}
