import "package:flutter/material.dart";
import "package:iconly/iconly.dart";
import 'package:studynaut_admin/core/typography/typo.dart';
import 'package:studynaut_admin/lectura/controller/lecturer.dart';

import '../../typography/curtina.dart';
import '../../typography/forma.dart';
import '../../wizzy/button.dart';

class AddClassDialog extends StatelessWidget {
  AddClassDialog({super.key});

  Map<String, dynamic> classMap = {
    'className': '',
    'description': '',
  };

  final _formKey = GlobalKey<FormState>();
  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // Form is valid, perform necessary actions
      Lectura.createClass(classMap['className'], classMap['description'] ?? '',
          classMap['room'], classMap['subject'], context);
    } else {
      // Form is invalid, handle the invalid state
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * .8,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.0), // Customize the border radius here
        ),
      ),
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 20),
      // color: Colors.white,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          //TODO: Activate global keys and validate this boy
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(
              'Add a Class',
              // textAlign: TextAlign.left,
              style: AppTypography.header1(context)
                  .copyWith(letterSpacing: 0, fontSize: 32),
            ),
            Text('Kick Start your new class by providing some information',
                // textAlign: TextAlign.left,
                style: AppTypography.header3(context)
                // .copyWith(letterSpacing: 0, fontSize: 32),
                ),
            SizedBox(
              height: 30,
            ),
            Container(
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.only(bottom: 5),
              decoration:
                  roundContainer.copyWith(color: Theme.of(context).cardColor),
              child: TextFormField(
                decoration: xFormInput.copyWith(hintText: 'Class Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your Class Name';
                  }
                  return null;
                },
                onSaved: (val) {
                  classMap['className'] = val;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.only(bottom: 5),
              decoration:
                  roundContainer.copyWith(color: Theme.of(context).cardColor),
              child: TextFormField(
                decoration: xFormInput.copyWith(hintText: 'Description'),
                onSaved: (val) {
                  classMap['description'] = val;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Write about the class';
                  }
                  return null;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.only(bottom: 5),
              decoration:
                  roundContainer.copyWith(color: Theme.of(context).cardColor),
              child: TextFormField(
                decoration: xFormInput.copyWith(hintText: 'Section'),
                onSaved: (val) {
                  classMap['section'] = val;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.only(bottom: 5),
              decoration:
                  roundContainer.copyWith(color: Theme.of(context).cardColor),
              child: TextFormField(
                decoration: xFormInput.copyWith(hintText: 'Session'),
                onSaved: (val) {
                  classMap['session'] = val;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.only(bottom: 5),
              decoration:
                  roundContainer.copyWith(color: Theme.of(context).cardColor),
              child: TextFormField(
                decoration: xFormInput.copyWith(hintText: 'Room'),
                onSaved: (val) {
                  classMap['room'] = val;
                },
              ),
            ),
            Container(
              padding: EdgeInsets.all(6),
              margin: EdgeInsets.only(bottom: 5),
              decoration: roundContainer
                  .copyWith(color: Theme.of(context).cardColor)
                  .copyWith(borderRadius: BorderRadius.circular(10)),
              child: TextFormField(
                decoration: xFormInput.copyWith(hintText: 'Subject'),
                onSaved: (val) {
                  classMap['subject'] = val;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Subject';
                  }
                  return null;
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                WButton(
                  label: 'Create Class',
                  onPressed: () => _submitForm(context),
                  icon: Icons.add,
                )
              ],
            )
          ]),
        ),
      ),
    );
  }
}
