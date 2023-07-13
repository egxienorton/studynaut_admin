import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:path_provider/path_provider.dart';

import 'package:uc_pdfview/uc_pdfview.dart';

// import '../../....//core/data/ODB/objectdb.dart';

class PDFScreen extends StatefulWidget {
  final String path;

  // learn about android file paths in data for better routings
  PDFScreen({required this.path, Key? key}) : super(key: key);

  _PDFScreenState createState() => _PDFScreenState();
}

class _PDFScreenState extends State<PDFScreen> with WidgetsBindingObserver {
  final Completer<PDFViewController> _controller =
      Completer<PDFViewController>();
  int? pages = 0;
  int? currentPage = 0;
  bool isReady = false;
  String errorMessage = '';
  DateTime pre_backpress = DateTime.now();
  dynamic argumentData = Get.arguments;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // getThePage();
  }

  getThePage() async {
    String keygen = argumentData[0]['keygen'];

    List locators = await LocatorDB().getLocator(keygen);
    //
    print(locators);
    print(locators[0]);

    // setState(() {
    //   currentPage = 2;
    // });
    print('THis is what i wanted : $keygen');
  }

  saveLastPage(String pageNumber) async {
    String keygen = argumentData[0]['keygen'];

    List locators = await LocatorDB().getLocator(keygen);
    //
    Map<String, dynamic> forensic = {'bookId': keygen, 'lastpage': pageNumber};
    // Map json = jsonDecode(forensic);
    // json['bookId'] = chapname;
    // Save locator to your database
    await LocatorDB().update(forensic);

    print('THe deed has been done');
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        // save the last page to the date base here...

        String inof = (currentPage! + 1).toString();

        final timegap = DateTime.now().difference(pre_backpress);
        final cantExit = timegap >= const Duration(seconds: 2);
        pre_backpress = DateTime.now();
        if (cantExit) {
          // saveLastPage(inof);   debug this later on
          Get.snackbar(
              'Done Studying?  $inof', 'Press Back button again to Exit',
              snackPosition: SnackPosition.BOTTOM);
          return false; // false will do nothing when back press
        } else {
          // saveLastPage(inof);
          return true; // true will exit the app
        }
      },
      child: Scaffold(
        body: Stack(
          children: <Widget>[
            UCPDFView(
              filePath: widget.path,
              enableSwipe: true,
              swipeHorizontal: true,
              autoSpacing: false,
              pageFling: true,
              pageSnap: true,
              defaultPage: currentPage!,
              fitPolicy: FitPolicy.BOTH,
              preventLinkNavigation:
                  false, // if set to true the link is handled in flutter
              onRender: (_pages) {
                setState(() {
                  pages = _pages;
                  isReady = true;
                });
              },
              onError: (error) {
                setState(() {
                  errorMessage = error.toString();
                });
                print(error.toString());
              },
              onPageError: (page, error) {
                setState(() {
                  errorMessage = '$page: ${error.toString()}';
                });
                print('$page: ${error.toString()}');
              },
              onViewCreated: (PDFViewController pdfViewController) {
                _controller.complete(pdfViewController);
              },
              onLinkHandler: (String? uri) {
                print('goto uri: $uri');
              },
              onPageChanged: (int? page, int? total) async {
                int addon = page! + 1;
                print('page change: $addon/$total');
                setState(() {
                  currentPage = page;
                });
              },
            ),
            errorMessage.isEmpty
                ? !isReady
                    ? const Center(
                        child: CircularProgressIndicator(),
                      )
                    : Container()
                : Center(
                    child: Text(errorMessage),
                  )
          ],
        ),
        floatingActionButton: FutureBuilder<PDFViewController>(
          future: _controller.future,
          builder: (context, AsyncSnapshot<PDFViewController> snapshot) {
            if (snapshot.hasData) {
              return FloatingActionButton.extended(
                label: Text("Go to ${pages! ~/ 2}"),
                onPressed: () async {
                  await snapshot.data!.setPage(pages! ~/ 2);
                },
              );
            }

            return Container();
          },
        ),
      ),
    );
  }
}
