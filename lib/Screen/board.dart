import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:tetris_game/Constant/values.dart';
import 'package:tetris_game/Widget/pixel.dart';
import 'package:tetris_game/help/piece.dart';

/*
  GAME BOARD
  This is a 2x2 grid with null representing an empty space.
  A non empty space will have the color to represent the landed pieces
*/
List<List<Tetromino?>> gameBoard = List.generate(
    collLength,
    (i) => List.generate(
          rowLength,
          (j) => null,
        ));

class GameBoard extends StatefulWidget {
  const GameBoard({Key? key}) : super(key: key);

  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  // current tetris piece
  Piece currentPiece = Piece(type: Tetromino.L);

  // currentScore
  int currentScore = 0;

  // game over state
  bool gameOver = false;

  // game reset state
  bool gameReset = false;

  bool gameOverReset = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    // start game when app starts
    startGame();
  }

  // start game
  void startGame() {
    // initialize Piece in object
    currentPiece.initializePiece();

    // frame refresh rate
    Duration frameRate = const Duration(milliseconds: 500);
    gameLoop(frameRate);
  }

  // game Loop
  void gameLoop(Duration frameRate) {
    Timer.periodic(frameRate, (timer) {
      setState(() {
        // clear Lines
        clearLines();

        // check landing
        checkLanding();

        // check if game is over
        if (gameOver) {
          timer.cancel(); // Stop timer Loop
          showGameOverDialog();
        }

        // check if game is over
        if (gameReset) {
          if (!gameOverReset) {
            timer.cancel(); // Stop timer Loop
          }
          gameReset = false;
        }

        // move current piece down
        currentPiece.movePiece(Direction.down);
      });
    });
  }

  // game over message
  void showGameOverDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Game Over"),
        content: Text("Your score is: $currentScore"),
        actions: [
          TextButton(
            onPressed: () {
              // reset the game
              resetGame();
              Navigator.pop(context);
            },
            child: Text("Play Again"),
          ),
        ],
      ),
    );
  }

  //reset game
  void resetGame() {
    // clear the game boar
    gameBoard = List.generate(
        collLength,
        (i) => List.generate(
              rowLength,
              (j) => null,
            ));

    // new game
    gameOver = false;
    currentScore = 0;

    // create new Piece
    createNewPiece();

    // start game
    startGame();
  }

  //reset game in Reset button
  void resetGameButton() {
    // game Reset
    gameReset = true;
    gameOverReset = gameOver;
    // Reset
    resetGame();
  }

  // check for collision in a future position
  // return true -> there ib a collision
  // return false -> there is no collision
  bool checkCollision(Direction direction) {
    // loop through each position of the current piece
    for (int i = 0; i < currentPiece.position.length; i++) {
      int row = (currentPiece.position[i] / rowLength).floor();
      int col = currentPiece.position[i] % rowLength;

      // adjust the row and col bassed on the direction
      if (direction == Direction.left) {
        col -= 1;
      } else if (direction == Direction.right) {
        col += 1;
      } else if (direction == Direction.down) {
        row += 1;
      }

      // check if the piece is out of bounds (either too low or too for to the left or right)
      if (row >= collLength || col < 0 || col >= rowLength) {
        return true;
      }
      if (row >= 0 && col >= 0) {
        if (gameBoard[row][col] != null) {
          return true;
        }
      }
    }
    // if no collisions are detected , return false
    return false;
  }

  void checkLanding() {
    // if going down is accupired
    if (checkCollision(Direction.down)) {
      // mark position as accuied on the gameboard
      for (int i = 0; i < currentPiece.position.length; i++) {
        int row = (currentPiece.position[i] / rowLength).floor();
        int col = currentPiece.position[i] % rowLength;
        if (row >= 0 && col >= 0) {
          gameBoard[row][col] = currentPiece.type;
        }
      }
      // once landed , create the next piece
      createNewPiece();
    }
  }

  void createNewPiece() {
    // create a random object to generate random
    Random random = Random();

    Tetromino randomType =
        Tetromino.values[random.nextInt(Tetromino.values.length)];

    currentPiece = Piece(type: randomType);
    currentPiece.initializePiece();

    /*
        Since our game over condition is if there is a piece at the top level,
        you want to check if the game is over when you create a new piece
        instead of checking every frame, because new pieces are allowed to go through
         the top level but if there is already a piece in the top level when the new
         piece is created , then game is over
    */
    if (isGameOver()) {
      gameOver = true;
    }
  }

  // move left
  void moveLeft() {
    // make sure the move is valid befor moving there
    if (!checkCollision(Direction.left)) {
      setState(() {
        currentPiece.movePiece(Direction.left);
      });
    }
  }

  // move right
  void moveRight() {
    // make sure the move is valid befor moving there
    if (!checkCollision(Direction.right)) {
      setState(() {
        currentPiece.movePiece(Direction.right);
      });
    }
  }

  // move rotat
  void moveRotat() {
    // make sure the move is valid befor moving there
    setState(() {
      currentPiece.rotatePiece();
    });
  }

  // clear lines
  void clearLines() {
    // step 1 : Loop through each row of the game board from bottom to top
    for (int row = collLength - 1; row >= 0; row--) {
      // stip 2 : Initialize a variable to track if the row is full
      bool rowIsFull = true;

      // step 3 : Check if the row if fluu (all col in the row are filled with pieces
      for (int col = 0; col < rowLength; col++) {
        // if there is an empty col, set rowIsFull to false and break the loop
        if (gameBoard[row][col] == null) {
          rowIsFull = false;
          break;
        }
      }

      // step 4 : if the row is , clear the row and shift row and shift rows down
      if (rowIsFull) {
        // step 5 : move all rows above the clear row down by one position
        for (int r = row; r > 0; r--) {
          // copy the bove row to the current row
          gameBoard[r] = List.from(gameBoard[r - 1]);
        }

        // step 6 : set the top row to empty
        gameBoard[0] = List.generate(rowLength, (index) => null);

        // step 7 : Increase the score
        currentScore++;
      }
    }
  }

  // Game Over Methoo
  bool isGameOver() {
    // check if any colums in the top are filled
    for (int col = 0; col < rowLength; col++) {
      // first row , any col
      if (gameBoard[0][col] != null) {
        return true;
      }
    }

    // if the top row is empty, the game is not over
    return false;
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    /*24 is for notification bar on Android*/
    // kToolbarHeight >> The height of the toolbar component of the [AppBar].
    final double itemHeight = (((size.height / 15 ) * 12 ) / collLength ) - 2 ;
    final double itemWidth = size.width / rowLength;

    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          // game Grid > 10
          Expanded(
            flex: 12 ,
            child: GridView.count(
              // Not Scrolle
              physics: const NeverScrollableScrollPhysics(),
              // width == height >> is Defoult in GridView.build
              // childAspectRatio >> width != height >> is Defoult in GridView.count
              childAspectRatio: (itemWidth / itemHeight),
              shrinkWrap: true,
              crossAxisCount: rowLength,
              // Distribution of parts
              children: List.generate(
                rowLength * collLength,
                (index) {
                  //get rpw and col of each index
                  int row = (index / rowLength).floor();
                  int col = index % rowLength;

                  // current piece
                  if (currentPiece.position.contains(index)) {
                    return Pixel(
                      color: currentPiece.color,
                    );
                  } else if (gameBoard[row][col] != null) {
                    final Tetromino? tetromino = gameBoard[row][col];
                    return Pixel(
                      color: tetrominoColors[tetromino],
                    );
                  }
                  // black pixel
                  else {
                    return Pixel(
                      color: Colors.grey[900],
                    );
                  }
                },
              ),
            ),
          ),

          // SCORE > 1
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "Score: " + currentScore.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                TextButton(
                  onPressed: () {
                    // timer.cancel() ; // Stop timer Loop
                    // reset the game
                    resetGameButton();
                  },
                  child: Text(
                    "Reset",
                    style: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Game Controle > 1
          Expanded(
            flex: 1,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // left
                IconButton(
                  onPressed: moveLeft,
                  color: Colors.white,
                  icon: Icon(Icons.keyboard_double_arrow_left_rounded),
                ),

                // rotat
                IconButton(
                  onPressed: moveRotat,
                  color: Colors.white,
                  icon: Icon(Icons.rotate_90_degrees_cw_sharp),
                ),

                // right
                IconButton(
                  onPressed: moveRight,
                  color: Colors.white,
                  icon: Icon(Icons.keyboard_double_arrow_right),
                ),
              ],
            ),
          ),

          Spacer(
            flex: 1 ,
          ),
        ],
      ),
    );
  }
}
