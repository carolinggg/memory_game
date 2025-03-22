import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/icons.dart';
import 'card_item.dart';

class Game {
  int gridSize;
  List<CardItem> cards = [];
  bool isGameOver = false;
  Set<ImageProvider> images = {}; // Change to `Set<ImageProvider>`

  Game(this.gridSize) {
    generateCards();
  }

  void generateIcons() {
    images = <ImageProvider>{};
    for (int j = 0; j < (gridSize * gridSize / 2); j++) {
      final ImageProvider image = _getRandomCardImage();
      images.add(image);
      images.add(image);
    }
    print("Images list after generation: ${images.length}"); // Debugging
  }

  ImageProvider _getRandomCardImage() {
    final Random random = Random();
    ImageProvider image;
    do {
      image = cardImage[random.nextInt(cardImage.length)];
    } while (images.contains(image));
    return image;
  }

  void generateCards() {
    generateIcons(); // Ensure `images` is populated
    cards = [];
    final List<Color> cardColors = Colors.primaries.toList();

    for (int i = 0; i < (gridSize * gridSize / 2); i++) {
      if (images.length <= i) {
        // Safety check
        print("Error: Not enough images generated!");
        return;
      }

      int cardValue = i + 1;
      final ImageProvider image = images.elementAt(i);
      final Color cardColor = cardColors[i % cardColors.length];
      final List<CardItem> newCards =
          _createCardItems(image, cardColor, cardValue);
      cards.addAll(newCards);
    }
    cards.shuffle(Random()); // Randomize the cards
  }

  void resetGame() {
    generateCards();
    isGameOver = false;
  }

  List<CardItem> _createCardItems(
      ImageProvider image, Color cardColor, int cardValue) {
    return List.generate(
        2, (index) => CardItem(cardValue, CardState.hidden, image, cardColor));
  }

  void onCardPressed(int index) {
    cards[index].state = CardState.visible;
    List<int> selectedCardIndexes = _getSelectedCardIndexes();
    if (selectedCardIndexes.length == 2) {
      CardItem card1 = cards[selectedCardIndexes[0]];
      CardItem card2 = cards[selectedCardIndexes[1]];

      if (card1.value == card2.value) {
        card1.state = CardState.guessed;
        card2.state = CardState.guessed;
        isGameOver = _isGameOver();
      } else {
        Future.delayed(const Duration(milliseconds: 1000), () {
          card1.state = CardState.hidden;
          card2.state = CardState.hidden;
        });
      }
    }
  }

  List<int> _getSelectedCardIndexes() {
    return cards
        .asMap()
        .entries
        .where((entry) => entry.value.state == CardState.visible)
        .map((entry) => entry.key)
        .toList();
  }

  bool _isGameOver() {
    return cards.every((card) => card.state == CardState.guessed);
  }
}
