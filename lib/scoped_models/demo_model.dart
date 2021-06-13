import '../models/user_model.dart';
import '../models/message_model.dart';
import '../models/chat_tile_model.dart';
import '../models/experiences_list_model.dart';

List chatTileList = [];
List userList = [];
List messageList = [];
List experiences = [];

List demoUserList = [
  User(
    id: "kjsndcnsd ",
    userName: "Kevin",
    password: "mySuperSecurePassword",
    phoneNumber: "+12345678912",
    userImage: "assets/images/Kevin.png",
  ),
  User(
    id: "kjsndcnsd ",
    userName: "Tracy",
    password: "mySuperSecurePassword",
    phoneNumber: "+12345678912",
    userImage: "assets/images/Tracy.png",
  ),
  User(
    id: "kjsndcnsd ",
    userName: "Greg",
    password: "mySuperSecurePassword",
    phoneNumber: "+12345678912",
    userImage: "assets/images/greg.jpg",
  ),
  User(
    id: "kjsndcnsd ",
    userName: "Olivia",
    password: "mySuperSecurePassword",
    phoneNumber: "+12345678912",
    userImage: "assets/images/olivia.jpg",
  ),
  User(
    id: "kjsndcnsd ",
    userName: "Sophia",
    password: "mySuperSecurePassword",
    phoneNumber: "+12345678912",
    userImage: "assets/images/sophia.jpg",
  ),
  User(
    id: "kjsndcnsd ",
    userName: "Mark",
    password: "mySuperSecurePassword",
    phoneNumber: "+12345678912",
    userImage: "assets/images/Mark.png",
  ),
  User(
    id: "kjsndcnsd ",
    userName: "Arwin",
    password: "mySuperSecurePassword",
    phoneNumber: "+12345678912",
    userImage: "assets/images/Arwin.png",
  ),
];

List demoExperiencesList = [
  Experiences(
    name: demoUserList[2].userName,
    imagePosted: demoUserList[2].userImage,
  ),
  Experiences(
    name: demoUserList[0].userName,
    imagePosted: demoUserList[0].userImage,
  ),
  Experiences(
    name: demoUserList[5].userName,
    imagePosted: demoUserList[5].userImage,
  ),
  Experiences(
    name: demoUserList[1].userName,
    imagePosted: demoUserList[1].userImage,
  ),
  Experiences(
    name: demoUserList[3].userName,
    imagePosted: demoUserList[3].userImage,
  ),
];

List<Message> demoMessageList = [
  Message(
    text: "Hi Tracy,",
    messageType: MessageType.Text,
    messageStatus: MessageStatus.Viewed,
    isSender: false,
  ),
  Message(
    text: "Hello, How are you?",
    messageType: MessageType.Text,
    messageStatus: MessageStatus.Viewed,
    isSender: true,
  ),
  Message(
    text: "",
    messageType: MessageType.Audio,
    messageStatus: MessageStatus.Viewed,
    isSender: false,
  ),
  Message(
    text: "",
    messageType: MessageType.Video,
    messageStatus: MessageStatus.Viewed,
    isSender: true,
  ),
  Message(
    text: "Error happend",
    messageType: MessageType.Text,
    messageStatus: MessageStatus.NotSent,
    isSender: true,
  ),
  Message(
    text: "This looks great man!!",
    messageType: MessageType.Text,
    messageStatus: MessageStatus.Viewed,
    isSender: false,
  ),
  Message(
    text: "Glad you like it",
    messageType: MessageType.Text,
    messageStatus: MessageStatus.NotViewed,
    isSender: true,
  ),
];

List demoChatTileList = [
  ChatTile(
    name: demoUserList[0].userName,
    lastMessage: "Do you have update on the manuever situation yet?",
    image: demoUserList[0].userImage,
    time: "8m ago",
    isActive: true,
  ),
  ChatTile(
    name: demoUserList[1].userName,
    lastMessage: "Hope you are doing well...",
    image: demoUserList[1].userImage,
    time: "3m ago",
    isActive: false,
  ),
  ChatTile(
    name: demoUserList[2].userName,
    lastMessage: "Hello Abdullah! I am...",
    image: demoUserList[2].userImage,
    time: "8m ago",
    isActive: true,
  ),
  ChatTile(
    name: demoUserList[3].userName,
    lastMessage: "Do you have update...",
    image: demoUserList[3].userImage,
    time: "5d ago",
    isActive: false,
  ),
  ChatTile(
    name: demoUserList[4].userName,
    lastMessage: "You’re welcome :)",
    image: demoUserList[4].userImage,
    time: "5d ago",
    isActive: true,
  ),
  ChatTile(
    name: demoUserList[5].userName,
    lastMessage: "Thanks",
    image: demoUserList[5].userImage,
    time: "6d ago",
    isActive: false,
  ),
  ChatTile(
    name: demoUserList[6].userName,
    lastMessage: "Hope you are doing well...",
    image: demoUserList[6].userImage,
    time: "3m ago",
    isActive: false,
  ),

  // ChatTile(
  //   name: demoUserList[1].userName,
  //   lastMessage: "Do you have update...",
  //   image: "assets/images/user_3.png",
  //   time: "5d ago",
  //   isActive: false,
  // ),
];

