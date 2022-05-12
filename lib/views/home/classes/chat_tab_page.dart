import 'package:admin/utils/app_color.dart';
import 'package:admin/views/home/classes/chat_detail_page.dart';
import 'package:flutter/material.dart';

class ChatTabPage extends StatefulWidget {
  const ChatTabPage({Key? key}) : super(key: key);

  @override
  _ChatTabPageState createState() => _ChatTabPageState();
}

class _ChatTabPageState extends State<ChatTabPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.all(12.0),
          child: FloatingActionButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatDetailPage(),
                ),
              );
            },
            backgroundColor: blueDarkLight2,
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
