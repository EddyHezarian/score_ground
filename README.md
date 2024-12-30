# AI Player Movement in a 4x4 Grid Game

## Problem
In this project, we aim to create a simple game where two players (a human player and an AI) move on a 4x4 grid. The challenge is to ensure that the players can only move to adjacent cells (up, down, left, right) and not diagonally or to non-adjacent cells. Additionally, the game should update the UI to reflect the players' movements in real-time.

## Solution
To solve this problem, we have implemented the following features:
1. **Player Movement**: Both the human player and the AI can move to adjacent cells on the grid. The movement is validated to ensure it is within the allowed range.
2. **Game State Management**: We use the GetX package for state management to ensure that the UI updates in real-time as the players move.
3. **UI Representation**: The grid is represented using a `GridView` in Flutter, and each cell is an `InkWell` widget that detects taps and triggers player movement.
4. **Game Logic**: The game logic is encapsulated in the `Controller` and `GameModel` classes, which handle the movement validation and state updates.
5. **AI Decision Making**: The AI uses the Minimax algorithm with Alpha-Beta Pruning to make optimal moves.

## Minimax Algorithm and Adversarial Search
The Minimax algorithm is used for decision-making in adversarial games. It simulates all possible moves in the game and chooses the move that maximizes the player's minimum gain (hence "minimax"). The algorithm assumes that the opponent is also playing optimally.

### Alpha-Beta Pruning
Alpha-Beta Pruning is an optimization technique for the Minimax algorithm. It reduces the number of nodes evaluated in the search tree by eliminating branches that cannot possibly influence the final decision. This makes the algorithm more efficient without affecting the outcome.

### How It Works
1. **Minimax Algorithm**: The AI evaluates all possible moves and their outcomes, assuming that the opponent will also play optimally. It chooses the move that maximizes its minimum gain.
2. **Alpha-Beta Pruning**: During the search, the algorithm keeps track of two values, alpha and beta, which represent the minimum score that the maximizing player is assured of and the maximum score that the minimizing player is assured of, respectively. If at any point the algorithm finds a move that is worse than a previously examined move, it prunes that branch and does not evaluate it further.

## Installation
To run this project locally, follow these steps:

1. **Clone the Repository**:
    ```sh
    git clone https://github.com/yourusername/ai_pr5.git
    cd ai_pr5
    ```

2. **Install Dependencies**:
    Ensure you have Flutter installed on your machine. Then, run the following command to install the required dependencies:
    ```sh
    flutter pub get
    ```

3. **Run the Application**:
    Use the following command to run the application on your preferred device (emulator or physical device):
    ```sh
    flutter run
    ```

## Usage
- Tap on any cell to move the player to that cell, if the move is valid.
- The AI will automatically move after the player, following the same movement rules.
- The scores of both players are displayed at the top of the screen.
- Use the "Reset" button to reset the game to its initial state.

## Dependencies
- **Flutter**: The framework used to build the application.
- **GetX**: A state management package for Flutter.

## Contributing
If you would like to contribute to this project, please fork the repository and submit a pull request with your changes.

## License
This project is licensed under the MIT License. See the LICENSE file for more details.