import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('2048小遊戲'),
        ),
        body: Game2048(),
      ),
    );
  }
}

class Game2048 extends StatefulWidget {
  @override
  _Game2048State createState() => _Game2048State();
}

class _Game2048State extends State<Game2048> {
  List<List<int>> board = List.generate(4, (i) => List.generate(4, (j) => 0));
  Random random = Random();

  @override
  void initState() {
    super.initState();
    generateRandomTile();
    generateRandomTile();
  }

  void generateRandomTile() {
    List<int> emptyTiles = [];
    for (int i = 0; i < 4; i++) {
      for (int j = 0; j < 4; j++) {
        if (board[i][j] == 0) {
          emptyTiles.add(i * 4 + j);
        }
      }
    }

    if (emptyTiles.isEmpty) {
      // Game over
      // Handle game over logic here
      print('Game Over!');
      // Show a dialog or take appropriate action
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('遊戲結束'),
            content: Text('沒有更多的空位，遊戲結束。'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('確定'),
              ),
            ],
          );
        },
      );
      return;
    }

    int index = emptyTiles[random.nextInt(emptyTiles.length)];
    int i = index ~/ 4;
    int j = index % 4;

    board[i][j] = random.nextInt(5) == 0 ? 4 : 2; // Adjusted probability
  }

  void swipe(Direction direction) {
    setState(() {
      switch (direction) {
        case Direction.up:
          swipeUp();
          break;
        case Direction.down:
          swipeDown();
          break;
        case Direction.left:
          swipeLeft();
          break;
        case Direction.right:
          swipeRight();
          break;
      }

      generateRandomTile();
    });
  }

  void swipeUp() {
    for (int j = 0; j < 4; j++) {
      List<int> column = [];
      for (int i = 0; i < 4; i++) {
        column.add(board[i][j]);
      }
      column = mergeTiles(column);
      for (int i = 0; i < 4; i++) {
        board[i][j] = column[i];
      }
    }
  }

  void swipeDown() {
    for (int j = 0; j < 4; j++) {
      List<int> column = [];
      for (int i = 3; i >= 0; i--) {
        column.add(board[i][j]);
      }
      column = mergeTiles(column);
      for (int i = 3; i >= 0; i--) {
        board[i][j] = column[3 - i];
      }
    }
  }

  void swipeLeft() {
    for (int i = 0; i < 4; i++) {
      List<int> row = [];
      for (int j = 0; j < 4; j++) {
        row.add(board[i][j]);
      }
      row = mergeTiles(row);
      for (int j = 0; j < 4; j++) {
        board[i][j] = row[j];
      }
    }
  }

  void swipeRight() {
    for (int i = 0; i < 4; i++) {
      List<int> row = [];
      for (int j = 3; j >= 0; j--) {
        row.add(board[i][j]);
      }
      row = mergeTiles(row);
      for (int j = 3; j >= 0; j--) {
        board[i][j] = row[3 - j];
      }
    }
  }

  List<int> mergeTiles(List<int> line) {
    List<int> result = [];
    for (int i = 0; i < line.length; i++) {
      if (line[i] != 0) {
        if (result.length > 0 && result.last == line[i]) {
          // Merge tiles if they are the same
          result[result.length - 1] *= 2;
        } else {
          // Move the tile to the left
          result.add(line[i]);
        }
      }
    }
    while (result.length < 4) {
      // Fill the remaining spaces with zeros
      result.add(0);
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          // 向下滑動
          swipe(Direction.down);
        } else if (details.primaryVelocity! < 0) {
          // 向上滑動
          swipe(Direction.up);
        }
      },
      onHorizontalDragEnd: (details) {
        if (details.primaryVelocity! > 0) {
          // 向右滑動
          swipe(Direction.right);
        } else if (details.primaryVelocity! < 0) {
          // 向左滑動
          swipe(Direction.left);
        }
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            // 顯示遊戲棋盤
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemBuilder: (context, index) {
                int i = index ~/ 4;
                int j = index % 4;
                return Container(
                  decoration: BoxDecoration(
                    color: getTileColor(board[i][j]),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Center(
                    child: Text(
                      board[i][j] != 0 ? board[i][j].toString() : '',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
              },
              itemCount: 16,
            ),
            SizedBox(height: 16.0),
            ElevatedButton(
              onPressed: () {
                // 重新開始遊戲
                setState(() {
                  board = List.generate(4, (i) => List.generate(4, (j) => 0));
                  generateRandomTile();
                  generateRandomTile();
                });
              },
              child: Text('重新開始!'),
            ),
          ],
        ),
      ),
    );
  }

  Color getTileColor(int value) {
    switch (value) {
      case 2:
        return Colors.orange;
      case 4:
        return Colors.deepOrange;
      case 8:
        return Colors.red;
      case 16:
        return Colors.pink;
      case 32:
        return Colors.purple;
      case 64:
        return Colors.deepPurple;
      case 128:
        return Colors.indigo;
      case 256:
        return Colors.blue;
      case 512:
        return Colors.lightBlue;
      case 1024:
        return Colors.cyan;
      case 2048:
        return Colors.teal;
      default:
        return Colors.grey;
    }
  }
}

enum Direction {
  up,
  down,
  left,
  right,
}
