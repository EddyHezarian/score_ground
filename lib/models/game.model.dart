import 'dart:math';

import 'package:ai_pr5/models/player.model.dart';

class GameModel {
  final List<double> scores;
  final double depth;
  bool isPlayerTurn;
  final PlayerModel ai;
  final PlayerModel player;
  GameModel(
      {required this.ai,
      required this.player,
      this.depth = 3,
      required this.isPlayerTurn,
      required this.scores});

  List<GameModel> getChildren() {
    List<GameModel> children = [];
    PlayerModel currentPlayer = isPlayerTurn ? player : ai;

    List<double> possibleMoves = [
      currentPlayer.location - 1,
      currentPlayer.location + 1,
      currentPlayer.location + 4,
      currentPlayer.location - 4,
      
    ];

    for (double move in possibleMoves) {
      if (currentPlayer.canMoveTo(move , isPlayerTurn ? ai.location : player.location)) {
        PlayerModel newPlayer = PlayerModel(
          name: player.name,
          score: isPlayerTurn ? player.score + scores[move.toInt()] : player.score,
          location: isPlayerTurn ? move : player.location,
        );

        PlayerModel newAi = PlayerModel(
          name: ai.name,
          score: isPlayerTurn ? player.score : player.score + scores[move.toInt()],
          location: isPlayerTurn ? ai.location : move,
        );
        List<double> newScores = List.from(scores);
        newScores[move.toInt()] = 0;
        children.add(GameModel(
          ai: newAi,
          player: newPlayer,
          depth: depth,
          isPlayerTurn: !isPlayerTurn,
          scores: newScores,
        ));
      }
    }

    return children;
  }

  bool isTerminal() {
    if (scores.reduce((value, element) => value + element) == 0) {
      return true;
    }
    return false;
  }

  void  movePlayer(double index) {
    if (isPlayerTurn) {
      if (player.canMoveTo(index,ai.location)) {
        player.location = index;
        player.score += scores[index.toInt()];
        scores[index.toInt()] = 0;
        isPlayerTurn = false;
        moveAI();
      }
    }
  }

  void moveAI() {
    double index = calculateBestMove();
    if (ai.canMoveTo(index,player.location)) {
      ai.location = index;
      ai.score += scores[index.toInt()];
      scores[index.toInt()] = 0;
      isPlayerTurn = true;
    }
  }


  double countPossibleActions(PlayerModel player) {
    double count = 0;
    List<double> possibleMoves = [
      player.location - 4,
      player.location + 4,
      player.location - 1,
      player.location + 1
    ];
    for (double move in possibleMoves) {
      if (player.canMoveTo(move , isPlayerTurn ? ai.location : player.location)) {
        count++;
      }
    }
    return count;
  }
  
  double minMaxWithAlphaBetaPruning(
      GameModel state, bool isMaximizing, double alpha, double beta, double depthLimit) {
    //!
    if (state.isTerminal()) {
      return state.ai.score - state.player.score ;
    }
    if (depthLimit < 0) {
      double huristic = 0;
      double playerMoves = countPossibleActions(state.player);
      double aiMoves = countPossibleActions(state.ai);
      huristic += (aiMoves - playerMoves) * 0.5;
      return ( state.ai.score - state.player.score )+  huristic ;
    }
    if (isMaximizing) {
      double value = -1000000;
      for (GameModel child in state.getChildren()) {
        double eval = minMaxWithAlphaBetaPruning(
            child, false, alpha, beta, depthLimit - 1);
        value = max(value, eval);
        if (value >= beta)return value;
        alpha = max(alpha, value);
        
      }
      return value;
    } else {
      double value = 1000000;
      for (GameModel child in state.getChildren()) {
        double eval = minMaxWithAlphaBetaPruning(
            child, true, alpha, beta, depthLimit - 1);
        value = min(value, eval);
        if (value <= alpha)return value;
        beta = min(beta, eval);
       
      }
      return value;
    }
  }


  double calculateBestMove() {
    double bestMove = -1;
    double bestEval = -1000000;
    for (GameModel child in getChildren()) {
      double eval =
          minMaxWithAlphaBetaPruning(child, false, -1000000, 1000000, depth);
      if (eval > bestEval) {
        bestEval = eval;
        bestMove = child.ai.location;
      }
    }
    return bestMove;
  }
}
