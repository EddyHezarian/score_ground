class PlayerModel {
  String name;
  double score;
  double location;
  PlayerModel(
      {required this.name, required this.score, required this.location});

  bool canMoveTo(double index, double playerLocation) {
    if (index < 0 || index > 15) {
      return false;
    }
    if (index == playerLocation) return false;
    double currentRow = (location ~/ 4).toDouble();
    double currentCol = location % 4;
    double targetRow = (index ~/ 4).toDouble();
    double targetCol = index % 4;
    
    // Check if the move is within one step in any direction
    if ((currentRow == targetRow && (currentCol - targetCol).abs() == 1) ||
        (currentCol == targetCol && (currentRow - targetRow).abs() == 1)) {
      return true;
    }
    return false;
  }

  void moveTo(index, rival) {
    if (canMoveTo(index,rival )) {
      location = index;
    } else {
      location;
    }
  }
}
