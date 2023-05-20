import 'dart:ui';

import 'package:tetris_game/Constant/values.dart';
import 'package:tetris_game/Screen/board.dart';

class Piece {
  // type of tetries
  Tetromino type ;

  Piece({required this.type}) ;

  // the Piece is just a list of integers >> one Element
  List<int> position = [] ;

  // color of tetris piece
  Color? get color{
    return tetrominoColors[type] ?? Color(0xfffffffff);
  }

  // generate the ints
  void initializePiece(){
    switch(type){
      // pixel > 4 , 14 , 24 , 25 >> -30
      case Tetromino.L :
        position = [-26 , -16 , -6 , -5 ] ;
        break ;
      case Tetromino.J :
        position =  [-25 , -15 , -5 , -6 ] ;
        break ;
      case Tetromino.I :
        position = [ -4 , -5 , -6 , -7 ] ;
        break ;
      case Tetromino.O :
        position = [-15 , -16 , -5 , -6 ] ;
        break ;
      case Tetromino.S :
        position = [-15 , -14 , -6 , -5] ;
        break ;
      case Tetromino.Z :
        position = [-17 , -16 , - 6 ,  -5 ] ;
        break ;
      case Tetromino.T :
        position = [-26 , -16 , -6 , -15] ;
        break ;
      default:
    }
  }

  // move Piece
  void movePiece( Direction direction ){
    switch(direction){
    // move >> position >> +10
      case Direction.down :
        for(int i = 0 ; i < position.length ; i++){
          position[i] += rowLength ;
        }
        break ;
      case Direction.left :
        for(int i = 0 ; i < position.length ; i++){
          position[i] -= 1;
        }
        break ;
      case Direction.right :
        for(int i = 0 ; i < position.length ; i++){
          position[i] += 1 ;
        }
        break ;
      default:
    }
  }

