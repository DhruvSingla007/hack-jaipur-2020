import 'package:hackjaipur2020/models/user_model.dart';

class Message {
  final UserModel sender;
  final String time;
  final String text;
  final bool isLiked;
  final bool unread;
  final String tag;

  Message({
    this.sender,
    this.time,
    this.text,
    this.isLiked,
    this.unread,
    this.tag,
  });
}

// YOU - current user
final UserModel currentUser = UserModel(
  id: 0,
  name: 'Current User',
  imageUrl: 'assets/images/greg.jpg',
);

// USERS
final UserModel greg = UserModel(
  id: 1,
  name: 'Greg',
  imageUrl: 'assets/images/greg.jpg',
);
final UserModel james = UserModel(
  id: 2,
  name: 'James',
  imageUrl: 'assets/images/greg.jpg',
);
final UserModel john = UserModel(
  id: 3,
  name: 'John',
  imageUrl: 'assets/images/greg.jpg',
);
final UserModel olivia = UserModel(
  id: 4,
  name: 'Olivia',
  imageUrl: 'assets/images/greg.jpg',
);
final UserModel sam = UserModel(
  id: 5,
  name: 'Sam',
  imageUrl: 'assets/images/greg.jpg',
);
final UserModel sophia = UserModel(
  id: 6,
  name: 'Sophia',
  imageUrl: 'assets/images/greg.jpg',
);
final UserModel steven = UserModel(
  id: 7,
  name: 'Steven',
  imageUrl: 'assets/images/greg.jpg',
);

// FAVORITE CONTACTS

// EXAMPLE CHATS ON HOME SCREEN
List<Message> chats = [
  Message(
    sender: james,
    tag: 'tag1',
    time: '5:30 PM',
    text: 'Javascript need to find out new class name after add new',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: olivia,
    time: '4:30 PM',
    tag: 'tag2',
    text: 'Javascript need to find out new class name after add new',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: john,
    tag: 'tag3',
    time: '3:30 PM',
    text: 'Javascript need to find out new class name after add new',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: sophia,
    tag: 'tag4',
    time: '2:30 PM',
    text: 'Javascript need to find out new class name after add new',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: steven,
    tag: 'tag5',
    time: '1:30 PM',
    text: 'Javascript need to find out new class name after add new',
    isLiked: false,
    unread: false,
  ),
];

// EXAMPLE MESSAGES IN CHAT SCREEN
List<Message> messages = [
  Message(
    sender: currentUser,
    time: '5:30 PM',
    text: 'Javascript need to find out new class name after add new',
    isLiked: true,
    unread: false,
  ),
  Message(
    sender: currentUser,
    time: '4:30 PM',
    text: 'Javascript need to find out new class name after add new',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '3:45 PM',
    text: 'Javascript need to find out new class name after add new',
    isLiked: false,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '3:15 PM',
    text: 'Javascript need to find out new class name after add new',
    isLiked: true,
    unread: true,
  ),
  Message(
    sender: currentUser,
    time: '2:30 PM',
    text: 'Javascript need to find out new class name after add new',
    isLiked: false,
    unread: false,
  ),
  Message(
    sender: james,
    time: '2:00 PM',
    text: 'Javascript need to find out new class name after add new',
    isLiked: true,
    unread: false,
  ),
];