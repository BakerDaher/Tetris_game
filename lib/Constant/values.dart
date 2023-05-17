import 'dart:ui';

const int rowLength = 10 ;
const int collLength = 15 ;

enum Direction{
  left,  // -1
  right, // +1
  down,  // +10 > rowLength
}

enum Tetromino{
  L,
  J,
  I,
  O,
  S,
  Z,
  T
}
/*

  0
  0
  0 0

    0
    0
  0 0

  0
  O
  0
  0

  0 0
  0 0

    0 0
  0 0

  0 0
    0 0

  0
  0 0
  0

*/

const Map<Tetromino , Color> tetrominoColors = {
  Tetromino.L : Color(0xffffa500) , // Orange
  Tetromino.J : Color.fromARGB(255,0, 102, 255) , // Blue
  Tetromino.I : Color.fromARGB(255,242, 0, 255) , // Pin;
  Tetromino.O : Color(0xffffff00) , // Yalow
  Tetromino.S : Color(0xff008000) , // Green
  Tetromino.Z : Color(0xffff0000) , // red
  Tetromino.T : Color.fromARGB(255,144, 0, 255) , // Purple
} ;