import 'dart:async';
import 'dart:convert';
import 'dart:io' as io;

//import 'package:web_socket_channel/status.dart' as status;
import 'package:http/http.dart' as http;
import 'package:scoped_model/scoped_model.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/io.dart';
import '../models/user_model.dart';
import '../models/message_model.dart';

enum LiveQueryClientEvent { CONNECTED, DISCONNECTED, USER_DISCONNECTED }

mixin ChatModel on Model {
  User? _authenticatedUser;
  List<Message> messageList = [];
  //User? _selectedUser;

  User? get user {
    return _authenticatedUser;
  }

  void sendTextMessage(String text) async {
    print("${_authenticatedUser!.id}");
    print(text);
    // _channel.sink.add(text);

    Map<String, dynamic> newMessage = {
      'content': text,
      'from': {
        "__type": "Pointer",
        "className": "_User",
        "objectId": "${_authenticatedUser!.id}"
      }
    };
    try {
      final http.Response response = await http.post(
          Uri.parse("https://youchat.b4a.io/classes/Messages"),
          body: json.encode(newMessage),
          headers: {
            'X-Parse-Application-Id':
                '01NqPdNC940HFYzGLL9RnCQXBMHUy3jc72o7qnDa',
            'X-Parse-REST-API-Key': 'TNuCyG62jxNrcaPVPUFp2B6ZmRFd9Ai3SgEzrYm1',
            'Content-Type': 'application/json',
          });

      Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData);
      messageList.add(Message(
          text: text,
          isSender: true,
          messageStatus: MessageStatus.NotViewed,
          messageType: MessageType.Text));
      notifyListeners();
    } catch (error) {
      print("Something went wrong: post not working");
    }
  }

  void fetchMessages() async {
    Map<String, dynamic> queryParameter = {
      'count': '1',
    };
    Uri queryUri = Uri.https(
      "youchat.b4a.io",
      "/classes/Messages",
      queryParameter,
    );
    try {
      final http.Response response = await http.get(queryUri, headers: {
        'X-Parse-Application-Id': '01NqPdNC940HFYzGLL9RnCQXBMHUy3jc72o7qnDa',
        'X-Parse-REST-API-Key': 'TNuCyG62jxNrcaPVPUFp2B6ZmRFd9Ai3SgEzrYm1',
      });

      Map<String, dynamic> responseData = json.decode(response.body);
      print(responseData['count']);

      List resultsList = responseData['results'];
      final List<Message> fetchedMessageList = [];

      for (int i = 0; i < resultsList.length; i++) {
        Map<String, dynamic> messageData = resultsList[i];
        String date = messageData['createdAt'];
        String timeStamp = date.substring(0, 10);

        final Message newMessage = Message(
          messageType: MessageType.Text,
          text: messageData['content'],
          messageStatus: MessageStatus.NotViewed,
          isSender: messageData['from']['objectId'] == _authenticatedUser!.id
              ? true
              : false,
          createdAt: timeStamp,
        );

        fetchedMessageList.add(newMessage);
      }

      messageList = fetchedMessageList;
      notifyListeners();
    } catch (error) {
      print("Something went wrong:  fetch not working");
    }
  }
}

mixin UserModel on ChatModel {
  Future<Map<String, dynamic>> authenticate(String username, String password,
      {bool newUser = false}) async {
    print(newUser);
    Map<String, dynamic> authData = {
      "username": username,
      "password": password
    };

    Uri loginUri = Uri.https('youchat.b4a.io', '/login', authData);

    http.Response response;

    if (newUser == true) {
      response = await http.post(
        Uri.parse("https://youchat.b4a.io/users"),
        body: json.encode(authData),
        headers: {
          'X-Parse-Application-Id': '01NqPdNC940HFYzGLL9RnCQXBMHUy3jc72o7qnDa',
          'X-Parse-REST-API-Key': 'TNuCyG62jxNrcaPVPUFp2B6ZmRFd9Ai3SgEzrYm1',
          'X-Parse-Revocable-Session': '1',
          'Content-Type': 'application/json',
        },
      );
    } else {
      response = await http.post(loginUri, headers: {
        'X-Parse-Application-Id': '01NqPdNC940HFYzGLL9RnCQXBMHUy3jc72o7qnDa',
        'X-Parse-REST-API-Key': 'TNuCyG62jxNrcaPVPUFp2B6ZmRFd9Ai3SgEzrYm1',
        'X-Parse-Revocable-Session': '1',
      });
    }

    final Map<String, dynamic> responseData = json.decode(response.body);
    print(responseData);

    bool hasError = true;
    String message = 'something went wrong';

    if (responseData.containsKey('sessionToken') == true) {
      hasError = false;
      message = 'Authentication succeded';

      _authenticatedUser = User(
          id: responseData['objectId'],
          userName: username,
          phoneNumber: "123456789");
    } else if (responseData['error'] == 'Invalid username/password.') {
      hasError = true;
      message = 'Invalid username/password';
    } else if (responseData['error'] ==
        'Account already exists for this username.') {
      hasError = true;
      message = 'This username already exists';
    }
    notifyListeners();
    return {'success': !hasError, 'message': message};
  }
}

