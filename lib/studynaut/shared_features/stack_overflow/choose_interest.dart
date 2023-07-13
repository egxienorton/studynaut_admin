import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:studynaut_admin/core/typography/typo.dart';
import 'package:studynaut_admin/core/wizzy/button.dart';
import 'package:studynaut_admin/core/wizzy/xDialogs.dart';
import 'package:studynaut_admin/stack_overflow/home.dart';

class ChooseInterest extends StatelessWidget {
  const ChooseInterest({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Select your favorite topics',
                  style: AppTypography.header1(context)
                      .copyWith(letterSpacing: -1, fontSize: 36),
                ),
                SizedBox(
                  height: 30,
                ),
                InterestChip(),
                SizedBox(
                  height: 40,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    WButton(
                      onPressed: () {
                        Get.to(() => SolvoHome());
                      },
                      label: 'Continue',
                      icon: IconlyBold.arrow_right_2,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class InterestChip extends StatefulWidget {
  @override
  _InterestChipState createState() => _InterestChipState();
}

class _InterestChipState extends State<InterestChip> {
  List<String> selectedInterests = [];

  void toggleInterest(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else if (selectedInterests.length < 5) {
        selectedInterests.add(interest);
      } else {
        ExDialogs.showSnackbar(context, 'You can only select up to 5');
      }
    });
  }

  bool isInterestSelected(String interest) {
    return selectedInterests.contains(interest);
  }

  @override
  Widget build(BuildContext context) {
    List<String> interests = [
      'Math',
      'Art',
      'Psychology',
      'Law',
      'Medicine',
      'English',
      'Engineering',
      'Physics',
      'Chemistry',
      'Philosophy',
      'Government',
      'Biology',
    ];

    return Wrap(
      spacing: 8.0,
      runSpacing: 4.0,
      children: interests.map((interest) {
        return FilterChip(
          selectedColor: Theme.of(context).primaryColor,
          label: Text(
            interest,
            style: TextStyle(fontFamily: 'Satoshis'),
          ),
          selected: isInterestSelected(interest),
          onSelected: (_) => toggleInterest(interest),
        );
      }).toList(),
    );
  }
}
