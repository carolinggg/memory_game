import 'package:flutter/material.dart';

import '../../models/card_item.dart';

class MemoryCard extends StatelessWidget {
  final CardItem card;
  final Function(int) onCardPressed;
  final int index;

  const MemoryCard(
      {Key? key,
      required this.card,
      required this.index,
      required this.onCardPressed})
      : super(key: key);

  void handeCardTap() {
    if (card.state == CardState.hidden) {
      onCardPressed(index);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: handeCardTap,
      child: Card(
        margin: EdgeInsets.all(4),
        elevation: 4,
        clipBehavior: Clip.antiAlias,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        color:
            card.state == CardState.visible || card.state == CardState.guessed
                ? card.color
                : const Color.fromARGB(255, 218, 169, 243),
        child: Center(
          child: card.state == CardState.hidden
              ? null
              : LayoutBuilder(builder: (context, constraint) {
                  return Image(
                    image: card.icon, // Use `ImageProvider`
                    height: constraint.biggest.height * 0.8,
                    fit: BoxFit.contain,
                  );
                }),
        ),
      ),
    );
  }
}
