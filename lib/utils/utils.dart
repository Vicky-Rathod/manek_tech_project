import 'package:flutter/material.dart';

class ScreenUtils {
  late double _height;
  late double _width;
  late double _paddingTop;
  late double _resposiveConst;
  get mediumSpace => const SizedBox(
        height: 30,
      );

  static final ScreenUtils _getConfig = ScreenUtils._internal();
  get fromPaddingHorizontal => _resposiveConst * 25;
  get fromPaddingHorizontal2 => _resposiveConst * 20;
  get formPaddingVertical => resposiveConst * 40;
  //vertical2 is used forms inside app
  get formPaddingVertical2 => resposiveConst * 20;
  get resposiveConst => _resposiveConst;
  get tempConst => double.parse((12.3412).toStringAsFixed(2));
  get height => _height;
  get width => _width;
  get paddingTop => _paddingTop;
  void setValue(BuildContext context) {
    _getConfig._height = MediaQuery.of(context).size.height;
    _getConfig._width = MediaQuery.of(context).size.width;
    _getConfig._paddingTop = MediaQuery.of(context).padding.top;
    _getConfig._resposiveConst = (_height / _width) / 2.345;
  }

  factory ScreenUtils() {
    return _getConfig;
  }

  ScreenUtils._internal();
}

showSnackBarRed(message, context) {
  SnackBar snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.red,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}

showSnackBarGreen(message, context) {
  SnackBar snackBar = SnackBar(
    content: Text(message),
    backgroundColor: Colors.green,
  );
  ScaffoldMessenger.of(context).showSnackBar(snackBar);
}
