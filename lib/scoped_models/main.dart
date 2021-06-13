import 'package:scoped_model/scoped_model.dart';
import './connector.dart';

class MainModel extends Model with ChatModel, UserModel, WebSocketModel {}

final MainModel mainModel = MainModel();
