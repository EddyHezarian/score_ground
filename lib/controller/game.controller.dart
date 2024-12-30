import 'package:ai_pr5/models/game.model.dart';
import 'package:ai_pr5/models/player.model.dart';
import 'package:get/state_manager.dart';

class Controller extends GetxController {

  Rx<GameModel> game = GameModel(
          scores: [0, 1, 5, 3, 4, 2, 1, 2, 1, 3, 2, 5, 5, 2, 1, 0],
          depth: 14,
          isPlayerTurn: true,
          ai: PlayerModel(name: "AI", location: 15, score: 0),
          player: PlayerModel(name: "Player", location: 0, score: 0))
      .obs;

  void movePlayer(int index) {
    game.update((game) {
      game!.movePlayer(index.toDouble());
    });
  }

  void restGame() {
    game.update((val) {
      game.value = GameModel(
          scores: [0, 1, 5, 3, 4, 2, 1, 2, 1, 3, 2, 5, 5, 2, 1, 0],
          depth: 14,
          isPlayerTurn: true,
          ai: PlayerModel(name: "AI", location: 15, score: 0),
          player: PlayerModel(name: "Player", location: 0, score: 0));
    });
  }


}