class WebSocket {
  WebSocket._(this._webSocket);

  static const int CONNECTING = 0;
  static const int OPEN = 1;
  static const int CLOSING = 2;
  static const int CLOSED = 3;

  final io.WebSocket _webSocket;

  static Future<WebSocket> connect(String liveQueryURL) async {
    return WebSocket._(await io.WebSocket.connect(liveQueryURL));
  }

  int get readyState => _webSocket.readyState;

  Future close() {
    return _webSocket.close();
  }

  WebSocketChannel createWebSocketChannel() {
    return IOWebSocketChannel(_webSocket);
  }
}

mixin WebSocketModel on ChatModel {
  String _liveQueryUrl = "wss://youchat.b4a.io/Messages";
  //String _liveQueryUrl = "wss://echo.websocket.org";
  bool _debug = true;
  WebSocketChannel? _channel;
  WebSocket? _webSocket;

  // ignore: close_sinks
  StreamController _clientEventStreamController =
      StreamController<LiveQueryClientEvent>();
  Stream<LiveQueryClientEvent> clientEventStream() async* {
    _clientEventStreamController.stream.asBroadcastStream();
  }

  // StreamController? _clientEventStreamController;

// Stream<LiveQueryClientEvent> get getClientEventStream {
//     return _clientEventStream;
//   }
  //final Map<int, StreamSubscription> _requestSubScription = {};
  bool _connecting = false;

  Map<String, Function> eventCallbacks = <String, Function>{};

  void _handleMessage(String message) {
    if (_debug) {
      print('LiveQuery: Listen: $message');
    }

    // final Map<String, dynamic> actionData = json.decode(message);

    // StreamSubscription? subscription;
    // if(actionData.containsKey('op') && actionData['op'] == 'connected'){
    //   print('ReSubscription: $_requestSubScription');

    //   _requestSubScription.values.toList().forEach((StreamSubscription _subscription) {
    //     _subscribeLiveQuery(_subscription);
    //    });
    //    _clientEventStreamController!.sink
    //       .add(LiveQueryClientEvent.CONNECTED);
    //       return;
    // }
    // if(actionData.containsKey('requestId')){
    //   subscription = _requestSubScription[actionData['requestId']];

    // }if (subscription == null){
    //   return;
    // }
    print("message is $message and we should do something with it");
  }

  int readyState() {
    if (_webSocket != null) {
      return _webSocket!.readyState;
    }
    return WebSocket.CONNECTING;
  }

  Future<dynamic> disconnect({bool userInitialized = false}) async {
    // if (_webSocket != null && _webSocket!.readyState == WebSocket.OPEN) {
    //   if (_debug) {
    //     print('LiveQuery: Socket closed');
    //   }
    //   await _webSocket!.close();
    //   _webSocket = null;
    // }
    // // ignore: unnecessary_null_comparison
    if (_channel != null) {
      if (_debug) {
        print('LiveQuery: close');
      }
      await _channel!.sink.close();
      _channel = null;
    }
    // _requestSubScription.values
    //     .toList()
    //     .forEach((StreamSubscription subscription) {
    //   subscription.cancel();
    // });
    _connecting = false;
    if (userInitialized)
      _clientEventStreamController.sink
          .add(LiveQueryClientEvent.USER_DISCONNECTED);
    _clientEventStreamController.close();
  }

  Future<dynamic> connect() async {
    if (_connecting) {
      print("already connecting...");
      return Future<void>.value(null);
    }
    await disconnect(userInitialized: true);
    _connecting = true;

    try {
      // _webSocket = await WebSocket.connect(_liveQueryUrl);
      _channel = WebSocketChannel.connect(Uri.parse(_liveQueryUrl));
      _connecting = false;
      if (_channel != null) {
        if (_debug) {
          print("LiveQuery: Socket opened");
        }
      } else {
        if (_debug) {
          print("LiveQuery: Error when connecting client");
        }
        return Future<void>.value(null);
      }
      // _channel = _webSocket!.createWebSocketChannel();
      _channel!.stream.listen((dynamic message) {
        print("listening is working");
        _handleMessage(message);
      }, onDone: () {
        _clientEventStreamController.sink
            .add(LiveQueryClientEvent.DISCONNECTED);
        if (_debug) {
          print('LiveQuery: Done');
        }
      }, onError: (Object error) {
        _clientEventStreamController.sink
            .add(LiveQueryClientEvent.DISCONNECTED);
        if (_debug) {
          print('LiveQuery: Error: ${error.runtimeType.toString()}');
        }
      });
    } on Exception catch (err) {
      _connecting = false;
      _clientEventStreamController.sink.add(LiveQueryClientEvent.DISCONNECTED);
      if (_debug) {
        print('LiveQuery: Error: ${err.toString()}');
      }
    }
  }

  void subscribeLiveQuery(String subscribeMessage) {
    if (_debug) {
      print('LiveQuery: SubscribeMessage: $subscribeMessage');
    }
    _channel!.sink.add(subscribeMessage);
  }
}
