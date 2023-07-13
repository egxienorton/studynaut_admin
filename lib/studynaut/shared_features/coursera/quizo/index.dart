// import 'package:carbon_icons/carbon_icons.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconly/iconly.dart';
import 'package:studynautz/core/themes2/custom_text_styles.dart';
import 'package:studynautz/core/themes2/ui_parameters.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import 'controllers/quiz_papers_controller.dart';
import 'enums/loading_status.dart';
import 'leaderboard/widgets/content_area.dart';
import 'quiz_widgets/quiz_paper_card.dart';
// import 'package:studymaze/QLED/Home/P_Scene/programs/courses/quizzle/quiz_paper/quiz_widgets/quiz_paper_card.dart';
// import 'package:studymaze/UTILITIES/enums/loading_status.dart';

// import '../../../../../../../UTILITIES/configs/configs.dart';
// import '../leaderboard/widgets/content_area.dart';
// import 'micro_controllers/quiz_papers_controller.dart';

class Home1 extends StatelessWidget {
  // const Home2({Key? key}) : super(key: key);
  final LocalQuizPaperController _quizePprContoller =
      Get.put<LocalQuizPaperController>(LocalQuizPaperController());

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    // QuizPaperController _quizePprContoller = Get.find();
    return Scaffold(
      appBar: AppBar(
        title: const Text('the final braw'),
        actions: [
          IconButton(
              onPressed: () {
                _quizePprContoller.installToLDB();
              },
              icon: const Icon(IconlyBold.wallet))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => Home2());
        },
        child: const Icon(IconlyBold.activity),
      ),
      body: Container(
        decoration: const BoxDecoration(color: Colors.redAccent
            // gradient: mainGradient(context)

            ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(kMobileScreenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                        'Wanna try how good you are in Physics 111 ? Let\'s see about that !',
                        style: kHeaderTS),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ContentArea(
                    addPadding: false,
                    child: Obx(
                      () => LiquidPullToRefresh(
                        height: 150,
                        springAnimationDurationInMilliseconds: 500,
                        //backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        onRefresh: () async {
                          // _quizePprContoller.getAllPapers();
                        },
                        child: ListView.separated(
                          padding: UIParameters.screenPadding,
                          shrinkWrap: true,
                          itemCount: _quizePprContoller.allPapers.length,
                          itemBuilder: (BuildContext context, int index) {
                            return XQuizPaperCard(
                              model: _quizePprContoller.allPapers[index],
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 20,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Home2 extends StatelessWidget {
  // const Home2({Key? key}) : super(key: key);
  final QuizPaperController _quizePprContoller =
      Get.put<QuizPaperController>(QuizPaperController());

  static const String routeName = '/home';

  @override
  Widget build(BuildContext context) {
    // QuizPaperController _quizePprContoller = Get.find();
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: Colors.black
            // gradient: mainGradient(context)

            ),
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(kMobileScreenPadding),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Grab Question packs to prove yourself boy !',
                        style: kHeaderTS),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: ContentArea(
                    addPadding: false,
                    child: Obx(
                      () => LiquidPullToRefresh(
                        height: 150,
                        springAnimationDurationInMilliseconds: 500,
                        //backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
                        color: Theme.of(context).primaryColor.withOpacity(0.5),
                        onRefresh: () async {
                          _quizePprContoller.getAllPapers();
                        },
                        child: _quizePprContoller.loadingStatus.value ==
                                LoadingStatus.loading
                            ? Center(
                                child: LoadingAnimationWidget.newtonCradle(
                                  color: Colors.deepPurpleAccent,
                                  size: 100,
                                ),
                              )
                            : ListView.separated(
                                padding: UIParameters.screenPadding,
                                shrinkWrap: true,
                                itemCount: _quizePprContoller.allPapers.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return QuizPaperCard(
                                    model: _quizePprContoller.allPapers[index],
                                    cardIndex: index,
                                  );
                                },
                                separatorBuilder:
                                    (BuildContext context, int index) {
                                  return const SizedBox(
                                    height: 20,
                                  );
                                },
                              ),
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class HomeScreen extends GetView<MyDrawerController> {
//   const HomeScreen({Key? key}) : super(key: key);

//   static const String routeName = '/home';

//   @override
//   Widget build(BuildContext context) {
//     QuizPaperController _quizePprContoller = Get.find();
//     return Scaffold(
//         body: GetBuilder<MyDrawerController>(
//       builder: (_) => ZoomDrawer(
//         controller: _.zoomDrawerController,
//         borderRadius: 50.0,
//         showShadow: true,
//         angle: 0.0,
//         // style: DrawerStyle.DefaultStyle, // this is not working with the new version of the zoom drawer...
//         menuScreen: const CustomDrawer(),
//         // backgroundColor: Colors.white.withOpacity(0.5),
//         slideWidth: MediaQuery.of(context).size.width * 0.6,
//         mainScreen: Container(
//           decoration: BoxDecoration(gradient: mainGradient(context)),
//           child: SafeArea(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Padding(
//                   padding: const EdgeInsets.all(kMobileScreenPadding),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Transform.translate(
//                         offset: const Offset(-10, 0),
//                         child: CircularButton(
//                           child: const Icon(AppIcons.menuleft),
//                           onTap: controller.toggleDrawer,
//                         ),
//                       ),
//                       const SizedBox(height: 10),
//                       Padding(
//                         padding: const EdgeInsets.symmetric(vertical: 10),
//                         child: Row(
//                           children: [
//                             const Icon(AppIcons.peace),
//                             Builder(
//                               builder: (_) {
//                                 final AuthController _auth = Get.find();
//                                 final user = _auth.getUser();
//                                 String _label = '  Hello mate';
//                                 if (user != null) {
//                                   _label = '  Hello ${user.displayName}';
//                                 }
//                                 return Text(_label,
//                                     style: kDetailsTS.copyWith(
//                                         color: kOnSurfaceTextColor));
//                               },
//                             ),
//                           ],
//                         ),
//                       ),
//                       const Text('What Do You Want To Improve Today ?',
//                           style: kHeaderTS),
//                       const SizedBox(height: 15),
//                     ],
//                   ),
//                 ),
//                 Expanded(
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8),
//                     child: ContentArea(
//                       addPadding: false,
//                       child: Obx(
//                         () => LiquidPullToRefresh(
//                           height: 150,
//                           springAnimationDurationInMilliseconds: 500,
//                           //backgroundColor: Theme.of(context).primaryColor.withOpacity(0.1),
//                           color:
//                               Theme.of(context).primaryColor.withOpacity(0.5),
//                           onRefresh: () async {
//                             _quizePprContoller.getAllPapers();
//                           },
//                           child: ListView.separated(
//                             padding: UIParameters.screenPadding,
//                             shrinkWrap: true,
//                             itemCount: _quizePprContoller.allPapers.length,
//                             itemBuilder: (BuildContext context, int index) {
//                               return QuizPaperCard(
//                                 model: _quizePprContoller.allPapers[index],
//                                 cardIndex: index,
//                               );
//                             },
//                             separatorBuilder:
//                                 (BuildContext context, int index) {
//                               return const SizedBox(
//                                 height: 20,
//                               );
//                             },
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     ));
//   }
// }
