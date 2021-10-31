import 'dart:convert';
import 'package:web_socket_channel/io.dart';

void main(List<String> arguments) {
  final channel = IOWebSocketChannel.connect(
      'wss://ws.binaryws.com/websockets/v3?app_id=1089');

  channel.stream.listen((message) {

    final decodedMessage = jsonDecode(message);
    final name = decodedMessage['tick']['symbol'];
    final price = decodedMessage['tick']['quote'];
    final epochTime = decodedMessage['tick']['epoch'];

    final time = DateTime.fromMillisecondsSinceEpoch(epochTime * 1000);

    print('Name: $name, Price: $price, Date: $time');
  });

  channel.sink.add('{"ticks": "R_100","subscribe": 1}');
}
