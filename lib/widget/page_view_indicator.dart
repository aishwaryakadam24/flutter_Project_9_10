import 'package:flutter/material.dart';
import '../constants/colors.dart';

class PageViewIndicator extends StatelessWidget {
  final bool selected;
  final double marginEnd;

  PageViewIndicator({
    this.selected = false,
    this.marginEnd = 0,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsetsDirectional.only(end: marginEnd),
      width: selected ? 25 : 8,
      height: 8,
      decoration: BoxDecoration(
        color: selected ? MyColor.orange : Colors.grey[300],
        borderRadius: BorderRadius.circular(4),
        boxShadow: selected ? [
          BoxShadow(
            color: MyColor.orange.withOpacity(0.3),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ] : null,
      ),
    );
  }
}


