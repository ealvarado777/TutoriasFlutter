import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AppSpinKitLoadings {
  static final spinkitSquareCircle = SpinKitSquareCircle(
    size: 400,
    itemBuilder: (BuildContext context, int index) {
      return DecoratedBox(
        decoration: BoxDecoration(
          color: index.isEven ? Color.fromRGBO(244, 67, 54, 1) : Colors.green,
        ),
      );
    },
  );

  static const spinkitSpiningLines =
      SpinKitSpinningLines(color: Colors.blue, size: 400, lineWidth: 10);

  static final spinkitWave = SpinKitWaveSpinner(
    color: Colors.blue,
    child: Image.asset('assets/images/camaronLoading.gif'), //spinkit1,
    size: 400,
    waveColor: const Color.fromARGB(137, 12, 177, 223),
    trackColor: const Color.fromARGB(137, 12, 177, 223),
  );
}
