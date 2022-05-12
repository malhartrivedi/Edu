import 'dart:async';

import 'package:admin/utils/app_color.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatDetailPage extends StatefulWidget {
  const ChatDetailPage({Key? key}) : super(key: key);

  @override
  _ChatDetailPageState createState() => _ChatDetailPageState();
}

class _ChatDetailPageState extends State<ChatDetailPage> {

  List<String> messages = <String>[];
  ScrollController scrollController = ScrollController();
  final messageController = TextEditingController();

  String get message => messageController.text;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteOff,
      resizeToAvoidBottomInset: false,
      appBar: _getAppBar(),
      bottomNavigationBar: _getBottomNavigationBar(),
      body: _getBody(),
    );
  }

  _getAppBar() {
    return AppBar(
      title: Text("Chat with Teacher"),
      backgroundColor: blueDarkLight,
    );
  }

  _getBody() {
    Timer(
        Duration(milliseconds: 100),
            () =>
            scrollController.jumpTo(scrollController.position.maxScrollExtent));
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).requestFocus(new FocusNode());
      },
      child: ListView.builder(
          controller: scrollController,
          itemCount: messages.length,
          shrinkWrap: true,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: index % 2 == 0
                    ? MainAxisAlignment.start
                    : MainAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 46.h,
                    width: 46.h,
                    child: index % 2 == 0
                        ? Card(
                      color: blueDarkLight3,
                      child: Align(
                        child: Text(
                          'T',
                        ),
                        alignment: Alignment.center,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(50.w),
                      ),
                    )
                        : null,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.w),
                      color: index % 2 == 0 ? grey: blueDarkLight,
                    ),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              constraints: BoxConstraints(
                                maxWidth:
                                MediaQuery.of(context).size.width * 0.5,
                              ),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    top: 12.h, left: 8.w, right: 8.w),
                                child: Text(
                                  messages[index],
                                  style: TextStyle(
                                      color: index % 2 == 0 ? black : white),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    vertical: 8.h, horizontal: 6.w),
                                child: Row(
                                  children: [
                                    Text(
                                      '12:36',
                                      style: TextStyle(
                                          fontSize: 12,
                                          color:
                                          index % 2 == 0 ? black : white),
                                    ),
                                    SizedBox(

                                      width: 2.w,
                                    ),
                                    Icon(
                                      Icons.check,
                                      size: 14.sp,
                                      color: index % 2 == 0 ? black : white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          }),
    );
  }

  _getBottomNavigationBar() {
    return Padding(
      padding: MediaQuery.of(context).viewInsets,
      child: Container(
        child: Row(
          children: [
            Expanded(
              child: Container(
                child: Row(
                  children: [
                    SizedBox(width: 6.w),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(left: 8.0),
                        child: TextField(
                          textCapitalization: TextCapitalization.sentences,
                          maxLines: null,
                          decoration: InputDecoration(
                              hintText: "Type your message",
                              border: InputBorder.none),
                          controller: messageController,
                        ),
                      ),
                    ),
                  ],
                ),
                margin: EdgeInsets.only(left: 10, bottom: 8),
                height: 60.h,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30.w),
                  color: blueDarkLight30,
                ),
              ),
            ),
            SizedBox(width: 8.w),
            InkWell(
              onTap: () {
                setState(() => messages.add(message));
                messageController.clear();
                // aa = true;
              },
              child: Container(
                height: 50.h,
                width: 50.w,
                child: Icon(
                  Icons.send,
                  color: white,
                ),
                decoration: BoxDecoration(
                    color: blueDarkLight,
                    borderRadius: BorderRadius.circular(24.w)),
              ),
            ),
            SizedBox(width: 10)
          ],
        ),
      ),
    );
  }
}
