import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String day;
  final double value;
  final double percentege;

  ChartBar({this.day, this.value, this.percentege});

  double get _percentegeFormated {
    return (percentege * 100);
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (ctx, constraints) {
      return Column(
        children: [
          Container(
            height: constraints.maxHeight * 0.15,
            margin: EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 3,
            ),
            child: FittedBox(
              child: Text('${_percentegeFormated.toStringAsFixed(2)}%'),
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.6,
            width: 10,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.grey,
                      width: 1.0,
                    ),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(5),
                  ),
                ),
                FractionallySizedBox(
                  heightFactor: percentege,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: constraints.maxHeight * 0.05),
          Container(
            height: constraints.maxHeight * 0.15,
            child: FittedBox(
              child: Text('${day}'),
            ),
          )
        ],
      );
    });
  }
}
