import 'package:flutter/material.dart';
import 'package:localstore/localstore.dart';

import '../../reg/data_cylinder_models.dart';

class ModuleHomePage extends StatefulWidget {
  const ModuleHomePage(
      {Key? key, required this.courseName, required this.chapterName})
      : super(key: key);

  final String courseName;
  final String chapterName;

  @override
  _ModuleHomePageState createState() => _ModuleHomePageState();
}

class _ModuleHomePageState extends State<ModuleHomePage> {
  final _db = Localstore.instance;
  var _items = <String, dynamic>{};
  List<CourseModule> chaps = [];

  cha() {
    final data = _db
        .collection('courses')
        .doc(widget.courseName)
        .collection(widget.chapterName)
        .doc('datacenter')
        .get()
        .then(
      (value) {
        // print(value);
        List modules = value!['modules'];
        print(modules);

        modules.forEach((element) {
          var res = CourseModule.fromMap(element);
          print(res.moduleName);

          setState(() {
            _items.putIfAbsent(res.moduleName, () => res);
          });
        });
      },
    );

    // setState(() {
    //   final item = CourseItemModel.fromMap(event);
    //   _items.putIfAbsent(item.courseName, () => item);
    // });
  }

  @override
  void initState() {
    cha();
    //STABLE RELEASE 3.4
    // final data2 = _db
    //     .collection('courses')
    //     .doc(widget.courseName)
    //     .collection('Momentum and Impulse')
    //     .doc('datacenter')
    //     .get()
    //     .then((value) {
    //   print(value);
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.chapterName)),
      body: ListView.builder(
        itemCount: _items.keys.length,
        itemBuilder: (context, index) {
          final key = _items.keys.elementAt(index);
          final item = _items[key]!;
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CheckboxListTile(
                  value: true,
                  title: Text(item.moduleName),
                  onChanged: (value) {
                    // item.done = value!;

                    // CourseModule.fromMap(item).save();
                    // // item.save();
                  },
                  secondary: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        // item.delete();
                        _items.remove(item.chapterName);
                      });
                    },
                  ),
                ),
                InkWell(
                    onTap: () {
                      // Get.to(() => QuickDetailsPage(,));
                    },
                    child: Row(
                      children: [
                        Container(
                            padding: const EdgeInsets.all(8),
                            child: const Icon(Icons.book)),
                      ],
                    ))
              ],
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        tooltip: 'add',
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  @override
  void dispose() {
    // if (_subscription != null) _subscription?.cancel();
    super.dispose();
  }
}
