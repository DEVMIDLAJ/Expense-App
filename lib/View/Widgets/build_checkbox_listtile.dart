// ignore_for_file: unused_local_variable

import 'package:expence_app/Model/checkbox_listtile_model.dart';
import 'package:expence_app/View/Widgets/display_text.dart';
import 'package:expence_app/controller/provider/profile_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BuildCheckboxListTile extends StatelessWidget {
  final List<CheckboxListTileModel> newCheckList;

  const BuildCheckboxListTile({
    super.key,
    required this.newCheckList,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    ProfileProvider checkBoxListTileProvider =
        Provider.of<ProfileProvider>(context);

    return ListView.separated(
      shrinkWrap: true,
      itemCount: newCheckList.length,
      separatorBuilder: (context, index) {
        return SizedBox(
          height: size.height * 0.02,
        );
      },
      itemBuilder: (context, index) {
        final isSelected = checkBoxListTileProvider.selectedIndex == '$index';
        return GestureDetector(
          onTap: () {
            final isSelected = checkBoxListTileProvider.setCurrentIndex(context,
                index: '$index');
            // Update the selectedIndex when the ListTile is tapped
          },
          child: Card(
            color: Colors.white10,
            elevation: 0,
            child: Row(
              children: [
                DisplayText(
                  title: newCheckList[index].title,
                  textSize: 16,
                  textFont: FontWeight.w500,
                ),
                DisplayText(
                  title: newCheckList[index].subTitle,
                  textSize: 16,
                  textFont: FontWeight.w500,
                ),
                const Spacer(),
                isSelected
                    ? Checkbox(
                        value: isSelected,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        onChanged: (value) {},
                      )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        );
      },
    );
  }
}
