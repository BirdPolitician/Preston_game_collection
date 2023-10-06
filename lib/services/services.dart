import 'package:http/http.dart' as http;
import 'package:preston_game_collection/models/game_model.dart';

class RemoteService {
  Future<List<Game>?> getGames(String title) async {
    var client = http.Client();
    var uri = Uri.parse(
        'https://api.mobygames.com/v1/games?api_key=moby_OKWMHJ793MQoFP6K0w8VBL4b0cT&title=$title&format=normal');
    var response = await client.get(uri);
    if (response.statusCode == 200) {
      var json = response.body;
      return gamesFromJson(json);
    } else {
      return null;
    }
  }
}
