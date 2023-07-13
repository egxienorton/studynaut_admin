import "package:flutter/material.dart";
import "package:iconly/iconly.dart";
import 'package:studynaut_admin/core/typography/typo.dart';

import '../../../core/typography/curtina.dart';
import '../../../core/typography/forma.dart';
import '../../../core/utils/text_formatter/no_space.dart';
import '../../../core/wizzy/button.dart';

class AskQuestionDialog extends StatefulWidget {
  AskQuestionDialog({super.key});

  @override
  State<AskQuestionDialog> createState() => _AskQuestionDialogState();
}

class _AskQuestionDialogState extends State<AskQuestionDialog> {
  final _formKey = GlobalKey<FormState>();
  List<String> tags = [];
  TextEditingController tagController = TextEditingController();

  void addTag(String tag) {
    setState(() {
      tags.add(tag);
      tagController.clear();
    });
  }

  void removeTag(String tag) {
    setState(() {
      tags.remove(tag);
    });
  }

  void _submitForm(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // // Form is valid, perform necessary actions
      // studynautz.createClass(classMap['className'], classMap['description'] ?? '',
      //     classMap['room'], classMap['subject'], context);
    } else {
      // Form is invalid, handle the invalid state
      print('Form is invalid');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        height: MediaQuery.of(context).size.height * .65,
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
                'Ask a Question',
                // textAlign: TextAlign.left,
                style: AppTypography.header1(context)
                    .copyWith(letterSpacing: 0, fontSize: 32),
              ),
              // Text('',
              //     // textAlign: TextAlign.left,
              //     style: AppTypography.header3(context)
              //     // .copyWith(letterSpacing: 0, fontSize: 32),
              //     ),
              SizedBox(
                height: 10,
              ),
              Container(
                padding: EdgeInsets.all(6),
                margin: EdgeInsets.only(bottom: 5),
                decoration:
                    roundContainer.copyWith(color: Theme.of(context).cardColor),
                child: TextFormField(
                  decoration: xFormInput.copyWith(
                      hintText: 'Type your question here (Latex supported)'),
                  maxLines: 8,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please describe your question';
                    }
                    return null;
                  },
                  onSaved: (val) {
                    // classMap['className'] = val;
                  },
                ),
              ),
              Wrap(
                spacing: 8.0,
                runSpacing: 4.0,
                children: tags.map((tag) {
                  return Chip(
                    label: Text(tag),
                    onDeleted: () => removeTag(tag),
                  );
                }).toList(),
              ),

              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Expanded(
                      child: Container(
                        decoration: roundContainer,
                        child: TextField(
                          inputFormatters: [NoSpaceInputFormatter()],
                          controller: tagController,
                          decoration: InputDecoration(
                            hintText: 'Enter a tag',
                            hintStyle: AppTypography.header6(context),
                            // suffixIcon: IconButton(
                            //   icon: Icon(Icons.add),
                            //   // onPressed: () => addTag(tagController.text),
                            // ),
                          ),
                        ),
                      ),
                    ),
                    WButton(
                      label: 'Add tag',
                      onPressed: () {
                        addTag(tagController.text);
                        tagController.clear();
                      },
                      icon: Icons.add,
                    ),
                  ],
                ),
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  WButton(
                    label: 'Add Attachment',
                    onPressed: () => _submitForm(context),
                    icon: Icons.attach_file,
                  )
                ],
              ),
              SizedBox(
                height: 15,
              ),
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(15),
                margin: EdgeInsets.symmetric(horizontal: 4),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(25)),
                    color: Theme.of(context).primaryColorDark),
                child: Text(
                  'Post Question',
                  textAlign: TextAlign.center,
                  style: AppTypography.header3(context),
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
