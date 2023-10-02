// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressBarCustom extends StatelessWidget {
  double width;
  
  int value;
  int totalValue;

  ProgressBarCustom({
    super.key, 
    this.width = 0, 
    this.value = 0, 
    this.totalValue = 0
  });

  @override
  Widget build(BuildContext context) {
    double ratio = value / totalValue;

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Stack(
          children: [
            Container(
              width: width,
              height: 10,
              decoration: BoxDecoration(color: Colors.grey[300]),
            ),
            
            Material(
              borderRadius: BorderRadius.circular(5),
              child: AnimatedContainer(
                height: 10,
                width: width * ratio,
                duration: Duration(milliseconds: totalValue),

                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(5),

                  color: (ratio < 0.3) ?
                    Colors.red : (ratio < 0.6) ?
                    Colors.orange : (ratio < 0.9) ?
                    Colors.amber : Colors.green,
                )
              ),
            ),
          ],
        )
      ]
    );
  }
}

class TimeState with ChangeNotifier {
  int _time = 100;
  int get time => _time;

  set time(int newTime) {
    _time = newTime;
    notifyListeners();
  }
}