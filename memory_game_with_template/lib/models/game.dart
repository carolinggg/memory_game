import 'dart:async';
import 'dart:math';
import 'package:flutter/material.dart';
import '../utils/icons.dart'; // Ensure this file has `cardIcons`
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
      image = cardIcons[random.nextInt(cardIcons.length)];
    } while (images.contains(image));
    return image;
  }

  void generateCards() {
    generateIcons(); // Ensure `images` is populated
    cards = [];
    final List<Color> cardColors = Colors.primaries.toList();

    for (int i = 0; i < (gridSize * gridSize / 2); i++) {
      if (images.length <= i) { // Safety check
        print("Error: Not enough images generated!");
        return;
      }

      int cardValue = i + 1;
      final ImageProvider image = images.elementAt(i);
      final Color cardColor = cardColors[i % cardColors.length];
      final List<CardItem> newCards = _createCardItems(image, cardColor, cardValue);
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

// import 'dart:async';
// import 'dart:math';
// import 'package:flip_match/models/card_item.dart';

// class Game {
//   int gridSize; // Size of the game grid (e.g., 4 for a 4x4 grid)
//   List<CardItem> cards = []; // List to store all game cards
//   bool isGameOver = false; // Flag to check if the game is over
//   int time = 0; // Timer (not used currently)

//   Game(this.gridSize) {
//     generateCards(); // Generate the cards when game initializes
//   }

//   // Function to generate card pairs and shuffle them
//   void generateCards() {
//     cards = [];

//     // Create pairs of matching cards
//     for (int i = 0; i < (gridSize * gridSize / 2); i++) {
//       int cardValue = i + 1;
//       cards.add(CardItem(cardValue, state: CardState.hidden)); // First card of the pair
//       cards.add(CardItem(cardValue, state: CardState.hidden)); // Second card of the pair
//     }
    
//     cards.shuffle(Random()); // Shuffle the cards to randomize their positions
//   }

//   // Function to reset the game
//   void resetGame() {
//     generateCards(); // Regenerate shuffled cards
//     isGameOver = false; // Reset game status
//     time = 0; // Reset timer
//   }

//   // Function to handle card selection
//   void onCardPressed(int index) {
//     cards[index].state = CardState.visible; // Make the selected card visible
//     List<int> selectedCardIndexes = _getSelectedCardIndexes(); // Get visible cards

//     if (selectedCardIndexes.length == 2) { // If two cards are selected
//       CardItem card1 = cards[selectedCardIndexes[0]];
//       CardItem card2 = cards[selectedCardIndexes[1]];

//       if (card1.value == card2.value) { // If cards match
//         card1.state = CardState.guessed;
//         card2.state = CardState.guessed;
//         isGameOver = _isGameOver(); // Check if all pairs are found
//       } else { // If cards don't match, hide them after a delay
//         Future.delayed(const Duration(milliseconds: 1000), () {
//           card1.state = CardState.hidden;
//           card2.state = CardState.hidden;
//         });
//       }
//     }
//   }

//   // Function to get indexes of currently visible (selected) cards
//   List<int> _getSelectedCardIndexes() {
//     List<int> selectedCardIndexes = [];
//     for (int i = 0; i < cards.length; i++) {
//       if (cards[i].state == CardState.visible) { // Check if the card is visible
//         selectedCardIndexes.add(i);
//       }
//     }
//     return selectedCardIndexes;
//   }

//   // Function to check if the game is over (all cards guessed)
//   bool _isGameOver() {
//     for (int i = 0; i < cards.length; i++) {
//       if (cards[i].state == CardState.hidden) { // If any card is still hidden, game is not over
//         return false;
//       }
//     }
//     return true; // If no hidden cards remain, the game is over
//   }
// }