  // rotate piece
  int rotationState = 1 ;
  void rotatePiece(){
    // new Position
    List<int> newPosition = [] ;

    // rotate the Piece bassed on it’s type
    switch(type){
      case Tetromino.L :
        switch(rotationState){
          case 0:
              /*
                0
                0
                0 0
              */
            // get the new Position
            newPosition = [
              position[1] - rowLength ,
              position[1],
              position[1] + rowLength ,
              position[1] +rowLength + 1 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 1:
            /*
                  0 0 0
                  0
            */
            // get the new Position
            newPosition = [
              position[1] - 1 ,
              position[1],
              position[1] + 1 ,
              position[1] + rowLength - 1 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 2:
            /*
                0 0
                  0
                  0
            */
            // get the new Position
            newPosition = [
              position[1] + rowLength ,
              position[1],
              position[1] - rowLength ,
              position[1] - rowLength - 1 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 3:
            /*
                      0
                  0 0 0
            */
            // get the new Position
            newPosition = [
              position[1] - rowLength + 1 ,
              position[1],
              position[1] + 1 ,
              position[1] - 1 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;
        }
        break ;
      case Tetromino.J :
        switch(rotationState){
          case 0:
          /*
                  0
                  0
                0 0
              */
          // get the new Position
            newPosition = [
              position[1] - rowLength ,
              position[1],
              position[1] + rowLength ,
              position[1] +rowLength - 1 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 1:
          /*
                  0
                  0 0 0
            */
          // get the new Position
            newPosition = [
              position[1] - rowLength - 1 ,
              position[1],
              position[1] - 1 ,
              position[1] + 1 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 2:
          /*
                  0 0
                  0
                  0
            */
          // get the new Position
            newPosition = [
              position[1] + rowLength ,
              position[1],
              position[1] - rowLength ,
              position[1] - rowLength + 1 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 3:
          /*
                  0 0 0
                      0
            */
          // get the new Position
            newPosition = [
              position[1] + 1 ,
              position[1],
              position[1] - 1 ,
              position[1] + rowLength + 1 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;
        }
        break ;
      case Tetromino.I :
        switch(rotationState){
          case 0:
            /*
                0 0 0 0
            */
            // get the new Position
            newPosition = [
              position[1] - 1 ,
              position[1],
              position[1] + 1 ,
              position[1] + 2 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 1:
            /*
                  0
                  O
                  0
                  0
            */
            // get the new Position
            newPosition = [
              position[1] - rowLength ,
              position[1],
              position[1] + rowLength ,
              position[1] + 2 * rowLength ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 2:
            /*
                0 0 0 0
            */
            // get the new Position
            newPosition = [
              position[1] - 1 ,
              position[1],
              position[1] + 1 ,
              position[1] + 2 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 3:
            /*
                  0
                  O
                  0
                  0
            */
            // get the new Position
            newPosition = [
              position[1] - rowLength ,
              position[1],
              position[1] + rowLength ,
              position[1] + 2 * rowLength ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;
        }
        break ;
      case Tetromino.O :
        /* The O tetromion does not need to be rotated
            0 0
            0 0
        * */
        break ;
      case Tetromino.S :
        switch(rotationState){
          case 0:
            /*
                     0 0
                   0 0
            */
            // get the new Position
            newPosition = [
              position[1],
              position[1] + 1 ,
              position[1] + rowLength - 1 ,
              position[1] + rowLength ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 1:
            /*
                     0
                     0 0
                       0
            */
            // get the new Position
            newPosition = [
              position[0] - rowLength ,
              position[0],
              position[0] + 1 ,
              position[0] + rowLength + 1 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 2:
          /*
                     0 0
                   0 0
            */
            // get the new Position
            newPosition = [
              position[1],
              position[1] + 1 ,
              position[1] + rowLength - 1 ,
              position[1] + rowLength ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 3:
            /*
                     0
                     0 0
                       0
            */
            // get the new Position
            newPosition = [
              position[0] - rowLength ,
              position[0],
              position[0] + 1 ,
              position[0] + rowLength + 1 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;
        }
        break ;
      case Tetromino.Z :
        switch(rotationState){
          case 0:
            /*
               0 0
                 0 0
            */
            // get the new Position
            newPosition = [
              position[0] + rowLength - 2 ,
              position[1],
              position[2] + rowLength - 1 ,
              position[3] + 1 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 1:
            /*
               0
               0 0
                 0
            */
            // get the new Position
            newPosition = [
              position[0] - rowLength + 2 ,
              position[1],
              position[2] - rowLength + 1 ,
              position[3] - 1 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 2:
            /*
               0 0
                 0 0
            */
            // get the new Position
            newPosition = [
              position[0] + rowLength - 2 ,
              position[1],
              position[2] + rowLength - 1 ,
              position[3] + 1 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 3:
            /*
               0
               0 0
                 0
            */
            // get the new Position
            newPosition = [
              position[0] - rowLength + 2 ,
              position[1],
              position[2] - rowLength + 1 ,
              position[3] - 1 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;
        }
        break ;
      case Tetromino.T :
        switch(rotationState){
          case 0:
            /*
                0
                0 0
                0
            */
            // get the new Position
            newPosition = [
              position[2] - rowLength ,
              position[2],
              position[2] + 1 ,
              position[2] + rowLength ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 1:
            /*
              0 0 0
                0
            */
            // get the new Position
            newPosition = [
              position[1] - 1 ,
              position[1],
              position[1] + 1 ,
              position[1] + rowLength ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 2:
            /*
                0
              0 0
                0
            */
            // get the new Position
            newPosition = [
              position[1] - rowLength ,
              position[1] - 1 ,
              position[1],
              position[1] + rowLength ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;

          case 3:
            /*
                0
              0 0 0
            */
            // get the new Position
            newPosition = [
              position[2] - rowLength ,
              position[2] - 1 ,
              position[2],
              position[2] + 1 ,
            ] ;
            // check this new position is a valid move befor assiging it to the real position
            if(piecePositionIsValid(newPosition)){
              // ubdate position
              position = newPosition ;
              // ubdate rotate state
              rotationState = (rotationState + 1 ) % 4 ;
            }
            break ;
        }
        break ;
      default:
    }
  }

  // check if valid position
  bool positionIsValid(int position){
    // get the row and col of position
    int row = (position / rowLength).floor() ;
    int col = position % rowLength ;

    //if thwe position is taken , return false
    if(row < 0 || col < 0 || gameBoard[row][col] != null ){
      return false ;
    }
    return true ;
  }

  // check if piece is valid position
  bool piecePositionIsValid(List<int> piecePosition) {
    bool firstColOccupid = false;
    bool lastColOccupid = false;

    for (int pos in piecePosition) {
      // eturn false if any position is already task
      if (!positionIsValid(pos)) {
        return false;
      }

      // get the col of position
      int col = pos % rowLength;

      // check if the first or last col is occuipied
      if (col == 0) {
        firstColOccupid = true;
      }
      if (col == rowLength - 1) {
        lastColOccupid = true;
      }
    }

    // if there is a piece in first col and last col, it is going through the wall
    return !(firstColOccupid && lastColOccupid) ;
  }
}