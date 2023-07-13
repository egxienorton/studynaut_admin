import 'package:easy_separator/easy_separator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:get/get.dart';

import '../enums/loading_status.dart';
import '../models/quiz_paper_model.dart';
import 'leader_boaed_model.dart';
import 'leader_board_controller.dart';
import 'leaderboard_placeholder.dart';
import 'widgets/content_area.dart';
import 'widgets/custom_app_bar.dart';
import 'widgets/icon_with_text.dart';
import 'widgets/screen_background_decoration.dart';
// import 'package:studymaze/QLED/Home/P_Scene/programs/courses/quizzle/leaderboard/widgets/content_area.dart';
// import 'package:studymaze/QLED/Home/P_Scene/programs/courses/quizzle/leaderboard/widgets/custom_app_bar.dart';
// import 'package:studymaze/QLED/Home/P_Scene/programs/courses/quizzle/leaderboard/widgets/icon_with_text.dart';
// import 'package:studymaze/QLED/Home/P_Scene/programs/courses/quizzle/leaderboard/leader_boaed_model.dart';
// import 'package:studymaze/QLED/Home/P_Scene/programs/courses/quizzle/leaderboard/leader_board_controller.dart';
// import 'package:studymaze/QLED/Home/P_Scene/programs/courses/quizzle/leaderboard/widgets/screen_background_decoration.dart';
// import 'package:studymaze/QLED/Home/P_Scene/programs/courses/quizzle/models/quiz_paper_model.dart';
// import 'package:studymaze/UTILITIES/component/shimmers/leaderboard_placeholder.dart';
// import 'package:studymaze/UTILITIES/enums/loading_status.dart';

class LeaderBoardScreen extends GetView<LeaderBoardController> {
  LeaderBoardScreen({Key? key}) : super(key: key) {
    SchedulerBinding.instance.addPostFrameCallback((d) {
      final paper = Get.arguments as QuizPaperModel;
      controller.getAll(paper.id);
      controller.getMyScores(paper.id);
    });
  }

  static const String routeName = '/leaderboard';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: const CustomAppBar(),
      bottomNavigationBar: Obx(() => controller.myScores.value == null
          ? const SizedBox()
          : LeaderBoardCard(
              data: controller.myScores.value!,
              index: -1,
            )),
      body: Center(
        child: BackgroundDecoration(
          showGradient: true,
          child: Obx(
            () => controller.loadingStatus.value == LoadingStatus.loading
                ? const ContentArea(
                    addPadding: true,
                    child: LeaderBoardPlaceHolder(),
                  )
                : ContentArea(
                    addPadding: false,
                    child: ListView.separated(
                      itemCount: controller.leaderBoard.length,
                      separatorBuilder: (BuildContext context, int index) {
                        return const Divider();
                      },
                      itemBuilder: (BuildContext context, int index) {
                        final data = controller.leaderBoard[index];
                        return LeaderBoardCard(
                          data: data,
                          index: index,
                        );
                      },
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}

class LeaderBoardCard extends StatelessWidget {
  const LeaderBoardCard({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final LeaderBoardData data;
  final int index;

  @override
  Widget build(BuildContext context) {
    const tsStyle = TextStyle(fontWeight: FontWeight.bold);
    return ListTile(
      leading: CircleAvatar(
        foregroundImage:
            data.user.image == null ? null : NetworkImage(data.user.image!),
      ),
      title: Text(
        data.user.name,
        style: tsStyle,
      ),
      subtitle: EasySeparatedRow(
        crossAxisAlignment: CrossAxisAlignment.center,
        separatorBuilder: (BuildContext context, int index) {
          return const SizedBox(
            width: 12,
          );
        },
        children: [
          IconWithText(
            icon: Icon(
              Icons.done_all,
              color: Theme.of(context).primaryColor,
            ),
            text: Text(
              data.correctCount!,
              style: tsStyle,
            ),
          ),
          IconWithText(
            icon: Icon(
              Icons.timer,
              color: Theme.of(context).primaryColor,
            ),
            text: Text(
              '${data.time!}',
              style: tsStyle,
            ),
          ),
          IconWithText(
            icon: Icon(
              Icons.emoji_events_outlined,
              color: Theme.of(context).primaryColor,
            ),
            text: Text(
              '${data.points!}',
              style: tsStyle,
            ),
          ),
        ],
      ),
      trailing: Text(
        '#' + '${index + 1}'.padLeft(2, "0"),
        style: tsStyle,
      ),
    );
  }
}
