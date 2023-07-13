import 'package:flutter/material.dart';

import '../helpers/message.dart';

class ReplyMessageWidget extends StatelessWidget {
  final Message message;
  final VoidCallback onCancelReply;

  const ReplyMessageWidget({
    required this.message,
    required this.onCancelReply,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => IntrinsicHeight(
        child: Row(
          children: [
            Container(
              color: Colors.green,
              width: 4,
            ),
            const SizedBox(width: 8),
            Expanded(child: buildReplyMessage()),
          ],
        ),
      );

  Widget buildReplyMessage() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  // '${message.firstName}',
                  'A name here',
                  style:
                      const TextStyle(fontWeight: FontWeight.bold, fontSize: 8),
                ),
              ),
              if (onCancelReply != null)
                GestureDetector(
                  child: const Icon(Icons.close, size: 16),
                  onTap: onCancelReply,
                )
            ],
          ),
          const SizedBox(height: 8),
          Text(message.message, style: const TextStyle(color: Colors.black54)),
        ],
      );
}
