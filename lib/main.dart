import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(const GameApp());
}

class GameApp extends StatelessWidget {
  const GameApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyGame(),
    );
  }
}

class MyGame extends StatefulWidget {
  const MyGame({super.key});

  @override
  State<MyGame> createState() => _MyGameState();
}

class _MyGameState extends State<MyGame> {
  var imageIdex1 = 2;
  var imageIdex2 = 2;

  Future<void> sleep(Duration duration) {
    return Future.delayed(duration);
  }

  Future<void> alternateImage(
      Function(int) setImage, Function(int) setImage2) async {
    for (int i = 0; i < 50; i++) {
      setState(() {
        setImage(Random().nextInt(6) + 1);
        setImage2(Random().nextInt(6) + 1);
      });
      await sleep(const Duration(milliseconds: 100));
    }
  }

  void setImage1(int value) {
    setState(() {
      imageIdex1 = value;
    });
  }

  void setImage2(int value) {
    setState(() {
      imageIdex2 = value;
    });
  }


  Widget buildDie(int value) {
    final color = Color.fromRGBO(
      Random().nextInt(256),
      Random().nextInt(256),
      Random().nextInt(256),
      1,
    );

    return KeyedSubtree(
      key: ValueKey(value),
      child: Container(
        width: 100,
        height: 100,
        color: color, 
        alignment: Alignment.center,
        child: Text(
          '$value',
          style: const TextStyle(
            fontSize: 30.0,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.red,
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0.0),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: buildDie(imageIdex1),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 70.0,
                    ),
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 0.0),
                        child: AnimatedSwitcher(
                          duration: const Duration(milliseconds: 500),
                          child: buildDie(imageIdex2),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                    child: Image.asset('images/dice$imageIdex1.png'),
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(16.0, 0, 16.0, 16.0),
                    child: Image.asset('images/dice$imageIdex2.png'),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20.0,
            ),
            ElevatedButton(
              style: const ButtonStyle(
                mouseCursor: WidgetStateMouseCursor.clickable,
              ),
              onPressed: () {
                alternateImage(setImage1, setImage2);
              },
              child: const Padding(
                padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
                child: Text(
                  'Play !',
                  style: TextStyle(fontSize: 25.0),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
