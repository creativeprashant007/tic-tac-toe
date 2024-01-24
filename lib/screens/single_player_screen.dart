import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe/components/single_board.dart';

class TicTacToeSinglePlayer extends StatefulWidget {
  @override
  _TicTacToeSinglePlayerState createState() => _TicTacToeSinglePlayerState();
}

class _TicTacToeSinglePlayerState extends State<TicTacToeSinglePlayer> {
  List<List<String>> board = List.generate(3, (_) => List.filled(3, ''));
  String currentPlayer = 'X';
  bool gameEnded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Single Player'),
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Player $currentPlayer\'s turn',
                  style: const TextStyle(
                    fontFamily: 'Quicksand',
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20),
                SingleBoardWidget(
                  board: board,
                  onMove: (i, j) {
                    if (!gameEnded && board[i][j] == '') {
                      setState(() {
                        board[i][j] = currentPlayer;
                        checkWinner(i, j);

                        // Switch player after X makes a move
                        currentPlayer = (currentPlayer == 'X') ? 'O' : 'X';

                        // Check for winner or tie before AI move
                        if (!gameEnded && currentPlayer == 'O') {
                          // Schedule AI move with a delay
                          Timer(Duration(milliseconds: 500), () {
                            _aiMove();
                          });
                        }
                      });
                    }
                  },
                ),
                const SizedBox(height: 20),
              ],
            ),
          ),
          if (gameEnded)
            Center(
                // ... existing code for game over display
                ),
        ],
      ),
    );
  }

  void _aiMove() {
    // Simple AI: Choose a random available spot
    List<int> availableMoves = [];
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        if (board[i][j] == '') {
          availableMoves.add(i * 3 + j); // Convert 2D index to 1D index
        }
      }
    }

    if (availableMoves.isNotEmpty) {
      int randomIndex = Random().nextInt(availableMoves.length);
      int flatIndex = availableMoves[randomIndex];

      // Convert 1D index back to 2D index
      int row = flatIndex ~/ 3;
      int col = flatIndex % 3;

      // AI ('O') makes a move
      setState(() {
        board[row][col] = 'O';
      });

      // Check for a winner or tie after AI move
      checkWinner(row, col);
      currentPlayer = 'X';
      setState(() {});
    }
  }

  void checkWinner(int row, int col) {
    // Check for a winner
    if (_checkRow(row) || _checkColumn(col) || _checkDiagonals()) {
      gameEnded = true;
      _showWinnerDialog(currentPlayer);
      return;
    }

    // Check for a tie
    if (_isBoardFull()) {
      gameEnded = true;
      _showTieDialog();
      return;
    }
  }

  bool _checkRow(int row) {
    return board[row][0] == currentPlayer &&
        board[row][1] == currentPlayer &&
        board[row][2] == currentPlayer;
  }

  bool _checkColumn(int col) {
    return board[0][col] == currentPlayer &&
        board[1][col] == currentPlayer &&
        board[2][col] == currentPlayer;
  }

  bool _checkDiagonals() {
    return (board[0][0] == currentPlayer &&
            board[1][1] == currentPlayer &&
            board[2][2] == currentPlayer) ||
        (board[0][2] == currentPlayer &&
            board[1][1] == currentPlayer &&
            board[2][0] == currentPlayer);
  }

  bool _isBoardFull() {
    for (int i = 0; i < board.length; i++) {
      for (int j = 0; j < board[i].length; j++) {
        if (board[i][j] == '') {
          return false; // Found an empty spot, board is not full
        }
      }
    }
    return true; // No empty spots, board is full
  }

  void _showWinnerDialog(String winner) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Player $winner Wins!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                restartGame();
              },
              child: Text('Restart Game'),
            ),
          ],
        );
      },
    );
  }

  void _showTieDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Game Tied!'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                restartGame();
              },
              child: Text('Restart Game'),
            ),
          ],
        );
      },
    );
  }

  void restartGame() {
    setState(() {
      board = List.generate(3, (_) => List.filled(3, ''));
      gameEnded = false;
      currentPlayer = 'X';
    });
  }
}
