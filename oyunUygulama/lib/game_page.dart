import 'package:flutter/material.dart';
import 'dart:math';

class GamePage extends StatefulWidget {
  const GamePage({super.key});

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  int num1 = 0;
  int num2 = 0;
  int correctAnswer = 0;
  int? selectedAnswer;
  int score = 0;

  int difficultyLevel = 1;

  @override
  void initState() {
    super.initState();
    generateQuestion();
  }

  void generateQuestion() {
    final random = Random();

    int maxRange = difficultyLevel == 1
        ? 50
        : difficultyLevel == 2
            ? 100
            : 200;
    num1 = random.nextInt(maxRange) + 1;
    num2 = random.nextInt(maxRange) + 1;
    correctAnswer = num1 + num2;
    selectedAnswer = null;
  }

  void checkAnswer(int answer) {
    setState(() {
      selectedAnswer = answer;
      if (answer == correctAnswer) {
        score++;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Tebrikler! Doğru cevap!'),
            backgroundColor: Colors.green,
          ),
        );
        generateQuestion();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Üzgünüm, yanlış cevap!'),
            backgroundColor: Colors.red,
          ),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepPurpleAccent.shade100,
      appBar: AppBar(
        title: const Text('Geri Dönmek İçin Dokun'),
        backgroundColor: Colors.deepPurple,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Display score
            Text('Skor: $score',
                style: const TextStyle(fontSize: 20, color: Colors.white)),
            const SizedBox(height: 20),

            Text(
              '$num1 + $num2 = ?',
              style: const TextStyle(fontSize: 36, color: Colors.white),
            ),
            const SizedBox(height: 20),

            Wrap(
              alignment: WrapAlignment.center,
              spacing: 20,
              runSpacing: 20,
              children: [
                for (var answer in getAnswerChoices())
                  ElevatedButton(
                    onPressed: selectedAnswer == null
                        ? () => checkAnswer(answer)
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: selectedAnswer == answer
                          ? answer == correctAnswer
                              ? Colors.green
                              : Colors.red
                          : Colors.deepPurple, // Seçilen cevap farklı renkte
                      foregroundColor: Colors.white, // Buton yazı rengi
                    ),
                    child: Text('$answer'),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  List<int> getAnswerChoices() {
    List<int> choices = [correctAnswer];
    while (choices.length < 4) {
      int randomChoice =
          correctAnswer + (Random().nextInt(20) - 10); // +/- 10 range
      if (randomChoice != correctAnswer && !choices.contains(randomChoice)) {
        choices.add(randomChoice);
      }
    }
    choices.shuffle();
    return choices;
  }
}
