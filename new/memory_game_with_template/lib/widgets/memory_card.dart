import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/card_item.dart';
import '../style/palette.dart';

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
    final palette = context.watch<Palette>();
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
                : palette.trueWhite,
        child: Center(
          child: card.state == CardState.hidden
              ? Image.asset('assets/images/card.png')
              : LayoutBuilder(builder: (context, constraint) {
                  return Image(
                    image: card.icon,
                    height: constraint.biggest.height * 0.8,
                    fit: BoxFit.contain,
                  );
                }),
        ),
      ),
    );
  }
}
