import 'package:flutter/material.dart';
import 'package:seekhobuddy/Chat/chatUsersModel.dart';
import 'package:seekhobuddy/Chat/conversationList.dart';

class ChatPage extends StatefulWidget {
  @override
  _ChatPageState createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  List<ChatUsers> chatUsers = [
    ChatUsers(
      text: "Jane Russel",
      secondaryText: "Awesome Setup",
      image:
          "https://images.unsplash.com/photo-1567515004624-219c11d31f2e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMDUzMDJ8MHwxfHNlYXJjaHw1MXx8bWFufGVufDF8fHx8MTY2Njc4NzAwOA&ixlib=rb-4.0.3&q=80&w=1080",
      time: "Now",
    ),
    ChatUsers(
      text: "Glady's Murphy",
      secondaryText: "That's Great",
      image:
          "https://images.unsplash.com/photo-1596305589440-2e180399a760?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMDUzMDJ8MHwxfHNlYXJjaHwxMjJ8fGJsYWNrJTIwd29tYW58ZW58MXx8fHwxNjY2ODY1MDg3&ixlib=rb-4.0.3&q=80&w=1080",
      time: "Yesterday",
    ),
    ChatUsers(
      text: "Jorge Henry",
      secondaryText: "Hey where are you?",
      image:
          "https://images.unsplash.com/photo-1607990281513-2c110a25bd8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMDUzMDJ8MHwxfHNlYXJjaHwyNXx8bWFufGVufDF8fHx8MTY2NjYzNjY1Nw&ixlib=rb-4.0.3&q=80&w=1080",
      time: "31 Mar",
    ),
    ChatUsers(
        text: "Philip Fox",
        secondaryText: "Busy! Call me in 20 mins",
        image:
            "https://images.unsplash.com/photo-1567515004624-219c11d31f2e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMDUzMDJ8MHwxfHNlYXJjaHw1MXx8bWFufGVufDF8fHx8MTY2Njc4NzAwOA&ixlib=rb-4.0.3&q=80&w=1080",
        time: "28 Mar"),
    ChatUsers(
        text: "Debra Hawkins",
        secondaryText: "Thankyou, It's awesome",
        image:
            "https://images.unsplash.com/photo-1567515004624-219c11d31f2e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMDUzMDJ8MHwxfHNlYXJjaHw1MXx8bWFufGVufDF8fHx8MTY2Njc4NzAwOA&ixlib=rb-4.0.3&q=80&w=1080",
        time: "23 Mar"),
    ChatUsers(
        text: "Jacob Pena",
        secondaryText: "will update you in evening",
        image:
            "https://images.unsplash.com/photo-1567515004624-219c11d31f2e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMDUzMDJ8MHwxfHNlYXJjaHw1MXx8bWFufGVufDF8fHx8MTY2Njc4NzAwOA&ixlib=rb-4.0.3&q=80&w=1080",
        time: "17 Mar"),
    ChatUsers(
        text: "Andrey Jones",
        secondaryText: "Can you please share the file?",
        image:
            "https://images.unsplash.com/photo-1567515004624-219c11d31f2e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMDUzMDJ8MHwxfHNlYXJjaHw1MXx8bWFufGVufDF8fHx8MTY2Njc4NzAwOA&ixlib=rb-4.0.3&q=80&w=1080",
        time: "24 Feb"),
    ChatUsers(
        text: "John Wick",
        secondaryText: "How are you?",
        image:
            "https://images.unsplash.com/photo-1567515004624-219c11d31f2e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMDUzMDJ8MHwxfHNlYXJjaHw1MXx8bWFufGVufDF8fHx8MTY2Njc4NzAwOA&ixlib=rb-4.0.3&q=80&w=1080",
        time: "18 Feb"),
    // Add more ChatUsers with alternate image URLs here...
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Color(0xFF161616), // Set background color to #161616
        child: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.only(left: 16, right: 16, top: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "Chats",
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.white, // Text color
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(
                            left: 8, right: 8, top: 2, bottom: 2),
                        height: 30,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Color(0xFF323232),
                        ),
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.add,
                              color: Colors.white,
                              size: 20,
                            ),
                            SizedBox(
                              width: 2,
                            ),
                            Text(
                              "Add New",
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 16, left: 16, right: 16),
                child: TextField(
                  decoration: InputDecoration(
                    hintText: "Search...",
                    hintStyle: TextStyle(color: Colors.white),
                    prefixIcon: Icon(
                      Icons.search,
                      color: Colors.white,
                      size: 20,
                    ),
                    filled: true,
                    fillColor: Color(0xFF323232),
                    contentPadding: EdgeInsets.all(8),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(color: Color(0xFF323232)),
                    ),
                  ),
                ),
              ),
              ListView.builder(
                itemCount: chatUsers.length,
                shrinkWrap: true,
                padding: EdgeInsets.only(top: 16),
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  return ConversationList(
                    name: chatUsers[index].text,
                    messageText: chatUsers[index].secondaryText,
                    imageUrl: index.isEven
                        ? "https://images.unsplash.com/photo-1596305589440-2e180399a760?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMDUzMDJ8MHwxfHNlYXJjaHwxMjJ8fGJsYWNrJTIwd29tYW58ZW58MXx8fHwxNjY2ODY1MDg3&ixlib=rb-4.0.3&q=80&w=1080"
                        : "https://images.unsplash.com/photo-1607990281513-2c110a25bd8c?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyMDUzMDJ8MHwxfHNlYXJjaHwyNXx8bWFufGVufDF8fHx8MTY2NjYzNjY1Nw&ixlib=rb-4.0.3&q=80&w=1080",
                    time: chatUsers[index].time,
                    isMessageRead: (index == 0 || index == 3) ? true : false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
