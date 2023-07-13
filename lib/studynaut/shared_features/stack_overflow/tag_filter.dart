import 'package:flutter/material.dart';

class InterestTag extends StatefulWidget {
  @override
  _InterestTagState createState() => _InterestTagState();
}

class _InterestTagState extends State<InterestTag> {
  List<String> selectedInterests = [];

  void toggleInterest(String interest) {
    setState(() {
      if (selectedInterests.contains(interest)) {
        selectedInterests.remove(interest);
      } else if (selectedInterests.length < 5) {
        selectedInterests.add(interest);
      }
    });
  }

  bool isInterestSelected(String interest) {
    return selectedInterests.contains(interest);
  }

  @override
  Widget build(BuildContext context) {
    List<String> interests = [
      'Interest 1',
      'Interest 2',
      'Interest 3',
      'Interest 4',
      'Interest 5',
      'Interest 6',
      'Interest 7',
      'Interest 8',
      'Interest 9',
      'Interest 10',
      'Interest 11',
      'Interest 12',
    ];

    return ListView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.all(8.0),
      children: interests.map((interest) {
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 4.0),
          child: FilterChip(
            label: Text(interest),
            selected: isInterestSelected(interest),
            onSelected: (_) => toggleInterest(interest),
          ),
        );
      }).toList(),
    );
  }
}
